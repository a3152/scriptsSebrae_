from bcb import TaxaJuros
import pandas as pd
import matplotlib.pyplot as plt

em = TaxaJuros()
em.describe()
em.describe("TaxasJurosDiariaPorInicioPeriodo")
ep = em.get_endpoint('TaxasJurosDiariaPorInicioPeriodo')

df_cheque = (ep.query()
               .filter(ep.Segmento == 'PESSOA FÍSICA',
                       ep.Modalidade == 'Cheque especial - Pré-fixado')
               .collect())

grp = df_cheque.groupby('InicioPeriodo')
df_mean = grp.agg({'TaxaJurosAoMes': 'median'})
df_mean['TaxaJurosAoMes'].plot(figsize=(16,6), style='o', markersize=1,
                               xlabel='Data', ylabel='Taxa',
                               title='Mediana das Taxas de Juros de Cheque Especial - Fonte:BCB');
plt.show() 