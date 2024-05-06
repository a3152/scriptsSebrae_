#parte 2

#importando
import math
print(math.sqrt(9))

import time
print(time.ctime())


#arrays
a= [1,2,3,4]
print(a)
a.append(8)
print(a)

#loop pelo array de duas formas 
for i in range(len(a)):
    print(a[i])

for x in a:
    print(x)


#dicionario
d = {'cat':'meow', 'dog':'bark', 'bird':'chirp'}
print(d['cat'])
d['dog'] = 'run'
print(d['dog'])  

#if-else
x = 2
if x == 1:
    print(5)
else:
    print(11)