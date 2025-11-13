;;;
;;; (rummikub-m-buscar-combinaciones.alt.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

(defrule M-BUSCAR-COMBINACIONES::jugar-maquina-buscar-escalera-5
        ; Escalera de 5 fichas sin comodín en los extremos.
        (declare (salience 50))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h4 <- (ficha (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h5 <- (ficha (numero ?n5&=(+ ?n1 4))    (color ?c)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5) 
                       (neq ?n2 ?n3 ?n4 ?n5)
                           (neq ?n3 ?n4 ?n5)
                               (neq ?n4 ?n5))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
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
        (printout ?*debug-print-3* 
        "YO TENGO UNA ESCALERA CON ["?n1","?n2","?n3","?n4","?n5"] ("?c")" crlf)

        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
        (modify ?h4 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 4))(id-serie 0))
        (modify ?h5 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 5))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-maquina-buscar-escalera-4
        ; Escalera de 4 fichas sin comodín en los extremos.
        (declare (salience 40))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin)
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        ?h4 <- (ficha (numero ?n4&=(+ ?n1 3))    (color ?c)         
                      (ubicacion maquina)
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3 ?n4) 
                       (neq ?n2 ?n3 ?n4)
                           (neq ?n3 ?n4))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
        (test
                (< 
                    ?n1  
                    (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                    (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                    (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                )                        
        )
        =>        
        (printout ?*debug-print-3* 
        "YO TENGO UNA ESCALERA CON ["?n1","?n2","?n3","?n4"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
        (modify ?h4 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 4))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-humano-buscar-escalera-5
        ; Escalera de 5 fichas sin comodín en los extremos.
        (declare (salience 50))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h4 <- (ficha (numero ?n4&0|=(+ ?n1 3))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h5 <- (ficha (numero ?n5&=(+ ?n1 4))    (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3 ?n4 ?n5)
                       (neq ?n2 ?n3 ?n4 ?n5)
                           (neq ?n3 ?n4 ?n5)
                               (neq ?n4 ?n5))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
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
        (printout ?*debug-print-3* 
        "USTED TIENE UNA ESCALERA CON ["?n1","?n2","?n3","?n4","?n5"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
        (modify ?h4 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 4))(id-serie 0))
        (modify ?h5 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 5))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-humano-buscar-escalera-4
        ; Escalera de 4 fichas sin comodín en los extremos.
        (declare (salience 40))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&0|=(+ ?n1 2))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h4 <- (ficha (numero ?n4&=(+ ?n1 3))    (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3 ?n4)
                       (neq ?n2 ?n3 ?n4)
                           (neq ?n3 ?n4))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
        (test
                (< 
                    ?n1  
                    (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                    (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                    (if (= ?n4  0) then (+ ?n1 3)  else ?n4 )  
                )                        
        )
        =>        
        (printout ?*debug-print-3* 
        "USTED TIENE UNA ESCALERA CON ["?n1","?n2","?n3","?n4"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
        (modify ?h4 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 4))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-maquina-buscar-escalera-3
        (declare (salience 30))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion maquina) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin) 
                      (ubicacion maquina) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&=(+ ?n1 2))    (color ?c)         
                      (ubicacion maquina) 
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3)
                       (neq ?n2 ?n3))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
        (test
                (< 
                    ?n1  
                    (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                    (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                )                        
        )
        =>        
        (printout ?*debug-print-3* 
        "YO TENGO UNA ESCALERA CON ["?n1","?n2","?n3"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-humano-buscar-escalera-3
        (declare (salience 30))
        ?h1 <- (ficha (numero ?n1&~0)            (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h2 <- (ficha (numero ?n2&0|=(+ ?n1 1))  (color ?c|comodin) 
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        ?h3 <- (ficha (numero ?n3&=(+ ?n1 2))    (color ?c)         
                      (ubicacion humano) 
                      (marcada-escalera -1) (marcada-serie -1))
        (test (and (neq ?n1 ?n2 ?n3)
                       (neq ?n2 ?n3))) ; Sólo un comodín por escalera.
        ; Las escaleras están ordenadas. Un comodín en el medio es un problema.
        (test
                (< 
                    ?n1  
                    (if (= ?n2  0) then (+ ?n1 1)  else ?n2 )  
                    (if (= ?n3  0) then (+ ?n1 2)  else ?n3 )  
                )                
        )
        =>        
        (printout ?*debug-print-3* 
        "USTED TIENE UNA ESCALERA CON ["?n1","?n2","?n3"] ("?c")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (bind ?orden-escalera 0)
        (modify ?h1 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 1))(id-serie 0))
        (modify ?h2 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 2))(id-serie 0))
        (modify ?h3 (marcada-escalera ?id)(id-escalera ?id)
                    (orden (+ ?orden-escalera 3))(id-serie 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-maquina-buscar-serie-4
        (declare (salience 40))
        ?h1 <- (ficha (numero ?n1&~0)     (color ?c1) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h2 <- (ficha (numero ?n2&0|?n1)  (color ?c2) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h3 <- (ficha (numero ?n3&0|?n1)  (color ?c3) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h4 <- (ficha (numero ?n4&?n1)    (color ?c4) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        (test (and (neq ?c1 ?c2 ?c3 ?c4)
                       (neq ?c2 ?c3 ?c4)
                           (neq ?c3 ?c4))) ; Sólo un comodín por serie.
        =>        
        (printout ?*debug-print-3* 
        "YO TENGO UNA SERIE CON ["?n1"] ("?c1","?c2","?c3","?c4")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h2 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h3 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h4 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-humano-buscar-serie-4
        (declare (salience 40))
        ?h1 <- (ficha (numero ?n1&~0)     (color ?c1) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h2 <- (ficha (numero ?n2&0|?n1)  (color ?c2) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h3 <- (ficha (numero ?n3&0|?n1)  (color ?c3) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h4 <- (ficha (numero ?n4&?n1)    (color ?c4) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        (test (and (neq ?c1 ?c2 ?c3 ?c4)
                       (neq ?c2 ?c3 ?c4)
                           (neq ?c3 ?c4))) ; Sólo un comodín por serie.
        =>        
        (printout ?*debug-print-3* 
        "USTED TIENE UNA SERIE CON ["?n1"] ("?c1","?c2","?c3","?c4")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h2 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h3 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h4 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-maquina-buscar-serie-3
        (declare (salience 30))
        ?h1 <- (ficha (numero ?n1&~0)     (color ?c1) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h2 <- (ficha (numero ?n2&0|?n1)  (color ?c2) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h3 <- (ficha (numero ?n3&?n1)    (color ?c3) 
                      (ubicacion maquina) 
                      (marcada-serie -1) (marcada-escalera -1))
        (test (and (neq ?c1 ?c2 ?c3)
                       (neq ?c2 ?c3))) ; Sólo un comodín por serie.
        =>        
        (printout ?*debug-print-3* 
        "YO TENGO UNA SERIE CON ["?n1"] ("?c1","?c2","?c3")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h2 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h3 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
)

(defrule M-BUSCAR-COMBINACIONES::jugar-humano-buscar-serie-3
        (declare (salience 30))
        ?h1 <- (ficha (numero ?n1&~0)     (color ?c1) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h2 <- (ficha (numero ?n2&0|?n1)  (color ?c2) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        ?h3 <- (ficha (numero ?n3&?n1)    (color ?c3) 
                      (ubicacion humano) 
                      (marcada-serie -1) (marcada-escalera -1))
        (test (and (neq ?c1 ?c2 ?c3)
                       (neq ?c2 ?c3))) ; Sólo un comodín por serie.
        =>        
        (printout ?*debug-print-3* 
        "USTED TIENE UNA SERIE CON ["?n1"] ("?c1","?c2","?c3")" crlf)
        (bind ?id (obtener-siguiente-secuencia))
        (modify ?h1 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h2 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
        (modify ?h3 (marcada-serie ?id)(id-serie ?id)(id-escalera 0))
)