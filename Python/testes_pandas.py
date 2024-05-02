#testes pandas
import pandas as pd
import seaborn as sns   

#1
#importando dataset exemplo

df = sns.load_dataset('iris')
df

#2 - sumarios
df.head()
df.tail()
df.head(20)
df.tail(20)
df.describe()

#3 - groupby
df.groupby('species').mean()
df.groupby('species').median()
df.groupby('species').max()


#4 - mais linhas
pd.set_option('display.max_rows',20)
df


#5 - ordenando
     
df = df.sort_values(by='sepal_length')
df

#reseta o sort
df1 = df.reset_index(drop = True)
df