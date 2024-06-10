from office365.sharepoint.client_context import ClientContext

# Defina os detalhes de autenticação
site_url = 'https://sebraesp-my.sharepoint.com/:f:/g/personal/millenysar_sebraesp_com_br/EvBDn2FsC2tClPuKO_pWbBAB0OWUrdv0EyJuas6uFtCcdg?e=E3OfrJ'
username = 'cesargl@sebraesp.com.br'
password = 'sebrae@1234'

# Crie o contexto do cliente
ctx = ClientContext(site_url).with_credentials(username, password)

# Agora você pode usar o contexto para acessar o SharePoint