import os
import pandas as pd
from PyPDF2 import PdfReader
from datetime import datetime
import re

#setando caminho
caminho = "S:/_CON/Monitoramento de Contratos e Convênios/CADASTRO DE CONTRATOS/CREDENCIAMENTO - SGF/CONTRATOS SGF/CONTRATOS SGF 2024/Contratos/"

#caminho = "C:/Users/cesargl/OneDrive - SERVICO DE APOIO AS MICRO E PEQUENAS EMPRESAS DE SAO PAULO - SEBRAE/.git/scriptsSebrae_/teste_arquivos"
#define serie
lst=[]

#loop para pegar todos os arquivos+caminho
for nomesarquivos in  os.listdir(caminho):
       # Abrindo arquivos
    with open(os.path.join(caminho, nomesarquivos)) as f: 
        pdf_file = open(f.name,'rb')  
        dados_pdf = PdfReader(pdf_file)
        
        #define e faz contagem de caracteres dos objetos procurados
        numContrato = 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS  Nº '
        contStrgContrato = len(numContrato)

        Unidade = 'Unidade/ER demandante: '
        contStrgUnidade = len(Unidade)

        GERENTE_LIMITE = '   Gerente'
        
    
        cnpj = 'CNPJ/MF nº   '
        contStrgcnpj = len(cnpj)

        representante = 'Representante legal: '
        contStrgrepresentante = len(representante)
        RG_LIMITE = '  RG:'

        cpf = 'CPF:  '
        contStrgCPF = len(cpf)

        natureza = 'Natureza prestação de serviço (Consultoria ou Instrut oria):  '
        contStrgNatureza = len(natureza)

        objeto = 'Objeto da Contratação: '
        constStrgObjeto = len(objeto)

        valor = 'Valor:  '
        constStrValor = len(valor)

        vigencia = 'Vigência: '
        constStrVigencia = len(vigencia)

        cargaHoraria = 'Carga horária:  '
        constStrgCargaHoraria = len(cargaHoraria)

        Local = 'Local d e execução do serviço: '
        constStrgLocal = len(Local)

        Data_assinatura =  '***-'
        constStrgData_assinatura = len(Data_assinatura)+5

        #define paginas do documento para leitura
        
        ultimapagina=dados_pdf.numPages-1

        pagina1 = dados_pdf.pages[0]
        texto_da_pagina1 = pagina1.extract_text()
        texto_da_pagina1 = re.sub('\n','',texto_da_pagina1)

        pagina2 = dados_pdf.pages[1]
        texto_da_pagina2 = pagina2.extract_text() 
        texto_da_pagina2 = re.sub('\n','',texto_da_pagina2)   

        pagina_ultima = dados_pdf.pages[ultimapagina]
        texto_paginaUltima = pagina_ultima.extract_text()
        texto_paginaUltima = re.sub('\n','',texto_paginaUltima)   
      
        #unindo textos das paginas
        concatText = texto_da_pagina1+texto_da_pagina2


        #achando os valores no texto
        findContrato=concatText.find(numContrato)
        findUnidade=concatText.find(Unidade)
        findCnpj=concatText.find(cnpj,700)
        findRepresentante=concatText.find(representante)
        findcpf=concatText.find(cpf,1000)
        findnatureza=concatText.find(natureza)
        findObjeto=concatText.find(objeto)
        findValor=concatText.find(valor)
        findVigencia=concatText.find(vigencia)
        findcarga=concatText.find(cargaHoraria)
        findLocal=concatText.find(Local)
        findGERENTE=concatText.find(GERENTE_LIMITE)
        findRG=concatText.find(RG_LIMITE,1000)
        findData1 = texto_paginaUltima.find(Data_assinatura)
        findData2 = texto_paginaUltima.find(Data_assinatura,findData1+50)
        findData3 = texto_paginaUltima.find(Data_assinatura,findData2+50)
        findData4 = texto_paginaUltima.find(Data_assinatura,findData3+50)
        print(findData4)

        #criando dataframe
        data=[{}]
        compara_data=[]

        df = pd.DataFrame(data)
        df2 = pd.DataFrame(compara_data)

        #print(pdf_file.name)
        df["N° Contrato"] = concatText[findContrato+contStrgContrato:findContrato+contStrgContrato+10]
        df["Unidade"] = concatText[findUnidade+contStrgUnidade:findGERENTE]
        df["CNPJ"] = concatText[findCnpj+contStrgcnpj:findCnpj+contStrgcnpj+19]
        df["Representante"] = concatText[findRepresentante+contStrgrepresentante:findRG]
        df["CPF"] = concatText[findcpf+ contStrgCPF:findcpf+contStrgCPF+16]
        df["Natureza prestação de serviço"] = concatText[findnatureza+contStrgNatureza:findnatureza+contStrgNatureza+12]
        df["Objeto"] = concatText[findObjeto+constStrgObjeto:findObjeto+constStrgObjeto+232]
        df["Valor"] = concatText[findValor+constStrValor:findValor+constStrValor+12]
        df["Vigência"] = concatText[findVigencia+constStrVigencia:findVigencia+constStrVigencia+23]
        df["Carga Horária"] = concatText[findcarga+constStrgCargaHoraria:findLocal]
        df["Local de Execução"] = concatText[findLocal+constStrgLocal:findLocal+constStrgLocal+12]
        df["DATA1"] = texto_paginaUltima[findData1+constStrgData_assinatura:findData1+constStrgData_assinatura+20]
        df["DATA2"] = texto_paginaUltima[findData2+constStrgData_assinatura:findData2+constStrgData_assinatura+20]
        df["DATA3"] = texto_paginaUltima[findData3+constStrgData_assinatura:findData3+constStrgData_assinatura+20]
        if findData4 < findData3:   
            df["DATA4"] = 0
        else:
            df["DATA4"] = texto_paginaUltima[findData4+constStrgData_assinatura:findData4+constStrgData_assinatura+20]

        df["DATA1"] = pd.to_datetime(df["DATA1"],dayfirst=True)
        df["DATA2"] = pd.to_datetime(df["DATA2"],dayfirst=True)
        df["DATA3"] = pd.to_datetime(df["DATA3"],dayfirst=True)
        df["DATA4"] = pd.to_datetime(df["DATA4"],dayfirst=True)

        
        compara_data=[df['DATA1'].tolist(),df['DATA2'].tolist(),df['DATA3'].tolist(),df['DATA4'].tolist()]

        
        df["DATA_final"] = max(compara_data)

        #seta a serie e atribui ao dataframe
        lst.append(df)
        
        

        #uni as dfs
        df = pd.concat(lst, axis=0 )
        print(nomesarquivos)
df.to_excel("final_v01.xlsx")   