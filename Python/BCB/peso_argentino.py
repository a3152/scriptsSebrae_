from bcb import currency
import matplotlib.pyplot as plt


df = currency.get(['ARS'],
                    start='2000-01-01',
                  end='2024-06-12',
                    side = 'ask')

print(df)
df.plot(figsize=(10,5))
plt.show()