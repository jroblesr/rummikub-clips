#!/usr/bin/env python3

###
### (Rummikub.py)
###
### Sistema Experto en CLIPS para jugar al Rummikub
###

# Cargamos librerías estandar necesarias.
import tkinter as tk
import tkinter.messagebox as tkmessage
import re

# Cargamos librerías y funciones propias.
import VariablesYFunciones as aux
import ReadClipsSourcesAndDefineRouters as clipsprogram

# Cargamos el diseño de la GUI
import RummikubUI as UI

class Rummikub(UI.RummikubUI):

    ultimo_texto = None

    def __init__(self, master=None):
        super().__init__(master)
        self._connect_callbacks()
        self.maquina_fichas_visibles = True
        self._textos_ocultos_maquina = []
        self._connect_shortcuts()

    def _connect_callbacks(self):
        """Conecta los callbacks de los widgets a sus métodos correspondientes."""
        self.bbt_reglas.configure (command=self.mostrar_reglas)
        self.bbt_nueva.configure  (command=self.nueva_partida)
        self.bbt_salir.configure  (command=self.confirmar_salir)        
        self.bbt_ayuda.configure  (command=self.mostrar_ayuda)
        self.bbt_mostrar.configure(command=self.mostrar_info)
        self.bbt_robar.configure  (command=self.robar_ficha)
        self.bbt_atras.configure  (command=self.deshacer_atras)
        self.bbt_ok.configure     (command=self.ok_listo)
        for fila in self.mesa_botones:
            for btn in fila:
                btn_id = btn.winfo_name()
                btn.configure(command=lambda bid=btn_id: self.mesa_pulsada(bid))
        for fila in self.tablilla_maquina_botones:
            for btn in fila:
                btn.configure(command=self.toggle_visibilidad_fichas_maquina)

    def _connect_shortcuts(self):
        """Conecta atajos de teclado a sus métodos correspondientes."""
        self.bind('<Control-Return>', self.ok_listo)        # Enter para OK
        self.bind('<Control-n>',      self.nueva_partida)   # Ctrl+N para Nueva Partida
        self.bind('<Control-q>',      self.confirmar_salir) # Ctrl+Q para Salir
        self.bind('<Escape>',         self.deshacer_atras)  # Escape para Atrás/Deshacer
        self.bind('<Control-r>',      self.robar_ficha)     # Ctrl-R para Robar

    def buscar_boton_por_id(self, widget_id):
        # Buscar en la tablilla
        if widget_id.startswith('tablilla_'):
            try:
                _, i, j = widget_id.split('_')
                return self.tablilla_botones[int(i)][int(j)]
            except Exception:
                return None
        # Buscar en la mesa
        if widget_id.startswith('mesa_'):
            try:
                _, i, j = widget_id.split('_')
                return self.mesa_botones[int(i)][int(j)]
            except Exception:
                return None
        return None

    def drop_ficha(self, source_widget, target_widget):
        """
        Maneja el evento de 'soltar' una ficha en un destino.
        Ahora contempla mover fichas dentro de la mesa o devolverlas a la tablilla.
        """
        # Si el origen y el destino son el mismo, no hacer nada
        if source_widget == target_widget:
            return

        # Guardar propiedades del origen y destino para intercambiarlas
        source_props = {
            "text": source_widget.cget('text'),
            "font": source_widget.cget('font'),
            "fg": source_widget.cget('fg'),
            "state": source_widget.cget('state')
        }
        target_props = {
            "text": target_widget.cget('text'),
            "font": target_widget.cget('font'),
            "fg": target_widget.cget('fg'),
            "state": target_widget.cget('state')
        }

        # Intercambiar las propiedades de los widgets
        target_widget.config(text=source_props['text'], 
                                font=source_props['font'], 
                                fg=source_props['fg'], 
                                state='normal')
        source_widget.config(text=target_props['text'], 
                                font=target_props['font'], 
                                fg=target_props['fg'], 
                                state=target_props['state'])

        # --- Lógica para mostrar/ocultar bordes en la mesa ---
        # Después del intercambio, actualizamos los bordes de ambos widgets si pertenecen a la mesa de juego.
        for widget in [source_widget, target_widget]:
            if widget.winfo_name().startswith('mesa_'):
                # Si el botón de la mesa tiene una ficha, muestra el borde.
                if widget.cget('text'):
                    widget.config(borderwidth=1, relief=tk.SOLID)
                # Si el botón de la mesa está vacío, oculta el borde.
                else:
                    widget.config(borderwidth=0, relief=tk.FLAT)
            # Los botones de la tablilla siempre tienen su borde por defecto
            elif widget.winfo_name().startswith('tablilla_'):
                widget.config(borderwidth=1, relief=tk.RAISED)

    def mesa_pulsada(self, widget_id):
        widget = self.buscar_boton_por_id(widget_id)
        if widget:
            texto_anterior = widget.cget('text')
            if texto_anterior != '':
                # Restablece el botón de la mesa
                widget.config(text='', 
                              font=self.color_config['default']['font'], 
                              fg='black')
                # Buscar y reactivar el botón original en la tablilla
                for fila in self.tablilla_botones:
                    for btn in fila:
                        if (btn.cget('text') == '' 
                            and btn.cget('state') == 'disabled'):
                            btn.config(text=texto_anterior, state='normal')
                            return # Salir tras encontrar y restaurar la ficha
                        
    # COMIENZO DE LAS ACCIONES DE LOS BOTONES:
    
    def _append_text_to_log(self, text):
        """Inserta texto en el área de texto y hace scroll hasta el final."""
        self.text_area.insert(tk.END, text)
        self.text_area.see(tk.END)
        
    def mostrar_reglas(self, event=None):
        """Muestra las reglas del juego en el área de texto."""
        # El assert que sigue permite evitar el BUCLE SIN FIN de juego
        # (pedir-comando + ejecutar-comando) del SHELL de CLIPS.
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))')
        clipsprogram.EntornoClips.eval('(mostrar-reglas)')
        clipsprogram.EntornoClips.eval('(pasar-turno-a humano)')
        clipsprogram.EntornoClips.run()
        self._append_text_to_log("\n\nRUMMIKUB > REGLAS !!!\n\n")
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)

    def comenzar(self):
        clipsprogram.Comenzar() # FULL RESET
        # Esto permite evitar el BUCLE SIN FIN de juego
        # (pedir-comando + ejecutar-comando) del SHELL de CLIPS.
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))') 
        clipsprogram.EntornoClips.run()
        self.mostrar_fichas_humano()
        self.mostrar_fichas_maquina()
        self.mostrar_fichas_tablero()
        self.mostrar_fichas_bolsa()
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)

    def nueva_partida(self, event=None):
        # Lógica para reiniciar el juego
        self._append_text_to_log("\n\n\n\nRUMMIKUB > NUEVA PARTIDA !!!\n\n")
        self.comenzar()

    def confirmar_salir(self, event=None):
        if tkmessage.askyesno('Terminar', 'Está seguro de que quiere terminar?'):
            self.destroy()

    def mostrar_ayuda(self, event=None):
        # Esto permite evitar el BUCLE SIN FIN de juego
        # (pedir-comando + ejecutar-comando) del SHELL de CLIPS.
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))') 
        clipsprogram.EntornoClips.eval('(mostrar-ayuda)')
        clipsprogram.EntornoClips.eval('(mostrar-fichas tablero)')
        clipsprogram.EntornoClips.eval('(mostrar-fichas maquina)')
        clipsprogram.EntornoClips.eval('(mostrar-fichas humano)')
        clipsprogram.EntornoClips.eval('(pasar-turno-a humano)')
        clipsprogram.EntornoClips.run()
        self._append_text_to_log("\n\nRUMMIKUB > AYUDA !!!\n\n")
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)

    def mostrar_info(self, event=None):
        # Esto permite evitar el BUCLE SIN FIN de juego 
        # (pedir-comando + ejecutar-comando) del SHELL de CLIPS.
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))') 
        clipsprogram.EntornoClips.eval('(mostrar-fichas tablero)')
        clipsprogram.EntornoClips.eval('(mostrar-fichas maquina)')
        clipsprogram.EntornoClips.eval('(mostrar-fichas humano)')
        clipsprogram.EntornoClips.eval('(pasar-turno-a humano)')
        clipsprogram.EntornoClips.run()
        self._append_text_to_log("\n\nRUMMIKUB > MOSTRAR !!!\n\n")
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)        

    def robar_ficha(self, event=None):
        # Esto permite evitar el BUCLE SIN FIN de juego
        # (pedir-comando + ejecutar-comando) del SHELL de CLIPS.
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))') 
        clipsprogram.EntornoClips.eval('(robar-ficha-humano (obtener-siguiente-secuencia))')        
        clipsprogram.EntornoClips.eval('(pasar-turno-a maquina)')
        clipsprogram.EntornoClips.run()
        self.mostrar_fichas_humano()
        self.mostrar_fichas_maquina()        
        self.mostrar_fichas_tablero()
        self.mostrar_fichas_bolsa()
        self._append_text_to_log("\n\nRUMMIKUB > ROBAR !!!\n\n")
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)        

    def deshacer_atras(self, event=None):
        """Este comando no se ejecuta en CLIPS. Sólo desde Python"""
        # En definitiva es volver a mostrar la pantalla con el último estado de las fichas.
        self.mostrar_fichas_humano()
        self.mostrar_fichas_maquina()        
        self.mostrar_fichas_tablero()
        self.mostrar_fichas_bolsa()
        self._append_text_to_log("\n\nRUMMIKUB > DESHACER !!!\n\n")

    def ok_listo(self, event=None):
        # Recorrer el tablero para extraer los bloques de fichas (jugadas)
        jugadas_en_mesa = []
        for i, fila_botones in enumerate(self.mesa_botones):
            bloque_actual = []
            for j, btn in enumerate(fila_botones):
                texto_ficha = btn.cget('text')
                if texto_ficha:
                    # Si el botón tiene una ficha, la añadimos al bloque actual junto con su fila y columna.
                    info_ficha = {'texto': texto_ficha, 'fila': i, 'col': j}
                    bloque_actual.append(info_ficha)
                else:
                    # Si encontramos un hueco y estábamos formando un bloque, lo guardamos
                    if bloque_actual:
                        jugadas_en_mesa.append(bloque_actual)
                        bloque_actual = []
            # Al final de la fila, si queda un bloque por 
            # guardar (termina en el borde)
            if bloque_actual:
                jugadas_en_mesa.append(bloque_actual)

        # Mostramos las jugadas detectadas en la consola, ahora con coordenadas
        print("Jugadas detectadas en la mesa:", jugadas_en_mesa)

        # Comprobar si alguna de las jugadas tiene una longitud menor a 3
        for jugada in jugadas_en_mesa:
            if len(jugada) < 3:
                textos_jugada = [ficha['texto'] for ficha in jugada]
                tkmessage.showwarning(
                    "Jugada no válida",
                    f"Todas las jugadas deben tener al menos 3 fichas.\n"
                    f"Se ha detectado al menos una jugada con"
                    f" {len(jugada)} ficha(s): {', '.join(textos_jugada)}"
                )
                self.mostrar_fichas_humano()
                self.mostrar_fichas_tablero()
                return # Detener la ejecución si la jugada no es válida

        # Una vez hecha la comprobación más básica (3 elementos por bloque)
        # Vamos dando de alta las jugadas en el tablero temporal para validarlo.
        # Una vez cargado el tablero temporal, lo validamos.

        # Tenemos que crear los hechos del tablero temporal
        # para poder validarlo.                
        clipsprogram.EntornoClips.eval('(assert (con-interfaz-grafica))')
        clipsprogram.EntornoClips.eval('(iniciar-validacion-tablero-temporal)')

        # Mapeo inverso de letra a color y de símbolo a número de bloque
        letras_a_color = {v: k for k, v in self._letras.items()}
        simbolo_a_bloque = {"'": 1, ".": 2}

        for jugada in jugadas_en_mesa:
            clipsprogram.EntornoClips.eval('(obtener-siguiente-secuencia)')
            for ficha in jugada:
                texto_ficha = ficha['texto']
                fila = ficha['fila']
                columna = ficha['col']
                # Expresión regular para extraer número, letra de color y símbolo de bloque
                match = re.match(r"(\d+)([AJNRC])(['.])([\+]?)", texto_ficha)
                if match:
                    numero = match.group(1)
                    letra_color = match.group(2)
                    simbolo_bloque = match.group(3)
                    aux = match.group(4)

                    # Convertir la letra y el símbolo a los
                    # valores correspondientes
                    color = letras_a_color.get(letra_color, 'desconocido')
                    bloque = simbolo_a_bloque.get(simbolo_bloque, 0)

                    # Construir y ejecutar el assert para CLIPS
                    comando_assert = f"(assert (ficha-temporal (numero {numero}) (color {color}) (bloque {bloque}) (id-jugada-temp (obtener-valor-actual-secuencia)) (ok-jugada-temp -1) (fila {fila}) (columna {columna})))"
                    print(comando_assert) # Para depuración
                    clipsprogram.EntornoClips.eval(comando_assert)
                else:
                    print("TEXTO FICHA="+texto_ficha+" NO MATCH!!!")

        ## Una vez cargado el tablero temporal. Pasamos a validarlo.
        print("\n--- Hechos '=ficha-temporal' en CLIPS antes de validar ---")
        for fact in clipsprogram.EntornoClips.facts():
            # Imprimimos todos los hechos que no son de tipo 'ficha'
            if fact.template.name == 'ficha-temporal':
                print(fact)
        print("-----------------------------------------------------------\n")
        clipsprogram.EntornoClips.eval('(comprobar-jugadas-tablero-temporal)')
        clipsprogram.EntornoClips.run()

        # Si la jugada que ha indicado el jugador es correcta...
        # ...se habrá confirmado como definitiva y...
        # ...se habrá hecho limpieza de temporales.
        # Echemos un vistazo...
        ## Una vez cargado el tablero temporal. Pasamos a validarlo.
        print("\n--- Hechos en CLIPS despues de validar jugada ---")
        for fact in clipsprogram.EntornoClips.facts():
            if fact.template.name == 'ficha-temporal':
                print(fact)
        print("-----------------------------------------------------------\n")

        # Antes de pasar turno a la máquina. Nos aseguramos que el jugador
        # ha puesto al menos una ficha.
        # Para ello se localizará una ficha del tablero 
        # con un caracter '+' en su texto.
        ha_puesto_ficha_propia = False
        for fila_botones in self.mesa_botones:
            for btn in fila_botones:
                if '+' in btn.cget('text'):
                    ha_puesto_ficha_propia = True
                    break
            if ha_puesto_ficha_propia:
                break
        
        if not ha_puesto_ficha_propia:
            tkmessage.showwarning("Jugada incompleta","Debes jugar al menos una de tus fichas para terminar tu turno.")
            self.deshacer_atras()
            return
            
        clipsprogram.EntornoClips.eval('(pasar-turno-a maquina)')
        clipsprogram.EntornoClips.run()
        # En caso de jugada erronea avisar y esperar que corrija...

        self._append_text_to_log("\n\nRUMMIKUB > OK - LISTO !!!\n\n")
        self._append_text_to_log(clipsprogram.RouterClipsOut.output_stream)        

        self.mostrar_fichas_humano()
        self.mostrar_fichas_maquina()
        self.mostrar_fichas_tablero()
        self.mostrar_fichas_bolsa()

    def toggle_visibilidad_fichas_maquina(self, event=None):
        """Oculta o muestra las fichas en la tablilla de la máquina."""
        if self.maquina_fichas_visibles:
            # Ocultar fichas
            self._textos_ocultos_maquina = []
            for fila_botones in self.tablilla_maquina_botones:
                fila_textos = []
                for btn in fila_botones:
                    fila_textos.append(btn.cget('text'))
                    btn.config(text="")
                self._textos_ocultos_maquina.append(fila_textos)
            self.maquina_fichas_visibles = False
        else:
            # Mostrar fichas
            if self._textos_ocultos_maquina:
                for i, fila_botones in enumerate(self.tablilla_maquina_botones):
                    for j, btn in enumerate(fila_botones):
                        btn.config(text=self._textos_ocultos_maquina[i][j])
                self._textos_ocultos_maquina = []
            self.maquina_fichas_visibles = True


    # FUNCIONES AUXILIARES
    def obtener_fichas_por_ubicacion(self, ubicacion):
            """Obtiene y parsea las fichas de CLIPS para una ubicación específica."""
            fichas = []
            for fact in clipsprogram.EntornoClips.facts():
                if (fact.template.name == 'ficha' 
                    and fact['ubicacion'] == ubicacion):
                    d_ficha = aux.parsear_fact_string(fact.__str__())
                    fichas.append(d_ficha)
            return fichas

    def mostrar_fichas_humano(self):
            """Actualiza la tablilla del jugador con sus fichas actuales."""
            fichas_humano = self.obtener_fichas_por_ubicacion('humano')
            # Ordenar las fichas para una mejor visualización
            # en la tablilla del jugador.
            # Se ordena primero por color y luego por número.
            fichas_humano.sort(key=lambda f: (f.get('color', ''),int(f.get('numero', 0))))
            self._actualizar_tablilla(self.tablilla_botones, fichas_humano)

    def mostrar_fichas_maquina(self):
            """Actualiza la tablilla de la máquina con sus fichas actuales."""
            fichas_maquina = self.obtener_fichas_por_ubicacion('maquina')
            # Antes de actualizar, nos aseguramos de que
            # las fichas sean visibles
            self.maquina_fichas_visibles = True
            self._actualizar_tablilla(self.tablilla_maquina_botones, fichas_maquina)
            self._textos_ocultos_maquina = [] # Limpiamos el backup de textos

    def mostrar_fichas_tablero(self):
            """Actualiza la mesa de juego con las fichas actuales del tablero."""
            fichas_tablero = self.obtener_fichas_por_ubicacion('tablero')
            self._actualizar_mesa(fichas_tablero)

    def mostrar_fichas_bolsa(self):            
            fichas_bolsa = len(self.obtener_fichas_por_ubicacion('bolsa'))
            self._actualizar_fichas_en_bolsa(f"Bolsa: {fichas_bolsa} fichas")


    # EMPIEZA LA DIVERSION
    def run(self):
        self.mainloop()

if __name__ == "__main__":
    app = Rummikub()
    clipsprogram.Comenzar()
    app.run()