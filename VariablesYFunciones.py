###
### (VariablesYFunciones.py)
###
### Sistema Experto en CLIPS para jugar al Rummikub
###

# Las variables y funciones de este módulo se utilizan de forma global.

# Las funciones definidas aquí deben ser lo más autónomas posibles:
# * mínimo acoplamiento y
# * máxima cohesión.

import re

def parsear_fact_string(fact_str):
    """ Parsea una cadena de tipo fact(ficha) CLIPS y devuelve un diccionario con los campos y valores. """
    # Elimina el encabezado '(ficha ' y el paréntesis final (:-1).
    # Nos quedamos con el contenido.
    fact_str = fact_str.strip()
    if fact_str.startswith('(ficha '):
        fact_str = fact_str[len('(ficha '):-1]
    # La expresión regular busca patrones como (clave valor)
    # ([\w-]+) captura la 'clave' (una o más letras/números/guiones)
    # ([^)]+) captura el 'valor' (cualquier cosa hasta el siguiente ')')
    matches = re.findall(r'\(([\w-]+)\s+([^)]+)\)', fact_str)
    return {campo: valor for campo, valor in matches}