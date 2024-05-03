from bcb import Expectativas
import matplotlib.pyplot as plt

em = Expectativas()
em.describe()

em.describe('ExpectativasMercadoTop5Anuais')

ep = em.get_endpoint('ExpectativasMercadoTop5Anuais')

ep.query().limit(10).collect()

ep.query().filter(ep.Indicador == 'IPCA').limit(10).collect()
(ep.query()
 .filter(ep.Indicador == 'IPCA', ep.DataReferencia == 2023)
 .filter(ep.Data >= '2022-01-01')
 .filter(ep.tipoCalculo == 'C')
 .select(ep.Data, ep.Media, ep.Mediana)
 .orderby(ep.Data.desc())
 .limit(10)
 .collect())

