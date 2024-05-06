from bcb import PTAX
from bcb import currency
import matplotlib.pyplot as plt

ptax = PTAX()
ptax.describe()

ptax.describe('Moedas')
ep = ptax.get_endpoint('Moedas')

ep.query().limit(10).collect()

ptax.describe('CotacaoMoedaDia')

ep = ptax.get_endpoint('CotacaoMoedaDia')

(ep.query()
   .parameters(moeda='AUD', dataCotacao='1/31/2022')
   .collect())

ptax.describe('CotacaoMoedaPeriodo')

ep = ptax.get_endpoint('CotacaoMoedaPeriodo')

(ep.query()
   .parameters(moeda='AUD',
               dataInicial='1/1/2022',
               dataFinalCotacao='1/5/2022')
   .collect())

df = currency.get(['USD', 'EUR'],
                  start='2000-01-01',
                  end='2021-01-01',
                  side='ask')


df.head()
df.plot(figsize=(12, 6));

currency.get_currency_list().head()
plt.show()  