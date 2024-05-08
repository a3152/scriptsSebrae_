import pandas as pd
from pandas import DataFrame
from schema import InventarioSchema

minha_tabela: DataFrame = pd.read_excel("data\inventario_mundo.xlsx")

try:
    InventarioSchema.validate(minha_tabela)
    print("Excel esta bom!")
except Exception as e:
    print(f"Teve erro de schema: {e}")