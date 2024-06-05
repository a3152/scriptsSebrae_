import os
import pandas as pd
import PyPDF2
import re

#setando caminho
caminho = "S:/_CON/Monitoramento de Contratos e Convênios/CADASTRO DE CONTRATOS/CREDENCIAMENTO - SGF/CONTRATOS SGF/CONTRATOS SGF 2024/Contratos/"

lst=[]
#loop para pegar todos os arquivos+caminho
for nomesarquivos in  os.listdir(caminho):
       # Open file
    with open(os.path.join(caminho, nomesarquivos)) as f:
        pdf_file = open(f.name,'rb')
        print(f.name)
        dados_pdf = PyPDF2.PdfReader(pdf_file)
        
        #Após pegar o binário, pegamos os dados do PDF desse binario
        
       
        pagina1 = dados_pdf.pages[0]
        texto_da_pagina1 = pagina1.extract_text()
        texto_da_pagina1 = re.sub('\n','',texto_da_pagina1)
        

        s = pd.Series(texto_da_pagina1)
        lst.append(s)

df = pd.concat(lst, axis=0 )
df.to_excel("output_test1.xlsx")

