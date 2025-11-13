;;;
;;; (rummikub.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

(deffacts MAIN::bolsa-de-fichas

        ; Para diferenciar dos fichas iguales usamos el bloque = 1|2 ...
        ; ...CLIPS no admite dos hechos iguales por defecto.Se puede configurar
        ; Durante el juego, hemos diferenciado dos fichas iguales por medio de
        ; una secuencia auto-numérica.
        ; El número = 0  es el comodín.
        ; Inicialmente todas las fichas están en la bolsa.

        (ficha (numero 0) (color comodin)(bloque 1)(ubicacion bolsa))
        (ficha (numero 0) (color comodin)(bloque 2)(ubicacion bolsa))

        (ficha (numero 1) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 2) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 3) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 4) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 5) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 6) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 7) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 8) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 9) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 10) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 11) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 12) (color azul)(bloque 1)(ubicacion bolsa))
        (ficha (numero 13) (color azul)(bloque 1)(ubicacion bolsa))

        (ficha (numero 1) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 2) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 3) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 4) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 5) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 6) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 7) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 8) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 9) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 10) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 11) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 12) (color azul)(bloque 2)(ubicacion bolsa))
        (ficha (numero 13) (color azul)(bloque 2)(ubicacion bolsa))

        (ficha (numero 1) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 2) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 3) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 4) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 5) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 6) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 7) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 8) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 9) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 10) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 11) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 12) (color naranja)(bloque 1)(ubicacion bolsa))
        (ficha (numero 13) (color naranja)(bloque 1)(ubicacion bolsa))

        (ficha (numero 1) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 2) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 3) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 4) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 5) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 6) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 7) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 8) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 9) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 10) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 11) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 12) (color naranja)(bloque 2)(ubicacion bolsa))
        (ficha (numero 13) (color naranja)(bloque 2)(ubicacion bolsa))

        (ficha (numero 1) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 2) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 3) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 4) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 5) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 6) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 7) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 8) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 9) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 10) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 11) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 12) (color negro)(bloque 1)(ubicacion bolsa))
        (ficha (numero 13) (color negro)(bloque 1)(ubicacion bolsa))

        (ficha (numero 1) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 2) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 3) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 4) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 5) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 6) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 7) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 8) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 9) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 10) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 11) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 12) (color negro)(bloque 2)(ubicacion bolsa))
        (ficha (numero 13) (color negro)(bloque 2)(ubicacion bolsa))

        (ficha (numero 1) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 2) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 3) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 4) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 5) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 6) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 7) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 8) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 9) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 10) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 11) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 12) (color rojo)(bloque 1)(ubicacion bolsa))
        (ficha (numero 13) (color rojo)(bloque 1)(ubicacion bolsa))

        (ficha (numero 1) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 2) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 3) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 4) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 5) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 6) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 7) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 8) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 9) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 10) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 11) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 12) (color rojo)(bloque 2)(ubicacion bolsa))
        (ficha (numero 13) (color rojo)(bloque 2)(ubicacion bolsa))        
)

(defrule MAIN::sortear-quien-empieza
        =>
        (inicializar-random)
        (if (> (obtener-random 0 1) 0)
                then
                (assert (comienza-humano))
                (printout ?*debug-print* "USTED JUEGA..." crlf)
                else
                (assert (comienza-maquina))
                (printout ?*debug-print* "ME TOCA A MI..." crlf)
        )
        (set-strategy random) ;Para dar aún más variabilidad al reparto inicial
        (focus
               M-SORTEAR-FICHAS
               M-MOSTRAR-FICHAS
               ;M-BUSCAR-COMBINACIONES
               M-JUGAR
        )
)

(defrule M-SORTEAR-FICHAS::sortear-fichas-maquina
        ; Hacemos dos grupos con las fichas de forma aleatoria.
        ; Uno de los grupos para la máquina y el otro para el humano.
        ; Pero de cada grupo solo seleccionaremos las 14 fichas iniciales.        
        ; Un random sobre todas las fichas nos puede dar pocas fichas 
        ; para alguno de los jugadores.
        ; Debemos parar la asignación de fichas a cada jugador cuando
        ; lleguemos a las 14.
        ; Luego continuaremos asignando fichas de forma aleatoria pero sólo
        ; para el jugador que aún le falten fichas.
        ?h1 <- (ficha (sorteo -1))
        =>
        (if (= 0 (obtener-random 0 1))
                then
                (if (< (count-facts-ficha-ubicacion maquina) 
                       ?*numero-de-fichas-iniciales-por-tablilla*)
                        then
                        (modify ?h1 (ubicacion maquina)(sorteo 0))))
)

(defrule M-SORTEAR-FICHAS::sortear-fichas-humano
        ; Hacemos dos grupos con las fichas de forma aleatoria.
        ; Uno de los grupos para la máquina y el otro para el humano.
        ; Pero de cada grupo sólo seleccionaremos las 14 fichas iniciales.        
        ; Un random sobre todas las fichas nos puede dar pocas fichas para
        ; alguno de los jugadores.
        ; Debemos parar la asignación de fichas a cada jugador cuando
        ; lleguemos a las 14.
        ; Luego continuaremos asignando fichas de forma aleatoria pero sólo
        ; para el jugador que aún le falten fichas.
        ?h1 <- (ficha (sorteo -1))
        =>     
        (if (= 1 (obtener-random 0 1))
                then
                (if (< (count-facts-ficha-ubicacion humano) 
                       ?*numero-de-fichas-iniciales-por-tablilla*)
                        then
                        (modify ?h1 (ubicacion humano)(sorteo 0))))
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-maquina-principio
   (declare (salience 10))
   =>
   (printout t "MIS FICHAS: ")
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-maquina
        ?h1 <- (ficha (numero ?n) (color ?c) (ubicacion maquina))
        =>
        (if (eq ?c comodin) 
        then 
          (printout t ?n"-COMODIN" " ")
        else
          (printout t ?n"-"?c " "))
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-maquina-final
   (declare (salience -10))
   =>
   (printout t crlf)
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-humano-principio
   (declare (salience -90))
   =>
   (printout t "SUS FICHAS: ")
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-humano
        (declare (salience -100))
        ?h1 <- (ficha (numero ?n) (color ?c) (ubicacion humano))
        =>
        (if (eq ?c comodin) 
        then 
          (printout t ?n"-COMODIN" " ")
        else
          (printout t ?n"-"?c " "))
)

(defrule M-MOSTRAR-FICHAS::mostrar-fichas-humano-final
   (declare (salience -110))
   =>
   (printout t crlf)
)

(defrule M-JUGAR::pedir-jugada-humano
   ?h1 <- (comienza-humano)
   (not (exists (con-interfaz-grafica)))
   =>
   (printout t "USTED JUEGA..." crlf)
   (printout t "RUMMIKUB [OK|ROBAR|TERMINAR|MOSTRAR|AYUDA|REGLAS]> ")

   (bind ?mov Z)
   (bind ?leer-mov (readline))
   (while (eq 1 1) do

      (if (< 0 (str-length ?leer-mov))
      then

         (lowcase ?leer-mov)
         (if (str-index terminar ?leer-mov) then (bind ?mov TERMINAR) (break))
         (if (str-index ayuda    ?leer-mov) then (bind ?mov AYUDA   ) (break))
         (if (str-index reglas   ?leer-mov) then (bind ?mov REGLAS  ) (break))
         (if (str-index mostrar  ?leer-mov) then (bind ?mov MOSTRAR ) (break))
         (if (str-index robar    ?leer-mov) then (bind ?mov ROBAR   ) (break))
         (if (str-index ok       ?leer-mov) then (bind ?mov JUGAR   ))

         ; TERMINAR implica una parada inmediata. Es la única forma
         ; de abandonar el juego.
         (if (= 0 (str-compare ?mov TERMINAR)) then (break))

         ; AYUDA...
         (if (= 0 (str-compare ?mov AYUDA   )) then (break))

         ; REGLAS...
         (if (= 0 (str-compare ?mov REGLAS  )) then (break))

         ; MOSTRAR...
         (if (= 0 (str-compare ?mov MOSTRAR )) then (break))

         ; ROBAR FICHA...
         (if (= 0 (str-compare ?mov ROBAR   )) then (break))

         ; MOVIMIENTO...
         (if (= 0 (str-compare ?mov JUGAR)) 
            then (if (<= 4 (str-index ok ?leer-mov))
                     then 
                           (assert (movimiento-humano-introducido 
                                    (ficha-color 
                                       (explode$ 
                                          (sub-string 1 
                                             (- (str-index ok ?leer-mov) 2) 
                                             ?leer-mov)))
                                    (id-movimiento 
                                       (obtener-siguiente-secuencia))))
                     else  
                           (break)))
      )

      (printout t "RUMMIKUB [OK|ROBAR|TERMINAR|MOSTRAR|AYUDA|REGLAS]> ")
      (bind ?leer-mov (readline))
   )

   (retract ?h1)
   (if (= 0 (str-compare ?mov TERMINAR)) then (halt))
   (if (= 0 (str-compare ?mov AYUDA   )) then (mostrar-ayuda)
                                              (mostrar-fichas tablero)
                                              (mostrar-fichas maquina)
                                              (mostrar-fichas humano)
                                              (assert (comienza-humano)))
   (if (= 0 (str-compare ?mov REGLAS  )) then (mostrar-reglas)
                                              (assert (comienza-humano)))
   (if (= 0 (str-compare ?mov MOSTRAR )) then (mostrar-fichas tablero)
                                              (mostrar-fichas maquina)
                                              (mostrar-fichas humano)
                                              (assert (comienza-humano)))
   (if (= 0 (str-compare ?mov ROBAR   )) then 
                           (robar-ficha-humano (obtener-siguiente-secuencia))
                           (assert (comienza-maquina)))

   ; Si ha indicado tres o más fichas "IDENTICAS" (situación imposible) más
   ; adelante se detectará esta situación
   ; y se le avisará del error. Lo que se consigue por descarte.
   (if (= 0 (str-compare ?mov JUGAR   )) 
      then
            ;;;(assert (comienza-humano))
            (bind ?movimientos-humano 
                  (find-all-facts ((?f movimiento-humano-introducido)) TRUE))
            (foreach ?movimiento-humano ?movimientos-humano
               (bind ?j ?movimiento-humano)
               (bind ?k (fact-slot-value ?j ficha-color))
               (bind ?i (fact-slot-value ?j id-movimiento))
               (while (< 0 (length$ ?k))
                  (printout ?*debug-print* (first$ ?k) crlf)
                  (assert (movimiento-humano-pendiente 
                           (ficha-color (first$ ?k) 
                           (obtener-siguiente-secuencia))
                           (id-movimiento ?i)))
                  (bind ?k (rest$ ?k))
               )
            )
   )
)

(defrule M-JUGAR::validar-jugada-humano-fase1
   ; Comprobar que el humano dispone de todas las fichas que ha indicado...
   ; Tenemos hecho del tipo:
   ; (movimiento-humano-pendiente (ficha-color 3n 5))
   ?h1 <- (movimiento-humano-pendiente (ficha-color ?f ?s)(id-movimiento ?i))
   =>
   ; Obtenemos el número quitando la letra del color de la ficha...
   (bind ?f-aux-1 (str-replace ?f "c" ""))
   (bind ?f-aux-1 (str-replace ?f-aux-1 "a" ""))   
   (bind ?f-aux-1 (str-replace ?f-aux-1 "j" ""))
   (bind ?f-aux-1 (str-replace ?f-aux-1 "r" ""))
   (bind ?f-aux-1 (str-replace ?f-aux-1 "n" ""))

   (bind ?f-aux-11 (string-to-field ?f-aux-1)) ; De cadena a número.

   (bind ?f_numero -1)
   (if (= ?f-aux-11 0) then (bind ?f_numero 0))
   (if (= ?f-aux-11 1) then (bind ?f_numero 1))
   (if (= ?f-aux-11 2) then (bind ?f_numero 2))
   (if (= ?f-aux-11 3) then (bind ?f_numero 3))
   (if (= ?f-aux-11 4) then (bind ?f_numero 4))
   (if (= ?f-aux-11 5) then (bind ?f_numero 5))
   (if (= ?f-aux-11 6) then (bind ?f_numero 6))
   (if (= ?f-aux-11 7) then (bind ?f_numero 7))
   (if (= ?f-aux-11 8) then (bind ?f_numero 8))
   (if (= ?f-aux-11 9) then (bind ?f_numero 9))
   (if (= ?f-aux-11 10) then (bind ?f_numero 10))
   (if (= ?f-aux-11 11) then (bind ?f_numero 11))
   (if (= ?f-aux-11 12) then (bind ?f_numero 12))
   (if (= ?f-aux-11 13) then (bind ?f_numero 13))

   ; Obtenemos el color quitando la parte del número de la ficha...
   (bind ?f-aux-2 (str-replace ?f "0" ""))   
   (bind ?f-aux-2 (str-replace ?f-aux-2 "1" ""))   
   (bind ?f-aux-2 (str-replace ?f-aux-2 "2" ""))
   (bind ?f-aux-2 (str-replace ?f-aux-2 "3" ""))
   (bind ?f-aux-2 (str-replace ?f-aux-2 "4" ""))
   (bind ?f-aux-2 (str-replace ?f-aux-2 "5" ""))   
   (bind ?f-aux-2 (str-replace ?f-aux-2 "6" ""))   
   (bind ?f-aux-2 (str-replace ?f-aux-2 "7" ""))
   (bind ?f-aux-2 (str-replace ?f-aux-2 "8" ""))
   (bind ?f-aux-2 (str-replace ?f-aux-2 "9" ""))

   (bind ?f_color X)
   (if (eq ?f-aux-2 c) then (bind ?f_color comodin))
   (if (eq ?f-aux-2 a) then (bind ?f_color azul))
   (if (eq ?f-aux-2 j) then (bind ?f_color naranja))
   (if (eq ?f-aux-2 r) then (bind ?f_color rojo))
   (if (eq ?f-aux-2 n) then (bind ?f_color negro))

   (retract ?h1)
   (assert (movimiento-humano-ficha-debe-tener 
            (numero ?f_numero)(color ?f_color)(id-jugada ?s)(ok-jugada ?i)))
)

(defrule M-JUGAR::validar-jugada-humano-fase2
   ; Comprobar que el humano dispone de todas las fichas que ha indicado...
   ; Comprobar ficha por ficha...
   ?h1 <- (movimiento-humano-ficha-debe-tener 
            (numero ?f_numero)(color ?f_color)(id-jugada ?s)(ok-jugada ?i))
   ?h2 <- (ficha (numero ?f_numero) (color ?f_color) (ubicacion humano))
   =>
   (retract ?h1)
   (assert (movimiento-humano-correcto (numero ?f_numero)
                                       (color ?f_color)
                                       (id-jugada ?s)
                                       (ok-jugada ?i)))
)

(defrule M-JUGAR::validar-jugada-humano-fase3
   (declare (salience -10))
   ; Si nos ha quedado una ficha por comprobar es que ha indicado
   ; una ficha que no tiene...
   ?h1 <- (movimiento-humano-ficha-debe-tener (numero ?f_numero)
                                              (color ?f_color)
                                              (id-jugada ?s)
                                              (ok-jugada ?i))
   =>
   (retract ?h1)
   (assert (ficha-erronea))
   (printout t "Ha indicado una ficha ERRÓNEA: " ?f_numero "-" ?f_color crlf)
)

(defrule M-JUGAR::validar-jugada-humano-error
   (declare (salience +10))
   ; Hay que volver a pedirle la jugada...
   ?h1 <- (movimiento-humano-introducido (ficha-color $?)(id-movimiento ?i))
   ?h2 <- (ficha-erronea)
   =>
   (retract ?h1)
   (retract ?h2)

   (do-for-all-facts ((?h-aux movimiento-humano-correcto)) TRUE 
                                                      (retract ?h-aux))
   (do-for-all-facts ((?h-aux movimiento-humano-pendiente)) TRUE 
                                                      (retract ?h-aux))
   (do-for-all-facts ((?h-aux movimiento-humano-introducido)) TRUE 
                                                      (retract ?h-aux))
   (do-for-all-facts ((?h-aux movimiento-humano-ficha-debe-tener)) TRUE 
                                                      (retract ?h-aux))

   (printout t "Vuelva a indicar su jugada." crlf)
   (assert (comienza-humano))
)

(defrule M-JUGAR::validar-jugada-humano-correcta
   (declare (salience -100))
   ; Hay que ejecutar la jugada...
   ?h1 <- (movimiento-humano-introducido (ficha-color $?)(id-movimiento ?i))
   ?h2 <- (movimiento-humano-correcto (numero ?n)(color ?c)
                                      (id-jugada ?s)(ok-jugada ?i))
   =>
   (retract ?h1)
   (retract ?h2)
   (assert (movimiento-humano-correcto (numero ?n)(color ?c)
                                       (id-jugada ?s)(ok-jugada ?i)))
   (focus M-REALIZAR-MOVIMIENTO)
)

(defrule M-REALIZAR-MOVIMIENTO::realizar-movimiento-humano-fase1
   ?h1 <- (movimiento-humano-correcto (numero ?f_numero)(color ?f_color)
                                      (id-jugada ?s_secuencia)(ok-jugada ?i))
   ?h2 <- (ficha (numero ?f_numero) (color ?f_color) (ubicacion humano))
   =>
   (retract ?h1)
   (modify  ?h2 (ubicacion tablero)(id-jugada ?i))
   (printout ?*debug-print* "REALIZAR MOVIMIENTO " ?f_numero "-" ?f_color crlf)
   (assert (refrescar-fase2))
)

(defrule M-REALIZAR-MOVIMIENTO::realizar-movimiento-humano-fase2
   (declare (salience -20))
   ?h1 <- (refrescar-fase2)
   =>
   (retract ?h1)
   (focus M-VALIDAR-TABLERO)
   (assert (refrescar-fase3))
)

(defrule M-REALIZAR-MOVIMIENTO::realizar-movimiento-humano-fase3
   (declare (salience -30))
   ?h1 <- (refrescar-fase3)
   =>
   (retract ?h1)
   (bind ?ok no)
   (bind ?l-tab-ok (find-all-facts ((?f tablero-correcto)) TRUE))
   (foreach ?tab-ok ?l-tab-ok 
       (bind ?ok (fact-slot-value ?tab-ok correcto))
       (retract ?tab-ok)
   )

   (if (eq ?ok si)
      then
         (printout t "TABLERO CORRECTO!!! (MAIN)" crlf)
         (assert (comienza-maquina))
      else
         (printout t "TABLERO INCORRECTO!!! (MAIN)" crlf)
         (assert (comienza-humano)))

   (do-for-all-facts ((?h-aux movimiento-humano-introducido)) TRUE 
                                                              (retract ?h-aux))

   (comprobar-final-de-juego)

   (focus M-JUGAR)
)

;;;
;;; LA MAQUINA JUEGA...
;;;
(defrule M-JUGAR::jugada-maquina-fase0
   ?h1 <- (comienza-maquina)
   =>
   (retract ?h1)

   (printout t "ME TOCA A MI..." crlf)
   (printout t crlf)

   (mostrar-fichas tablero)
   (mostrar-fichas maquina)
   (mostrar-fichas humano)

   (printout t "BUSCO MIS OPCIONES...Y JUEGO." crlf)   
   (desmarcar-escaleras maquina)   
   (desmarcar-series    maquina)
   (focus M-BUSCAR-COMBINACIONES)
   (assert (comienza-maquina-1))
)

(defrule M-JUGAR::jugada-maquina-fase1
   ?h1 <- (comienza-maquina-1)
   =>
   (retract ?h1)

   (bind ?he-colocado-ficha 0)

   ; JUGAR PRIMERO ESCALERAS...
   (bind ?jugar-escaleras-con-id (create$))
   (bind ?fichas-escaleras 
            (find-all-facts ((?f ficha)) 
                        (and (eq (fact-slot-value ?f ubicacion) maquina) 
                             (<> (fact-slot-value ?f marcada-escalera) -1))))
   (foreach ?ficha ?fichas-escaleras
      (if (eq (fact-slot-value ?ficha marcada-escalera) 
              (fact-slot-value ?ficha id-escalera)) then
         (bind ?jugar-escaleras-con-id 
            (insert$ ?jugar-escaleras-con-id 
                     (+ 1 (length$ ?jugar-escaleras-con-id)) 
                     (fact-slot-value ?ficha id-escalera)))
      )
   )

   (foreach ?escalera-con-id ?jugar-escaleras-con-id
      (bind ?id (obtener-siguiente-secuencia))
      (bind ?fichas-en-escalera
         (find-all-facts ((?f ficha))
            (and (eq (fact-slot-value ?f ubicacion) maquina)
                 (eq (fact-slot-value ?f id-jugada) -1)
                 (eq (fact-slot-value ?f id-escalera) ?escalera-con-id)
            )
         )
      )
      ; Hay que ordenar las fichas de la escalera ya que las podemos recibir
      ; desordenadas.
      
      (foreach ?ficha ?fichas-en-escalera
         (bind ?he-colocado-ficha 1)
         (modify ?ficha (ubicacion tablero)(id-jugada ?id)(ok-jugada ?id))
      )
   )

   ; ...LUEGO SERIES.
   (bind ?jugar-series-con-id (create$))
   (bind ?fichas-series 
            (find-all-facts ((?f ficha)) 
                  (and (eq (fact-slot-value ?f ubicacion) maquina) 
                       (<> (fact-slot-value ?f marcada-serie) -1))))
   (foreach ?ficha ?fichas-series
      (if (eq (fact-slot-value ?ficha marcada-serie)
              (fact-slot-value ?ficha id-serie)) then
         (bind ?jugar-series-con-id 
            (insert$ ?jugar-series-con-id (+ 1 (length$ ?jugar-series-con-id)) 
                                            (fact-slot-value ?ficha id-serie)))
      )
   )

   (foreach ?serie-con-id ?jugar-series-con-id
      (bind ?id (obtener-siguiente-secuencia))
      (bind ?fichas-en-serie
         (find-all-facts ((?f ficha))
            (and (eq (fact-slot-value ?f ubicacion) maquina)
                 (eq (fact-slot-value ?f id-jugada) -1)
                 (eq (fact-slot-value ?f id-serie) ?serie-con-id)
            )
         )
      )
      (foreach ?ficha ?fichas-en-serie
         (bind ?he-colocado-ficha 1)
         (modify ?ficha (ubicacion tablero)(id-jugada ?id)(ok-jugada ?id))
      )
   )

   (comprobar-final-de-juego)
   
   (mostrar-fichas tablero)
   (mostrar-fichas maquina)
   (mostrar-fichas humano)
   
   (if (eq ?he-colocado-ficha 1)
      then
         ;Paso el turno
         (assert (comienza-humano))
      else
         ; Robo y paso el turno
         (robar-ficha-maquina (obtener-siguiente-secuencia))
         (assert (comienza-humano))
   )
)