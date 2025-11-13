;;;
;;; (rummikub-modulos.clp)
;;;
;;; Sistema Experto en CLIPS para jugar al Rummikub
;;;

(defmodule MAIN                        (export ?ALL ))

(defmodule M-SORTEAR-FICHAS            (export ?NONE)
                                         (import MAIN ?ALL))

(defmodule M-MOSTRAR-FICHAS            (export ?NONE)
                                         (import MAIN ?ALL))

(defmodule M-BUSCAR-COMBINACIONES      (export ?NONE)
                                         (import MAIN ?ALL))

(defmodule M-JUGAR                     (export ?ALL )
                                         (import MAIN ?ALL))

(defmodule M-REALIZAR-MOVIMIENTO       (export ?ALL )
                                         (import MAIN ?ALL)
                                         (import M-JUGAR ?ALL))

(defmodule M-VALIDAR-TABLERO           (export ?NONE)
                                         (import MAIN ?ALL)
                                         (import M-JUGAR ?ALL)
                                         (import M-REALIZAR-MOVIMIENTO ?ALL))
                                         
(defmodule M-VALIDAR-TABLERO-TEMPORAL  (export ?ALL )
                                         (import MAIN ?ALL))

(defmodule M-HACER-DISPOSICION-TABLERO-DEFINITIVA (export ?NONE)
                                                    (import MAIN ?ALL))