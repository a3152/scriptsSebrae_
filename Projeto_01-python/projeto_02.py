import pandas as pd
from pandas import DataFrame
from schema import InventarioSchema

import streamlit as st

import sqlite3


def main():
        st.title("Esse é o validador dos dados")

        arquivo = st.file_uploader("Escolha um arquivo Excel", type=["xlsx"])
        if arquivo is not None:
             
             data_frame =  pd.read_excel(arquivo)

             try:
                InventarioSchema.validate(data_frame)
                st.success("Excel esta bom!")
                if st.button("Salvar no Banco de Dados"):
                     #Criando conexão com o banco de dados SQLite
                     con = sqlite3.connect('inventario.db')
                     data_frame.to_sql("inventario",con,if_exists='replace', index=False)
                     st.success("Dados salvos com sucesso no banco de dados!")
                     con.close()
             except Exception as e:
                st.error(f"Teve erro de schema: {e}")
if __name__ == "__main__":
      main()