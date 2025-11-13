;;;
;;; (rummikub-variables-y-funciones.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

; Variables globales

; Secuencia. Para distinguir dos fichas iguales (en hechos diferentes)
; al leer la jugada del usuario.
(defglobal MAIN ?*secuencia* = 0)

; Nos servirá para detectar cuando los dos jugadores pasan;
; y por lo tanto acaba el juego.
(defglobal MAIN ?*bolsa-sin-fichas-en-jugada* = 0)

; Nos servirá para labores de depuración.
(defglobal MAIN ?*numero-de-fichas-iniciales-por-tablilla* = 14)

(defglobal MAIN ?*debug-print*   = t) ; ( = t activada, = nil desactivada )
(defglobal MAIN ?*debug-print-2* = t) ; ( = t activada, = nil desactivada )
(defglobal MAIN ?*debug-print-3* = t) ; ( = t activada, = nil desactivada )
(defglobal MAIN ?*debug-print-4* = t) ; ( = t activada, = nil desactivada )

(deffunction MAIN::obtener-siguiente-secuencia ()
        (bind ?*secuencia* (+ 1 ?*secuencia*))
)

(deffunction MAIN::obtener-valor-actual-secuencia ()
        (bind ?*secuencia* (+ 0 ?*secuencia*))
)

; Definición del hecho ficha.
(deftemplate MAIN::ficha 
        (slot numero    (type INTEGER)
                        (default ?NONE)
                        (range 0 13)) ; La ficha numero=0 identifica el comodín
        (slot color     (allowed-values azul naranja negro rojo comodin)
                        (default ?NONE))
        (slot bloque    (allowed-values 1 2))
        (slot ubicacion (allowed-values bolsa humano maquina tablero)
                        (default ?NONE))
        (slot sorteo    (type INTEGER)
                        (default -1))
        (slot marcada-serie    (type INTEGER)
                               (default -1))
        (slot id-serie         (type INTEGER)
                               (default 0))                               
        (slot marcada-escalera (type INTEGER)
                               (default -1))
        (slot id-escalera      (type INTEGER)
                               (default 0))
        (slot orden            (type INTEGER)
                               (default 0))
        (slot id-jugada        (type INTEGER)
                               (default -1))
        (slot ok-jugada        (type INTEGER)
                               (default -1))
        (slot fila             (type INTEGER)
                               (default -1))
        (slot columna          (type INTEGER)
                               (default -1))
)

; Definición del hecho ficha en tablero temporal.
; Se usará cuando el jugador haya movido/reorganizado las fichas
; del tablero en su jugada y haya
; incorporado al tablero fichas de su tablilla. Por lo tanto hay
; que validar dicha nueva
; configuración. Si es válida hay que pasarla a definitiva;
; lo que se hará actualizando el hecho
; principal ficha con ficha-temporal.
(deftemplate MAIN::ficha-temporal
        (slot numero    (type INTEGER)
                        (default ?NONE)
                        (range 0 13)) ; La ficha numero=0 identifica el comodín
        (slot color     (allowed-values azul naranja negro rojo comodin)
                        (default ?NONE))
        (slot bloque    (allowed-values 1 2))
        (slot id-jugada-temp   (type INTEGER)
                               (default -1))
        (slot ok-jugada-temp   (type INTEGER)
                               (default -1))
        (slot fila             (type INTEGER)
                               (default -1))
        (slot columna          (type INTEGER)
                               (default -1))
)

(deftemplate MAIN::validar-tablero)

; Definición del movimiento que ha indicado el usuario.
(deftemplate MAIN::movimiento-humano-introducido
        (multislot ficha-color (type SYMBOL))
        (slot id-movimiento    (type INTEGER)
                               (default -1))
)

; Para procesar/tratar el movimiento introducido por el usuario.
(deftemplate MAIN::movimiento-humano-pendiente
        (multislot ficha-color (type SYMBOL))
        (slot id-movimiento    (type INTEGER)
                               (default -1))
)

; Para procesar/tratar el movimiento introducido por el usuario.
(deftemplate MAIN::movimiento-humano-ficha-debe-tener
        (slot numero    (type INTEGER)
                        (default ?NONE)
                        (range 0 13)) ; La ficha numero=0 identifica el comodín
        (slot color     (allowed-values azul naranja negro rojo comodin)
                        (default ?NONE))
        (slot id-jugada        (type INTEGER)
                               (default -1))
        (slot ok-jugada        (type INTEGER)
                               (default -1))                               
)

; Para procesar/tratar el movimiento introducido por el usuario ya validado.
(deftemplate MAIN::movimiento-humano-correcto
        (slot numero    (type INTEGER)
                        (default ?NONE)
                        (range 0 13)) ; La ficha numero=0 identifica el comodín
        (slot color     (allowed-values azul naranja negro rojo comodin)
                        (default ?NONE))
        (slot id-jugada        (type INTEGER)
                               (default -1))
        (slot ok-jugada        (type INTEGER)
                               (default -1))                               
)

; Indicador de si el tablero es correcto o no.
(deftemplate MAIN::tablero-correcto
        (slot correcto  (type SYMBOL)
                        (allowed-values si no)
                        (default no))
        (slot id-jugada (type INTEGER)
                        (default -1))
)

; Indicador de si el tablero temporal es correcto o no.
(deftemplate MAIN::tablero-temp-correcto
        (slot correcto       (type SYMBOL)
                             (allowed-values si no)
                             (default no))
        (slot id-jugada-temp (type INTEGER)
                             (default -1))
)

; Nos permitirá ir controlando a quien le toca jugar.
(deftemplate MAIN::comienza-maquina)
(deftemplate MAIN::comienza-humano)


; Nos permitirá evitar el bucle infinito de juego cuando usemos la GUI.
(deftemplate MAIN::con-interfaz-grafica)

; Gestión de aleatoridad
(deffunction MAIN::inicializar-random ()
        ; Un clásico, inicializamos la semilla del generador de
        ; números pseudo-aleatorios con el reloj.

        ; Guardamos la hora actual
        (bind ?hora (time))
        ; Nos quedamos con la parte decimal y redondeamos
        (bind ?semilla (round (* 100000 (abs (- ?hora (round ?hora)))))) 
        ; Inicializamos la semilla del generador de números aleatorios
        (seed ?semilla)
)

(deffunction MAIN::obtener-random (?inf ?sup)        
        ; Le pedimos un valor aleatorio en el intervalo [?inf,?sup]
        (random ?inf ?sup)
)

; Para contar hechos del tipo ficha (el principal)
(deffunction MAIN::count-facts-ficha-ubicacion (?ubicacion)
        (length$ (find-all-facts ((?f ficha)) (eq ?f:ubicacion ?ubicacion)))
)

; Para mostrar las fichas existentes en cada ubicación
; (tablero,bolsa,humano,máquina)
(deffunction MAIN::mostrar-fichas (?ubicacion)
        (bind ?lista (create$ ?ubicacion))
        (printout ?*debug-print* ?ubicacion": ")
        (bind ?fichas (find-all-facts ((?f ficha)) 
                        (eq ?f:ubicacion ?ubicacion)))
        (foreach ?ficha ?fichas
           ;(printout ?*debug-print-3* (fact-slot-value ?ficha numero) 
           ;           "-" (sub-string 1 2 (fact-slot-value ?ficha color)) " ")
           (bind ?texto-color "")
           (if (eq (sub-string 1 2 (fact-slot-value ?ficha color)) "az")
                 then (bind ?texto-color "a"))
           (if (eq (sub-string 1 2 (fact-slot-value ?ficha color)) "na")
                 then (bind ?texto-color "j"))
           (if (eq (sub-string 1 2 (fact-slot-value ?ficha color)) "ne")
                 then (bind ?texto-color "n"))
           (if (eq (sub-string 1 2 (fact-slot-value ?ficha color)) "ro")
                 then (bind ?texto-color "r"))
           (if (eq (sub-string 1 2 (fact-slot-value ?ficha color)) "co")
                 then (bind ?texto-color "c"))
           (printout ?*debug-print-3* 
                              (fact-slot-value ?ficha numero) ?texto-color " ")
           (bind ?lista ?lista (explode$ (str-cat 
                        (fact-slot-value ?ficha numero) 
                        "-" (sub-string 1 2 (fact-slot-value ?ficha color)) 
                        "[" (fact-slot-value ?ficha id-jugada) "]" 
                        "[" (fact-slot-value ?ficha ok-jugada) "]")))
        )

        (printout t "[" (length$ (find-all-facts ((?f ficha))
                 (eq ?f:ubicacion ?ubicacion))) " fichas] EN " ?ubicacion crlf)
)

; Para ordenar listas de cadenas
(deffunction MAIN::string> (?a ?b) (> (str-compare ?a ?b) 0))

; El humano roba una ficha de la bolsa...
(deffunction MAIN::robar-ficha-humano (?en-jugada)
        (bind ?extraida 0)
        (printout t "ROBAR-FICHA-HUMANO" crlf)
        (bind ?fichas-en-bolsa (find-all-facts ((?f ficha)) 
                              (and (eq ?f:ubicacion bolsa) (eq ?f:sorteo -1))))
        (bind ?total-fichas-en-bolsa (length$ ?fichas-en-bolsa))
        (if (= 0 ?total-fichas-en-bolsa)
            then 
                (printout t "NO QUEDAN MAS FICHAS EN LA BOLSA PARA ROBAR!" crlf)
                (if (= ?*bolsa-sin-fichas-en-jugada* (- ?en-jugada 1))
                        then
                        ; Resulta que justo en la jugada anterior la máquina
                        ; había también robado. ACABA EL JUEGO.
                        (printout t "AMBOS PASAN...ACABA EL JUEGO..." crlf)
                        (halt)
                        else
                        (bind ?*bolsa-sin-fichas-en-jugada* ?en-jugada)
                )
            else            
            (printout t "DESPUES DE ROBAR UNA FICHA QUEDAN EN LA BOLSA = "
                         (- ?total-fichas-en-bolsa 1) crlf)
            (bind ?extraida (random 1 ?total-fichas-en-bolsa))
            (printout ?*debug-print* "En la pos: " ?extraida " esta: "
                          (nth$ ?extraida ?fichas-en-bolsa) crlf)
            (modify (nth$ ?extraida ?fichas-en-bolsa) 
                                                (ubicacion humano)(sorteo 0))
        )
)

; La máquina roba una ficha de la bolsa...
(deffunction MAIN::robar-ficha-maquina (?en-jugada)
        (bind ?extraida 0)
        (printout t "ROBAR-FICHA-MAQUINA" crlf)
        (bind ?fichas-en-bolsa (find-all-facts ((?f ficha)) 
                              (and (eq ?f:ubicacion bolsa) (eq ?f:sorteo -1))))
        (bind ?total-fichas-en-bolsa (length$ ?fichas-en-bolsa))
        (if (= 0 ?total-fichas-en-bolsa)
            then 
                (printout t "NO QUEDAN MAS FICHAS EN LA BOLSA PARA ROBAR!" crlf)
                (if (= ?*bolsa-sin-fichas-en-jugada* (- ?en-jugada 1))
                        then
                        ; Resulta que justo en la jugada anterior el jugador
                        ; había también robado. ACABA EL JUEGO.
                        (printout t "AMBOS PASAN...ACABA EL JUEGO..." crlf)
                        (halt)
                        else
                        (bind ?*bolsa-sin-fichas-en-jugada* ?en-jugada)
                )
            else            
            (printout t "DESPUES DE ROBAR UNA FICHA QUEDAN EN LA BOLSA = "
                        (- ?total-fichas-en-bolsa 1) crlf)
            (bind ?extraida (random 1 ?total-fichas-en-bolsa))
            (printout ?*debug-print* "En la pos: " ?extraida " esta: " 
                        (nth$ ?extraida ?fichas-en-bolsa) crlf)
            (modify (nth$ ?extraida ?fichas-en-bolsa) 
                                (ubicacion maquina)(sorteo 0))
        )
)

; Mostrar reglas del juego
(deffunction MAIN::mostrar-reglas ()

(printout t
"------------------------------------------------------------------------" crlf
"REGLAS DEL JUEGO"                                                         crlf
"1. En este caso, el sistema está configurado para que un jugador humano," crlf
"   juegue contra la máquina. O sea, 2 jugadores (adaptación)."            crlf
"2. Un jugador no puede ver las fichas de los demás jugadores."            crlf
"3. Todas las fichas están en una bolsa."                                  crlf
"4. Para comenzar, cada jugador coge 14 fichas de la bolsa y las coloca en su"
crlf
"   soporte (o tablilla)."                                                 crlf
"5. Se echa a suertes el jugador que será el primero en jugar."            crlf
"6. Únicas combinaciones de fichas válidas:"                               crlf
"   a) ESCALERA: Una escalera está compuesta de al menos de 3 fichas del mismo"
crlf
"      color con números consecutivos en orden ascendente. El número más"  crlf
"      bajo posible de una escalera es el 1. El número más alto posible"   crlf
"      de una escalera es el 13. Todas las fichas de una escalera son"     crlf
"      del mismo color."                                                   crlf
"   b) SERIE: Una serie está compuesta de al menos de 3 fichas con el mismo"
crlf
"      número, pero de diferentes colores. Una serie está compuesta como máximo"
crlf
"      de 4 colores, porque cada color solo puede aparecer una vez en una serie"
crlf
"7. Para empezar a jugar,un jugador debe colocar en la mesa uno o más conjuntos"
crlf
"   de fichas (de cualquier combinación) con un valor total de"            crlf
"   al menos 30 puntos (no se aplica; adaptación)."                        crlf
"8. Si un jugador no puede colocar una combinación inicial sobre la mesa, debe"
crlf
"   coger una ficha de la bolsa. Con esto termina su turno y continúa el"  crlf
"   siguiente jugador."                                                    crlf
"9. Una vez colocada su primera combinación, en su segunda ronda el jugador"
crlf
"   puede colocar cualquier otra sin importar su puntuación (ver regla 7) o"
crlf
"   combinar fichas a las ya existentes. Si no coloca al menos una ficha en su"
crlf
"   turno, deberá robar una de la bolsa y pasar el turno."                 crlf
"10. El juego termina cuando un jugador se queda sin fichas. Es el ganador."
crlf
"11. COMODÍN:El comodín puede sustituir cada número y cada color, también en la"
crlf
"    combinación inicial. El comodín puede ser sustituido durante el juego por"
crlf
"    todos los jugadores por la ficha con el valor y el color correspondiente."
crlf
"    El comodín sustituido debe usarse en el mismo turno de juego y no puede"
crlf
"    colocarse en el soporte para futuras jugadas. Cada vez que es sustituido,"
crlf
"    el comodín adopta un nuevo valor y color. El juego contiene 2 comodines que"
crlf
"    se utilizan en lugar de la ficha que falta en una serie o escalera."  crlf
"    Un comodín que se utiliza en la combinación inicial tiene el valor de la"
crlf
"    ficha que representa (solo usado para contabilizar los 30 puntos iniciales;"
crlf
"    ver regla 7) después puede tomar el valor y color que interese a cada"
crlf
"    jugador en su turno."                                                 crlf
"12. El jugador que haya puesto su primera combinación en la mesa, puede" crlf
"    colocar inmediatamente o más tarde una o más fichas a cualquier serie" crlf
"    o escalera para ampliarlas o para reorganizar las fichas que están"   crlf
"    sobre la mesa. El jugador también puede coger una serie o escalera "  crlf
"    completa del soporte y colocarla sobre la mesa. Si un jugador no puede "
crlf
"    o no quiere deshacerse de una ficha, serie o escalera, debe coger una "
crlf
"    ficha de la bolsa y continuará el siguiente jugador."                 crlf
"13. La mesa de juego es común para todos los jugadores y no para cada jugador"
crlf
"    individual."                                                          crlf
"14. REORGANIZAR: Las series y escaleras pueden reorganizarse en cualquier "
crlf
"    forma en un turno, con la condición de que al terminar todas las fichas "
crlf
"    en la mesa de juego formen escaleras/series válidas."                 crlf
"15. LÍMITE DE TIEMPO: No se establecerá un límite de tiempo para efectuar "
crlf
"    las jugadas (adaptación)."                                            crlf
"16. RESTRICCIÓN: Tras una jugada debe haber en la mesa, series y/o escaleras "
crlf
"    de al menos 3 fichas."                                                crlf
"17. PUNTUACIÓN (varias partidas):No se contempla esta posibilidad (adaptación)"
crlf
"18. FINAL ALTERNATIVO: En el caso de que se agoten las fichas para robar, los "
crlf
"    jugadores deben seguir jugando hasta que ninguno pueda colocar más fichas."
crlf
"    Entonces el ganador será el que tenga menor puntuación en su tablilla."
crlf
"NOTAS (algunas específicas para la shell de CLIPS):"                      crlf
"      * Si ambos jugadores intentan robar consecutivamente y en la bolsa no"
crlf
"        quedan más fichas, se considera que el juego ha finalizado."      crlf
"      * El jugador dispone de varios comandos:"                           crlf
"        > DE CONTROL: OK ROBAR TERMINAR"                                  crlf
"             # TERMINAR: Salir del juego."                                crlf
"             # ROBAR: Robar una ficha de la bolsa."                       crlf
"             # OK: Permite introducir las jugadas."                       crlf
"                   - Una jugada se compone de varios movimientos parciales."
crlf
"                   - Introduzca un movimiento por linea;"                 crlf
"                     termine con un 'ok' dicha línea."                    crlf
"                     Por ejemplo:"                                        crlf
"                     RUMMIKUB> 1r 1a 1n 1j ok"                            crlf
"                   - Termine la lista de movimientos con un 'ok' al comienzo"
crlf
"                     de una nueva linea."                                 crlf
"                     Por ejemplo:"                                        crlf
"                     RUMMIKUB> ok"                                        crlf
"                   - Los números se identifican por ellos mismos."        crlf
"                   - Los colores se identifican así:"                     crlf
"                           a - azul     "                                 crlf
"                           j - naranja  "                                 crlf
"                           n - negro    "                                 crlf
"                           r - rojo     "                                 crlf
"                           0c - comodín "                                 crlf
"        > DE ASISTENCIA: MOSTRAR AYUDA REGLAS"                            crlf
"             # REGLAS: muestra este mensaje."                             crlf
"             # AYUDA: muestra posibles movimientos."                      crlf
"             # MOSTRAR: muestra estado del juego."                        crlf
"------------------------------------------------------------------------" crlf)

)

(deffunction MAIN::desmarcar-escaleras(?ubicacion)
       (bind ?fichas (find-all-facts ((?f ficha)) 
              (and (eq ?f:ubicacion ?ubicacion) (neq ?f:marcada-escalera -1))))
       (foreach ?ficha ?fichas (modify ?ficha 
                                        (marcada-escalera -1)(id-escalera 0)))
)

(deffunction MAIN::desmarcar-series(?ubicacion)
       (bind ?fichas (find-all-facts ((?f ficha))
              (and (eq ?f:ubicacion ?ubicacion) (neq ?f:marcada-serie -1))))
       (foreach ?ficha ?fichas (modify ?ficha
                                        (marcada-serie -1)(id-serie 0)))
)

(deffunction MAIN::comprobar-final-de-juego()
        (bind ?fichas-restantes-humano (length$ (find-all-facts ((?f ficha))
                                                    (eq ?f:ubicacion humano))))
        (printout ?*debug-print* "A USTED LE QUEDAN: "
                                                 (mostrar-fichas humano) crlf)   

        (bind ?fichas-restantes-maquina (length$ (find-all-facts ((?f ficha))
                                                   (eq ?f:ubicacion maquina))))
        (printout ?*debug-print* "A MI ME QUEDAN: "
                                                 (mostrar-fichas maquina) crlf)   
   
        (if (= 0 ?fichas-restantes-maquina)
        then
                ; Comprobar primero si la máquina ha ganado...
                (printout t "YO GANO!!!" crlf)
                (halt))

        (if (= 0 ?fichas-restantes-humano)
        then
                ; Comprobar a continuación si el humano ha ganado...
                (printout t "USTED GANA!!!" crlf)
                (halt))
)

; Mostrar ayuda del juego
(deffunction MAIN::mostrar-ayuda ()
        (desmarcar-escaleras maquina)
        (desmarcar-series maquina)
        (desmarcar-escaleras humano)
        (desmarcar-series humano)
        (focus M-BUSCAR-COMBINACIONES)
)

;
; LAS QUE SIGUEN INVOCADAS EXCLUSIVAMENTE DESDE LA GUI
;
(deffunction MAIN::pasar-turno-a (?jugador)
        (do-for-all-facts ((?h-aux comienza-humano)) TRUE (retract ?h-aux))
        (do-for-all-facts ((?h-aux comienza-maquina)) TRUE (retract ?h-aux))

        (if (eq ?jugador maquina)
          then
               (printout t "ME TOCA A MI !!!" crlf)
               (assert (comienza-maquina))
               (focus M-JUGAR)
               (halt)
          else
               (printout t "LE TOCA A USTED !!!" crlf)
               (assert (comienza-humano))
               (focus M-JUGAR)
               (halt)
        )        
)

(deffunction MAIN::comprobar-jugadas-tablero-temporal ()
        (printout t "(03)COMPROBAR JUGADAS TABLERO TEMPORAL..." crlf)
        (focus M-VALIDAR-TABLERO-TEMPORAL)
)

(deffunction MAIN::por-ultimo-decidir-sobre-tablero-temporal ()
        ; Si el tablero se ha validado, recordarlo.
        (if (any-factp ((?h-aux tablero-temp-correcto)) 
                                                (eq ?h-aux:correcto si))
                then 
                        (printout t "RECORDAMOS EL TABLERO!!!" crlf)
                        (focus M-HACER-DISPOSICION-TABLERO-DEFINITIVA)
                else
                        (printout t 
                                "CORRIJA EL TABLERO O DESHAGA JUGADA!!!" crlf)                                                
        )
        ; Borrar los resultados parciales.
        (do-for-all-facts ((?h-aux validar-tablero)) TRUE 
                                                     (retract ?h-aux))
        (do-for-all-facts ((?h-aux tablero-temp-correcto)) TRUE 
                                                           (retract ?h-aux))
)


(deffunction MAIN::limpiar-fichas-temporales ()
        (printout t "(02)LIMPIANDO FICHAS TEMPORALES..." crlf)
        (do-for-all-facts ((?h-aux ficha-temporal)) TRUE (retract ?h-aux))
)

(deffunction MAIN::iniciar-validacion-tablero-temporal ()
        (printout t "(01)VALIDANDO TABLERO TEMPORAL..." crlf)
        (limpiar-fichas-temporales)        
        (assert (validar-tablero))        
)