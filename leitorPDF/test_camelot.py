import camelot
import os
import pandas as pd

caminho = "C:/Users/cesargl/OneDrive - SERVICO DE APOIO AS MICRO E PEQUENAS EMPRESAS DE SAO PAULO - SEBRAE/.git/scriptsSebrae_/teste_arquivos"

lst=[]
#loop para pegar todos os arquivos+caminho
for nomesarquivos in  os.listdir(caminho):
       # Abrindo arquivo
    with open(os.path.join(caminho, nomesarquivos)) as f:   
        tables = camelot.read_pdf(f.name)
        tables.export('foo.xlsx', f='excel', compress=True) # json, excel, html, markdown, sqlite
        tables[0]
    