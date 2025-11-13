###
### (DragAndDrop.py)
###
### Sistema Experto en CLIPS para jugar al Rummikub
### 

import tkinter as tk

# CODIGO GENERADO POR IA !!!
class DraggableMixin:
    """
    Mixin que incorpora funcionalidad de drag-and-drop a un widget de Tkinter.
    """
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self._drag_data = {
          "item": None,           # El widget que se está arrastrando
          "widget": None,         # La ventana flotante que se muestra
          "highlighted_widget": None, # El widget que está resaltado ahora
          "original_bg": None # El color de fondo original del widget resaltado
        }

        self.bind("<ButtonPress-1>", self.on_drag_start)
        self.bind("<B1-Motion>", self.on_drag_motion)
        self.bind("<ButtonRelease-1>", self.on_drag_release)

    def on_drag_start(self, event):
        # Solo iniciar arrastre si el botón tiene texto (es una ficha)
        if self.cget('text'):
            # Crear ventana flotante para la representación visual del arrastre
            self._drag_data["widget"] = tk.Toplevel(self)
            self._drag_data["widget"].overrideredirect(True) #NO Bordes y Título
            self._drag_data["widget"].attributes("-topmost", True)#Always OnTop
            
            # Usar un Label para mostrar la ficha que se arrastra
            label = tk.Label(self._drag_data["widget"], text=self.cget('text'), 
                             font=self.cget('font'), fg=self.cget('fg'),
                             bg="lightyellow", relief="solid", borderwidth=1)
            label.pack()

            # Posicionar la ventana flotante en el cursor
            self._drag_data["widget"].geometry(
                                    f"+{event.x_root+10}+{event.y_root+10}")
            
            # Guardar el widget original
            self._drag_data["item"] = self
            self._drag_data["highlighted_widget"] = None
            self._drag_data["original_bg"] = None

    def on_drag_motion(self, event):
        if self._drag_data["widget"]:
            # Mover la ventana flotante con el cursor
            self._drag_data["widget"].geometry(
                                    f"+{event.x_root+10}+{event.y_root+10}")

            # --- Lógica de resaltado del destino ---
            x, y = event.x_root, event.y_root
            target_widget = self.winfo_containing(x, y)
            last_highlighted = self._drag_data.get("highlighted_widget")

            # Si el widget bajo el cursor ha cambiado
            if target_widget != last_highlighted:
                # Si había un widget resaltado, restaurar su color original
                if last_highlighted:
                    try:
                        last_highlighted.config(
                                            bg=self._drag_data["original_bg"])
                    except tk.TclError:
                        # El widget podría haber sido destruido
                        pass
                    self._drag_data["highlighted_widget"] = None
                    self._drag_data["original_bg"] = None

                # Si el nuevo widget es un destino válido, resaltarlo
                if (isinstance(target_widget, DraggableButton) 
                    and target_widget != self._drag_data["item"]):
                    self._drag_data["original_bg"] = target_widget.cget("bg")
                    self._drag_data["highlighted_widget"] = target_widget
                    target_widget.config(bg="yellow")

    def on_drag_release(self, event):
        if self._drag_data["widget"]:
            # --- Limpieza del resaltado ---
            last_highlighted = self._drag_data.get("highlighted_widget")
            if last_highlighted:
                try:
                    last_highlighted.config(bg=self._drag_data["original_bg"])
                except tk.TclError:
                    pass

            # Destruir la ventana flotante y limpiar datos de arrastre
            self._drag_data["widget"].destroy()
            self._drag_data["widget"] = None

            # Encontrar el widget debajo del cursor
            x, y = event.x_root, event.y_root
            target_widget = self.winfo_containing(x, y)

            if target_widget and self._drag_data["item"]:
                # Si el destino es un widget que puede ser arrastrado
                # (y por lo tanto, un destino válido),
                # llamamos a la función de drop.
                if isinstance(target_widget, DraggableButton):
                    # Asumimos que la clase principal tiene método `drop_ficha`
                    self.winfo_toplevel().drop_ficha(
                                        self._drag_data["item"], target_widget)

            self._drag_data["item"] = None
            self._drag_data["highlighted_widget"] = None

class DraggableButton(DraggableMixin, tk.Button):
    pass