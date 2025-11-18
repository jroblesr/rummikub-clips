;;;
;;; (rummikub-m-hacer-disposicion-tablero-definitiva.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

;;; EN ESTE CASO CONVERTIMOS EL ESTADO DEL TABLERO A DEFINITIVO:
;;; COPIAMOS DE FICHA-TEMPORAL A FICHA
;;; CON LO QUE LA JUGADA QUEDA CONFIRMADA.

;;;
;;; REGLA PARA COPIAR
;;;
(defrule M-HACER-DISPOSICION-TABLERO-DEFINITIVA::copiar-de-temporal-a-definitivo-1
        ?h_desde <- (ficha-temporal (numero ?numero_temp);Clave localizar ficha
                                    (color  ?color_temp) ;Clave localizar ficha
                                    (bloque ?bloque_temp);Clave localizar ficha                                    
                                    (marcada-serie ?id-serie)
                                    (id-serie      ?id-serie)
                                    (marcada-escalera ?)
                                    (id-escalera      ?)
                                    (id-jugada-temp ?jt)
                                    (ok-jugada-temp ?jt)
                                    (fila    ?fila_temp)
                                    (columna ?columna_temp))

        ?h_hasta <- (ficha          (numero ?numero_temp)
                                    (color  ?color_temp)
                                    (bloque ?bloque_temp)
                                    (ubicacion ?)
                                    (sorteo ?)
                                    (marcada-serie ?)
                                    (id-serie      ?)
                                    (marcada-escalera ?)
                                    (id-escalera      ?)
                                    (orden ?)
                                    (id-jugada ?)
                                    (ok-jugada ?)
                                    (fila ?)
                                    (columna ?))
        =>
        (printout t "COPIANDO FICHA TEMPORAL DE SERIE A DEFINITIVA..." crlf)
        (modify ?h_hasta
                ;(numero ?)
                ;(color  ?)
                ;(bloque ?)
                (ubicacion tablero)
                ;(sorteo ?)
                (marcada-serie ?id-serie)
                (id-serie      ?id-serie)
                (marcada-escalera -1)
                (id-escalera       0)
                ;(orden ?)
                (id-jugada ?jt)
                (ok-jugada ?jt)
                (fila      ?fila_temp)
                (columna   ?columna_temp))
        (retract ?h_desde)
)

(defrule M-HACER-DISPOSICION-TABLERO-DEFINITIVA::copiar-de-temporal-a-definitivo-2
        ?h_desde <- (ficha-temporal (numero ?numero_temp);Clave localizar ficha
                                    (color  ?color_temp) ;Clave localizar ficha
                                    (bloque ?bloque_temp);Clave localizar ficha                                    
                                    (marcada-serie ?)
                                    (id-serie      ?)
                                    (marcada-escalera ?id-escalera)
                                    (id-escalera      ?id-escalera)
                                    (id-jugada-temp ?jt)
                                    (ok-jugada-temp ?jt)
                                    (fila    ?fila_temp)
                                    (columna ?columna_temp))

        ?h_hasta <- (ficha          (numero ?numero_temp)
                                    (color  ?color_temp)
                                    (bloque ?bloque_temp)
                                    (ubicacion ?)
                                    (sorteo ?)
                                    (marcada-serie ?)
                                    (id-serie      ?)
                                    (marcada-escalera ?)
                                    (id-escalera      ?)
                                    (orden ?)
                                    (id-jugada ?)
                                    (ok-jugada ?)
                                    (fila ?)
                                    (columna ?))
        =>
        (printout t "COPIANDO FICHA TEMPORAL DE ESCALERA A DEFINITIVA..." crlf)
        (modify ?h_hasta
                ;(numero ?)
                ;(color  ?)
                ;(bloque ?)
                (ubicacion tablero)
                ;(sorteo ?)
                (marcada-serie -1)
                (id-serie       0)
                (marcada-escalera ?id-escalera)
                (id-escalera      ?id-escalera)
                ;(orden ?)
                (id-jugada ?jt)
                (ok-jugada ?jt)
                (fila      ?fila_temp)
                (columna   ?columna_temp))
        (retract ?h_desde)
)