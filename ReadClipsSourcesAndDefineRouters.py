###
### (ReadClipsSourcesAndDefineRouters.py)
###
### Sistema Experto en CLIPS para jugar al Rummikub
###

# Para ubicar los archivos en el disco.
import os

# Nuestra principal librería para conectar con CLIPS: clipspy
import clips

# clipspy: cargamos la definición de Router
# En CLIPS los routers se utilizan como elemento para integrar
# el shell de CLIPS con otros sistemas.
from clips import Router

# Para definir estos Routers me he basado en el código fuente de IDECLIPS:
# que viene incluido en la distribución de CLIPS (y se puede utilizar como
# entorno de desarrollo).

# Definimos un router para interceptar la salida estandar de clips "stdout".
# Si lo activamos, nos permitirá mostrar los mensajes que emite clips
# en nuestra GUI.
class OutRouter(Router):

    __slots__ = '_env', '_name', '_userdata', '_priority', '_output_stream'

    def __init__(self):
        super().__init__('python-out-router', 0)
        self._output_stream = ''

    @property
    def output_stream(self) -> str:
        ret = self._output_stream
        self._output_stream = ''
        return ret

    def query(self, name: str) -> bool:
        if name == 'stdout':
            return True
        else:
            return False

    def write(self, name: str, message: str):
        self._output_stream += message
        #print(message, end='')
        self.share_message(name, message)

# Definimos un router para interceptar la entrada estandar de clips "stdin".
# Si lo activamos, nos permitirá enviar texto a clips desde nuestra GUI.
# En este caso lo dejamos como prueba de concepto "POC", de lo 
# que se podría hacer.
class InRouter(Router):

    __slots__ = '_env', '_name', '_userdata', '_priority', '_input_stream'

    def __init__(self):
        super().__init__('python-in-router', 1)
        self._input_stream = 'AYUDA\nTERMINAR\n'  # Ejemplo: simulamos 
                                                  # una entrada de usuario.

    def query(self, name: str) -> bool:
        if name == 'stdin':
            return True
        else:
            return False

    def read(self, name: str) -> int:
        if not self._input_stream:
            return -1
        # A devolver el primer carácter leído como un entero (código ASCII).
        ret = ord(self._input_stream[0])
        print(self._input_stream[0], end='')
        self._input_stream = self._input_stream[1:]  # Elimina el primer
                                                     # carácter leído.
        return ret
        

# 1. Declaramos las variables a nivel de módulo para que
# sean accesibles globalmente.
EntornoClips = None
RouterClipsOut = None

# Cargar el programa de CLIPS:

def Comenzar():
    global EntornoClips, RouterClipsOut

    # 2. Instanciamos el shell y el router.
    EntornoClips = clips.Environment()
    RouterClipsOut = OutRouter()

    # 3. Interceptamos la salida "stdout" de CLIPS para
    # reenviarla a nuestra GUI.
    EntornoClips.add_router(RouterClipsOut)

    # 3. El router de entrada no lo usaremos. POC.
    #RouterClipsIn = InRouter() # Por ahora no vamos a simular
                                # la entrada de usuario.
    #EntornoClips.add_router(RouterClipsIn)

    # 4. Necesitamos saber dónde estamos para localizar los archivos
    # que contienen el programa CLIPS.
    basedir = os.path.dirname(os.path.abspath(__file__))

    # 5. Secuencia habitual para iniciar un programa CLIPS:
    #    (clear)
    #    (load c01.clp)
    #    (load c02.clp)
    #    ...
    #    (load c0n.clp)
    #    (reset)
    #    (run)
    EntornoClips.clear()
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-modulos.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-variables-y-funciones.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-m-buscar-combinaciones.alt.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-m-validar-tablero.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-m-validar-tablero-temporal.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub-m-hacer-disposicion-tablero-definitiva.clp'))
    EntornoClips.batch_star(
        path=os.path.join(basedir, 
                        'clips.src',
                        'rummikub.clp'))
    EntornoClips.reset()    

    # 6. No queremos ejecutar el programa de CLIPS desde aquí,
    # solo cargarlo en memoria.
    #EntornoClips.run()