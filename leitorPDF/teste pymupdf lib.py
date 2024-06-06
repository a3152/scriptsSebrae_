import pymupdf # imports the pymupdf library
from pprint import pprint

caminho = "C:/Users/cesargl/OneDrive - SERVICO DE APOIO AS MICRO E PEQUENAS EMPRESAS DE SAO PAULO - SEBRAE/.git/scriptsSebrae_/teste_arquivos"
arquivo = "/3186 - DNC Consultoria e Treinamento empresarial ltda.pdf [manifesto].pdf"

doc = pymupdf.open(caminho+arquivo)
for page in doc: # iterate the document pages
  tabs = page.find_tables() # get plain text encoded as UTF-8
  if tabs.tables:  # at least one table found?
   df = page.find_tables().tables[1].to_pandas()
   print(df)




 