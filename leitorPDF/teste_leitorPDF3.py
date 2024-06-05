import os
import pandas as pd
import PyPDF2
import re

#setando caminho
caminho = "S:/_CON/Monitoramento de Contratos e Convênios/CADASTRO DE CONTRATOS/CREDENCIAMENTO - SGF/CONTRATOS SGF/CONTRATOS SGF 2024/Contratos/"

#caminho = "C:/Users/cesargl/OneDrive - SERVICO DE APOIO AS MICRO E PEQUENAS EMPRESAS DE SAO PAULO - SEBRAE/.git/scriptsSebrae_/teste_arquivos"
lst=[]
#loop para pegar todos os arquivos+caminho
for nomesarquivos in  os.listdir(caminho):
       # Abrindo arquivo
    with open(os.path.join(caminho, nomesarquivos)) as f:
        pdf_file = open(f.name,'rb')
        print(f.name)
        dados_pdf = PyPDF2.PdfReader(pdf_file)
        
        #define e faz contagem de caracteres dos objetos procurados
        numContrato = 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS  Nº '
        contStrgContrato = len(numContrato)

        Unidade = 'Unidade/ER demandante: '
        contStrgUnidade = len(Unidade)

        cnpj = 'CNPJ/MF nº   '
        contStrgcnpj = len(cnpj)

        representante = 'Representante legal: '
        contStrgrepresentante = len(representante)

        cpf = 'CPF:  '
        contStrgCPF = len(cpf)

        natureza = 'Natureza prestação de serviço (Consultoria ou Instrut oria):  '
        contStrgNatureza = len(natureza)


        #define pagina1 do documento para leitura
        
        pagina1 = dados_pdf.pages[0]
        texto_da_pagina1 = pagina1.extract_text()
        texto_da_pagina1 = re.sub('\n','',texto_da_pagina1)
        
        #achando os valores no texto
        findContrato=texto_da_pagina1.find(numContrato)
        findUnidade=texto_da_pagina1.find(Unidade)
        findCnpj=texto_da_pagina1.find(cnpj,700)
        findRepresentante=texto_da_pagina1.find(representante)
        findcpf=texto_da_pagina1.find(cpf,700)
        findnatureza=texto_da_pagina1.find(natureza)
        print(findnatureza)


        df = pd.DataFrame({"descricao": [texto_da_pagina1]})

        print(caminho)
        df["N° Contrato"] = texto_da_pagina1[findContrato+contStrgContrato:findContrato+contStrgContrato+10]
        df["Unidade"] = texto_da_pagina1[findUnidade+contStrgUnidade:findUnidade+contStrgUnidade+20]
        df["CNPJ"] = texto_da_pagina1[findCnpj+contStrgcnpj:findCnpj+contStrgcnpj+19]
        df["Representante"] = texto_da_pagina1[findRepresentante+contStrgrepresentante:findRepresentante+contStrgrepresentante+20]
        df["CPF"] = texto_da_pagina1[findcpf+contStrgCPF:findcpf+contStrgCPF+16]
        df["Natureza prestação de serviço"] = texto_da_pagina1[findnatureza+contStrgNatureza:findnatureza+contStrgNatureza+12]

        lst.append(df)
df = pd.concat(lst, axis=0 )
df.to_excel("final_v0.xlsx")
