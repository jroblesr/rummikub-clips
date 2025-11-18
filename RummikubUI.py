###
### (RummikubUI.py)
###
### Sistema Experto en CLIPS para jugar al Rummikub
###

# Cargamos librerías estandar necesarias.
import tkinter as tk
import tkinter.font as tkfont

# Caragamos librerías y funciones propias.
import DragAndDrop as dad

# CODIGO GENERADO POR IA !!!
class RummikubUI(tk.Tk):

    _letras ={'azul': 'A', 'naranja': 'J', 'negro': 'N', 'rojo': 'R', 'comodin': 'C'}
    # Constantes para las dimensiones de la mesa de juego
    NUM_FILAS_MESA = 20 # Inicialmente 30
    NUM_COLS_MESA  = 35 # Inicialmente 25

    def __init__(self, master=None):
        super().__init__(master)

        self._setup_fonts_and_colors()

        self.configure(height=200, width=500)
        self.title("Rummikub")
        self.frame_full = tk.Frame(self, name="frame_full")
        self.frame_full.configure(height=200, width=200)

        # Frame principal para el área de juego (tablillas y mesa)
        self.frame_juego = tk.Frame(self.frame_full, name="frame_juego")
        self.frame_juego.grid(column=0, row=0, sticky="nsew")
        self.frame_juego.rowconfigure(0, weight=1)  # Tablilla máquina
        self.frame_juego.rowconfigure(1, weight=4)  # Mesa de juego
        self.frame_juego.rowconfigure(2, weight=1)  # Tablilla jugador
        self.frame_juego.columnconfigure(0, weight=1)
        
        # Tablilla de la máquina (superior)
        self.frame_tablilla_maquina = tk.Frame(self.frame_juego, name="frame_tablilla_maquina")
        self.frame_tablilla_maquina.configure(background="#097b1b", height=100, width=200)
        self.frame_tablilla_maquina.grid(column=0, row=0, sticky="nsew")
        self.tablilla_maquina_botones = self._crear_botones_tablilla(self.frame_tablilla_maquina, "maquina", tk.Button)

        # Mesa de juego (central)
        self.frame_mesa = tk.Frame(self.frame_juego, name="frame_mesa")
        self.frame_mesa.configure(background="#f6ff1b", height=200, width=200)
        self.frame_mesa.grid(column=0, row=1, sticky="nsew")

        # Crear matriz de botones para el tablero de fichas
        self.mesa_botones = []
        for i in range(self.NUM_FILAS_MESA):
            self.frame_mesa.rowconfigure(i, weight=1)  # Permite que las filas crezcan
            fila = []
            for j in range(self.NUM_COLS_MESA):
                self.frame_mesa.columnconfigure(j, weight=1)  # Permite que las columnas crezcan
                btn_id = f"mesa_{i}_{j}"
                btn = dad.DraggableButton(self.frame_mesa, name=btn_id, borderwidth=0, relief=tk.FLAT)
                btn.grid(row=i, column=j, padx=0, pady=0, sticky="nsew")  # sticky para expandir
                fila.append(btn)
            self.mesa_botones.append(fila)

        self.frame_botones = tk.Frame(self.frame_full, name="frame_botones")
        self.frame_botones.configure(height=200, width=200)
        self.frame_botones.rowconfigure(5, weight=1)  # Permite que la fila del text_area crezca
        self.l_jugando = tk.Label(self.frame_botones, name="l_jugando")
        self.l_jugando.configure(text='HUMANO contra CLIPS', relief=tk.SOLID, borderwidth=1)
        self.l_jugando.grid(column=0, row=0, sticky="ew")
        self.l_fichas_en_bolsa = tk.Label(self.frame_botones, name="l_fichas_en_bolsa")
        self.l_fichas_en_bolsa.configure(text='<...>', relief=tk.SOLID, borderwidth=1)
        self.l_fichas_en_bolsa.grid(column=0, row=1, sticky="ew")
        self.bbt_reglas = tk.Button(self.frame_botones, name="bbt_reglas", text='REGLAS')
        self.bbt_reglas.grid(column=0, row=2, sticky="ew")
        
        # Frame para los botones superiores (NUEVA PARTIDA, TERMINAR, AYUDA, MOSTRAR)
        self.frame_botones_superiores = tk.Frame(self.frame_botones, name="frame_botones_superiores")
        self.frame_botones_superiores.grid(column=0, row=3, sticky="ew")
        self.frame_botones_superiores.columnconfigure(0, weight=1)
        self.frame_botones_superiores.columnconfigure(1, weight=1)
        
        self.bbt_nueva = tk.Button(self.frame_botones_superiores,   name="bbt_nueva",   text='NUEVA PARTIDA')
        self.bbt_nueva.grid(column=0, row=0, sticky="ew")
        self.bbt_salir = tk.Button(self.frame_botones_superiores,   name="bbt_salir",   text='TERMINAR')
        self.bbt_salir.grid(column=1, row=0, sticky="ew")
        self.bbt_ayuda = tk.Button(self.frame_botones_superiores,   name="bbt_ayuda",   text='AYUDA')
        self.bbt_ayuda.grid(column=0, row=1, sticky="ew")
        self.bbt_mostrar = tk.Button(self.frame_botones_superiores, name="bbt_mostrar", text='MOSTRAR')
        self.bbt_mostrar.grid(column=1, row=1, sticky="ew")

        # Frame para los botones de acción del turno
        self.frame_acciones_turno = tk.Frame(self.frame_botones, name="frame_acciones_turno")
        self.frame_acciones_turno.grid(column=0, row=4, sticky="ew")
        self.frame_acciones_turno.columnconfigure(0, weight=1)
        self.frame_acciones_turno.columnconfigure(1, weight=1)
        self.frame_acciones_turno.columnconfigure(2, weight=1)

        self.bbt_ok = tk.Button(self.frame_acciones_turno,    name="bbt_ok",    text='OK - LISTO')
        self.bbt_ok.grid(column=0, row=0, sticky="ew")
        self.bbt_robar = tk.Button(self.frame_acciones_turno, name="bbt_robar", text='ROBAR')
        self.bbt_robar.grid(column=1, row=0, sticky="ew")
        self.bbt_atras = tk.Button(self.frame_acciones_turno, name="bbt_atras", text='ATRÁS/DESHACER')
        self.bbt_atras.grid(column=2, row=0, sticky="ew")

        # Área de texto para mensajes o salida
        small_font = tkfont.Font(family="Helvetica", size=9)
        self.text_area = tk.Text(self.frame_botones, name="text_area", height=5, width=80, font=small_font)
        self.text_area.grid(column=0, row=5, sticky="nsew", padx=2, pady=2)
        self.frame_botones.grid(column=1, row=0, sticky="nsew")

        # Tablilla del jugador (inferior)
        self.frame_tablilla = tk.Frame(self.frame_juego, name="frame_tablilla")
        self.frame_tablilla.configure(background="#097b1b", height=200, width=200)
        self.frame_tablilla.grid(column=0, row=2, sticky="nsew")
        self.tablilla_botones = self._crear_botones_tablilla(self.frame_tablilla, "tablilla", dad.DraggableButton)

        self.frame_full.grid(column=0, row=0, sticky="nsew")
        # Configurar el peso de las filas y columnas de frame_full
        self.frame_full.rowconfigure(0, weight=1)
        self.frame_full.columnconfigure(0, weight=3) # Área de juego (más ancha)
        self.frame_full.columnconfigure(1, weight=1) # Área de botones
        self.grid_anchor("center")
        self.rowconfigure(0, weight=1)
        self.columnconfigure(0, weight=1)

    def _crear_botones_tablilla(self, parent_frame, prefix, button_class):
        """Crea una matriz de botones para una tablilla."""
        botones = []
        for j in range(20):
            parent_frame.columnconfigure(j, weight=1)
        for i in range(3):
            parent_frame.rowconfigure(i, weight=1)
            fila = []
            for j in range(20):
                btn_id = f"{prefix}_{i}_{j}"
                texto = ""
                btn_config = {}
                # Si es un botón normal (para la máquina), le damos un aspecto plano
                if button_class == tk.Button:
                    btn_config.update({'relief': tk.FLAT, 'borderwidth': 0})

                btn = button_class(parent_frame, name=btn_id, text=texto, **btn_config)                
                btn.grid(row=i, column=j, padx=1, pady=1, sticky="nsew")
                fila.append(btn)
            botones.append(fila)
        return botones

    def _setup_fonts_and_colors(self):
        """Inicializa las fuentes y la configuración de colores para las fichas."""        
        bold_font = tkfont.Font(weight='bold')
        self.color_config = {
            'A': {'font': bold_font, 'fg': 'blue'},
            'J': {'font': bold_font, 'fg': 'orange'},
            'N': {'font': bold_font, 'fg': 'black'},
            'R': {'font': bold_font, 'fg': 'red'},
            'C': {'font': bold_font, 'fg': 'black'},
            'default': {'font': bold_font, 'fg': 'black'}
        }

    def _actualizar_fichas_en_bolsa(self, texto: str):
        """Actualiza el texto de la etiqueta que muestra el número de fichas en la bolsa."""
        self.l_fichas_en_bolsa.config(text=texto)

    def _actualizar_tablilla(self, botones_tablilla, fichas):
        """Actualiza una tablilla (matriz de botones) con una lista de fichas."""
        for i in range(3):
            for j in range(20):
                btn = botones_tablilla[i][j]
                texto = ""
                btn_config = self.color_config['default'].copy()
                btn_config['state'] = 'disabled'

                if fichas:
                    ficha = fichas.pop(0)
                    try:
                        num = int(ficha.get('numero'))
                        color = ficha.get('color')
                        bloque = int(ficha.get('bloque'))
                        ubicacion = ficha.get('ubicacion')
                        letra = self._letras.get(color, '')
                        if bloque == 1:
                            texto = f"{num}{letra}'"
                        else:
                            texto = f"{num}{letra}."

                        if ubicacion == 'humano':
                            texto = texto + '+'

                        btn_config = self.color_config.get(
                            letra, self.color_config['default']).copy()
                        # Los botones DraggableButton (jugador) se habilitan.
                        if isinstance(btn, dad.DraggableButton):
                            btn_config['state'] = 'normal'
                        # Los botones tk.Button (máquina) también deben estar habilitados para poder pulsarlos.
                        else:
                            btn_config['state'] = 'normal'
                    except (ValueError, TypeError):
                        texto = ""
                
                btn.config(
                    text=texto,
                    font=btn_config.get('font'),
                    fg=btn_config.get('fg'),
                    state=btn_config.get('state', 'disabled')
                )

    def _limpiar_mesa(self):
        """Limpia todos los botones de la mesa, dejándolos vacíos y sin borde."""
        for fila_botones in self.mesa_botones:
            for btn in fila_botones:
                btn.config(text="", borderwidth=0, relief=tk.FLAT)

    def _actualizar_mesa(self, fichas):
        """Actualiza la mesa de juego con una lista de fichas que están en la mesa."""
        self._limpiar_mesa()

        if not fichas:
            return

        # Ordenar las fichas por grupo para asegurar una representación consistente
        fichas.sort(key=lambda f: (  int(f.get('id-serie',    0))
                                   , int(f.get('id-escalera', 0))
                                   , int(f.get('orden',       0))))    

        print("FICHAS DESPUES DE ORDENAR=",fichas)                

        fila_actual, col_actual = 0, 0
        id_grupo_anterior = None

        for ficha in fichas:
            try:
                # Determinar el grupo actual (serie o escalera)
                id_serie = int(ficha.get('id-serie', 0))
                id_escalera = int(ficha.get('id-escalera', 0))
                id_grupo_actual = (id_serie, id_escalera)

                # Si es un nuevo grupo, saltar a la siguiente fila
                if (id_grupo_actual != id_grupo_anterior 
                    and id_grupo_anterior is not None):
                    fila_actual += 1
                    col_actual = 0

                # Comprobar que no nos salimos de la mesa
                if (fila_actual >= len(self.mesa_botones) 
                    or col_actual >= len(self.mesa_botones[0])):
                    print("Advertencia: No hay más espacio en la mesa para mostrar todas las fichas.")
                    break

                # Configurar la ficha en el botón correspondiente
                num = int(ficha.get('numero'))
                color = ficha.get('color')
                letra = self._letras.get(color, '')
                bloque = int(ficha.get('bloque'))
                ubicacion = ficha.get('ubicacion')

                if bloque == 1:
                    texto = f"{num}{letra}'"
                else:
                    texto = f"{num}{letra}."

                if ubicacion == 'humano':
                    texto = texto + '+'

                btn_config = self.color_config.get(letra, self.color_config['default']).copy()

                btn = self.mesa_botones[fila_actual][col_actual]
                btn.config(text=texto, font=btn_config['font']
                           , fg=btn_config['fg']
                           , state='normal', borderwidth=1, relief=tk.SOLID)

                col_actual += 1
                id_grupo_anterior = id_grupo_actual

            except (ValueError, TypeError, KeyError) as e:
                print(f"Error al procesar la ficha {ficha}: {e}")
                continue