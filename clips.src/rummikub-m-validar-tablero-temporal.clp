;;;
;;; (rummikub-m-validar-tablero-temporal.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

;;; EN ESTE CASO COMPROBARMOS LA CONFIGURACION TEMPORAL DEL TABLERO
;;; ANTES DE CONFIRMAR LA JUGADA.

;;;
;;; REGLAS PARA BUSCAR ESCALERAS
;;;
(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-13
        ; Escalera de 13 fichas sin comodín en los extremos.
        (declare (salience +130))
        (validar-tablero)
        ?h1 <-  (ficha-temporal (numero   ?n1&~0)            (color ?c)           (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h2 <-  (ficha-temporal (numero   ?n2&0|=(+ ?n1 1))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h3 <-  (ficha-temporal (numero   ?n3&0|=(+ ?n1 2))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h4 <-  (ficha-temporal (numero   ?n4&0|=(+ ?n1 3))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h5 <-  (ficha-temporal (numero   ?n5&0|=(+ ?n1 4))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h6 <-  (ficha-temporal (numero   ?n6&0|=(+ ?n1 5))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h7 <-  (ficha-temporal (numero   ?n7&0|=(+ ?n1 6))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h8 <-  (ficha-temporal (numero   ?n8&0|=(+ ?n1 7))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h9 <-  (ficha-temporal (numero   ?n9&0|=(+ ?n1 8))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h10 <- (ficha-temporal (numero  ?n10&0|=(+ ?n1 9))  (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h11 <- (ficha-temporal (numero  ?n11&0|=(+ ?n1 10)) (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h12 <- (ficha-temporal (numero  ?n12&0|=(+ ?n1 11)) (color ?c|comodin)   (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ?h13 <- (ficha-temporal (numero  ?n13&=(+ ?n1 12))   (color ?c)           (bloque ?) (id-jugada-temp ?i) (ok-jugada-temp ?o&~?i) (fila ?) (columna ?))
        ;La función neq devuelve el símbolo TRUE si su primer argumento 
        ; no es igual en valor a todos sus argumentos subsiguientes...
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                                   (neq ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                                       (neq ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                                           (neq ?n7 ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                                               (neq ?n8 ?n9 ?n10 ?n11 ?n12 ?n13)
                                                   (neq ?n9 ?n10 ?n11 ?n12 ?n13)
                                                       (neq ?n10 ?n11 ?n12 ?n13)
                                                            (neq ?n11 ?n12 ?n13)
                                                                 (neq ?n12 ?n13)
                )
        )
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1))(color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. Un comodín por el medio es un problema
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
                (if (= ?n9  0) then (+ ?n1 8)  else ?n9 )  
                (if (= ?n10 0) then (+ ?n1 9)  else ?n10)   
                (if (= ?n11 0) then (+ ?n1 10) else ?n11)   
                (if (= ?n12 0) then (+ ?n1 11) else ?n12)   
                (if (= ?n13 0) then (+ ?n1 12) else ?n13)  
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8","?n9","?n10","?n11","?n12","?n13"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h9 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h10 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h11 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h12 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h13 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-12
        ; Escalera de 12 fichas sin comodín en los extremos.
        (declare (salience +120))
        (validar-tablero)
        ?h1 <-  (ficha-temporal (numero ?n1&~0)             (color ?c)         (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <-  (ficha-temporal (numero ?n2&0|=(+ ?n1 1))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <-  (ficha-temporal (numero ?n3&0|=(+ ?n1 2))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <-  (ficha-temporal (numero ?n4&0|=(+ ?n1 3))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <-  (ficha-temporal (numero ?n5&0|=(+ ?n1 4))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <-  (ficha-temporal (numero ?n6&0|=(+ ?n1 5))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <-  (ficha-temporal (numero ?n7&0|=(+ ?n1 6))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h8 <-  (ficha-temporal (numero ?n8&0|=(+ ?n1 7))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h9 <-  (ficha-temporal (numero ?n9&0|=(+ ?n1 8))   (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h10 <- (ficha-temporal (numero ?n10&0|=(+ ?n1 9))  (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h11 <- (ficha-temporal (numero ?n11&0|=(+ ?n1 10)) (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h12 <- (ficha-temporal (numero ?n12&=(+ ?n1 11))   (color ?c)         (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
         ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                                   (neq ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                                       (neq ?n6 ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                                           (neq ?n7 ?n8 ?n9 ?n10 ?n11 ?n12)
                                               (neq ?n8 ?n9 ?n10 ?n11 ?n12)
                                                   (neq ?n9 ?n10 ?n11 ?n12)
                                                       (neq ?n10 ?n11 ?n12)
                                                            (neq ?n11 ?n12)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
                (if (= ?n9  0) then (+ ?n1 8)  else ?n9 )  
                (if (= ?n10 0) then (+ ?n1 9)  else ?n10)   
                (if (= ?n11 0) then (+ ?n1 10) else ?n11)   
                (if (= ?n12 0) then (+ ?n1 11) else ?n12)   
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8","?n9","?n10","?n11","?n12"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h9 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h10 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h11 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h12 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-11
        ; Escalera de 11 fichas sin comodín en los extremos.
        (declare (salience +110))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&0|=(+ ?n1 5))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <- (ficha-temporal (numero ?n7&0|=(+ ?n1 6))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h8 <- (ficha-temporal (numero ?n8&0|=(+ ?n1 7))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h9 <- (ficha-temporal (numero ?n9&0|=(+ ?n1 8))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h10 <- (ficha-temporal (numero ?n10&0|=(+ ?n1 9)) (color ?c|comodin) (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h11 <- (ficha-temporal (numero ?n11&=(+ ?n1 10))  (color ?c)         (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                                   (neq ?n5 ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                                       (neq ?n6 ?n7 ?n8 ?n9 ?n10 ?n11)
                                           (neq ?n7 ?n8 ?n9 ?n10 ?n11)
                                               (neq ?n8 ?n9 ?n10 ?n11)
                                                   (neq ?n9 ?n10 ?n11)
                                                       (neq ?n10 ?n11)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
                (if (= ?n9  0) then (+ ?n1 8)  else ?n9 )  
                (if (= ?n10 0) then (+ ?n1 9)  else ?n10)   
                (if (= ?n11 0) then (+ ?n1 10) else ?n11)   
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8","?n9","?n10","?n11"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h9 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h10 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h11 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-10
        ; Escalera de 10 fichas sin comodín en los extremos.
        (declare (salience +100))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&0|=(+ ?n1 5))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <- (ficha-temporal (numero ?n7&0|=(+ ?n1 6))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h8 <- (ficha-temporal (numero ?n8&0|=(+ ?n1 7))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h9 <- (ficha-temporal (numero ?n9&0|=(+ ?n1 8))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h10 <- (ficha-temporal (numero ?n10&=(+ ?n1 9))   (color ?c)         (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8 ?n9 ?n10)
                                   (neq ?n5 ?n6 ?n7 ?n8 ?n9 ?n10)
                                       (neq ?n6 ?n7 ?n8 ?n9 ?n10)
                                           (neq ?n7 ?n8 ?n9 ?n10)
                                               (neq ?n8 ?n9 ?n10)
                                                   (neq ?n9 ?n10)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
                (if (= ?n9  0) then (+ ?n1 8)  else ?n9 )  
                (if (= ?n10 0) then (+ ?n1 9)  else ?n10)   
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8","?n9","?n10"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h9 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h10 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-9
        ; Escalera de 9 fichas sin comodín en los extremos.
        (declare (salience +90))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&0|=(+ ?n1 5))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <- (ficha-temporal (numero ?n7&0|=(+ ?n1 6))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h8 <- (ficha-temporal (numero ?n8&0|=(+ ?n1 7))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h9 <- (ficha-temporal (numero ?n9&=(+ ?n1 8))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8 ?n9)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8 ?n9)
                                   (neq ?n5 ?n6 ?n7 ?n8 ?n9)
                                       (neq ?n6 ?n7 ?n8 ?n9)
                                           (neq ?n7 ?n8 ?n9)
                                               (neq ?n8 ?n9)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
                (if (= ?n9  0) then (+ ?n1 8)  else ?n9 )  
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8","?n9"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h9 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-8
        ; Escalera de 8 fichas sin comodín en los extremos.
        (declare (salience +80))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&0|=(+ ?n1 5))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <- (ficha-temporal (numero ?n7&0|=(+ ?n1 6))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h8 <- (ficha-temporal (numero ?n8&=(+ ?n1 7))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7 ?n8)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7 ?n8)
                               (neq ?n4 ?n5 ?n6 ?n7 ?n8)
                                   (neq ?n5 ?n6 ?n7 ?n8)
                                       (neq ?n6 ?n7 ?n8)
                                           (neq ?n7 ?n8)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
                (if (= ?n8  0) then (+ ?n1 7)  else ?n8 )  
            )
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7","?n8"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h8 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-7
        ; Escalera de 7 fichas sin comodín en los extremos.
        (declare (salience +70))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&0|=(+ ?n1 5))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h7 <- (ficha-temporal (numero ?n7&=(+ ?n1 6))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6 ?n7)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6 ?n7)
                           (neq ?n3 ?n4 ?n5 ?n6 ?n7)
                               (neq ?n4 ?n5 ?n6 ?n7)
                                   (neq ?n5 ?n6 ?n7)
                                       (neq ?n6 ?n7)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
                (if (= ?n7  0) then (+ ?n1 6)  else ?n7 )  
            )        
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6","?n7"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h7 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-6
        ; Escalera de 6 fichas sin comodín en los extremos.
        (declare (salience +60))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&0|=(+ ?n1 4))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h6 <- (ficha-temporal (numero ?n6&=(+ ?n1 5))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5 ?n6)
                       (neq ?n2 ?n3 ?n4 ?n5 ?n6)
                           (neq ?n3 ?n4 ?n5 ?n6)
                               (neq ?n4 ?n5 ?n6)
                                   (neq ?n5 ?n6)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test 
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
                (if (= ?n6  0) then (+ ?n1 5)  else ?n6 )  
            )                
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5","?n6"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h6 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-5
        ; Escalera de 5 fichas sin comodín en los extremos.
        (declare (salience +50))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)  (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h5 <- (ficha-temporal (numero ?n5&=(+ ?n1 4))    (color ?c)          (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5)
                       (neq ?n2 ?n3 ?n4 ?n5)
                           (neq ?n3 ?n4 ?n5)
                               (neq ?n4 ?n5))) ; Sólo un comodín por escalera.
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                (if (= ?n5  0) then (+ ?n1 4)  else ?n5 )  
            )                
        )
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4","?n5"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h5 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-4
        ; Escalera de 4 fichas sin comodín en los extremos.
        (declare (salience +40))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&=(+ ?n1 3))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3 ?n4)
                       (neq ?n2 ?n3 ?n4)
                           (neq ?n3 ?n4)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
            )
        )                
        =>
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3","?n4"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-escalera-3
        (declare (salience +30))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)            (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)  (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&=(+ ?n1 2))    (color ?c)          (bloque ?)(id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por escalera.
        (test (and (neq ?n1 ?n2 ?n3)
                       (neq ?n2 ?n3)))
        (not (exists (ficha-temporal (numero ?x&:(< ?x ?n1)) (color ?c)(id-jugada-temp ?i)(ok-jugada-temp ~?i))))
        ; Las escaleras están ordenadas. El problema es un comodín por el medio
        (test
            (< 
                ?n1  
                (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
            )    
        )                    
        =>        
        (printout ?*debug-m-val-tab-temp* "ESCALERA EN MESA ["?n1","?n2","?n3"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-escalera ?id)(id-escalera ?id))
)

;;;
;;; REGLAS PARA BUSCAR SERIES
;;;
(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-serie-4
        (declare (salience +20))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)     (color ?c1) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|?n1)  (color ?c2) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&0|?n1)  (color ?c3) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h4 <- (ficha-temporal (numero ?n4&?n1)    (color ?c4) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por serie.
        (test (and (neq ?c1 ?c2 ?c3 ?c4)
                       (neq ?c2 ?c3 ?c4)
                           (neq ?c3 ?c4)))
        =>        
        (printout ?*debug-m-val-tab-temp* "SERIE    EN MESA ["?n1"] ("?c1","?c2","?c3","?c4")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
        (modify ?h4 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-buscar-serie-3
        (declare (salience +10))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?n1&~0)     (color ?c1) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h2 <- (ficha-temporal (numero ?n2&0|?n1)  (color ?c2) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ?h3 <- (ficha-temporal (numero ?n3&?n1)    (color ?c3) (bloque ?) (id-jugada-temp ?i)(ok-jugada-temp ?o&~?i)(fila ?)(columna ?))
        ; Sólo un comodín por serie.
        (test (and (neq ?c1 ?c2 ?c3)
                       (neq ?c2 ?c3)))
        =>        
        (printout ?*debug-m-val-tab-temp* "SERIE    EN MESA ["?n1"] ("?c1","?c2","?c3")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
        (modify ?h2 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
        (modify ?h3 (ok-jugada-temp ?i)(marcada-serie ?id)(id-serie ?id))
)

;;;
;;; TOMAR LA DECISION
;;;
(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-no-correcto
        (declare (salience -10))
        (validar-tablero)
        ?h1 <- (ficha-temporal (numero ?) (color ?) (bloque ?) (id-jugada-temp ?i&~-1) (ok-jugada-temp -1)(fila ?) (columna ?))
        =>
        (printout t "TABLERO-TEMP INCORRECTO!!! JUGADA=("?i")" crlf)
        (assert (tablero-temp-correcto (correcto no)(id-jugada-temp ?i)))
        (por-ultimo-decidir-sobre-tablero-temporal)
)

(defrule M-VALIDAR-TABLERO-TEMPORAL::tablero-temp-si-correcto
        (declare (salience -20))
        (validar-tablero)
        (not (exists (tablero-temp-correcto (correcto no)(id-jugada-temp ?i&~-1))))
        (not (exists (ficha-temporal (numero ?) (color ?) (bloque ?) (id-jugada-temp ?) (ok-jugada-temp -1)(fila ?) (columna ?))))
        =>
        (printout t "TABLERO-TEMP CORRECTO!!!" crlf)
        (assert (tablero-temp-correcto (correcto si)(id-jugada-temp -1)))
        (por-ultimo-decidir-sobre-tablero-temporal)
)