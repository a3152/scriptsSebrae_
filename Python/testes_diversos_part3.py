#parte 3

#cometando

a = 5
#a = a + 1
print(a)

#identacao

x = 1
if 2*x == 2:
    print('sim')

#aqui da erro
x = 1

if 2*x == 1:
print('sim')

#funcoes multiplas

def f(x):
    return 2*x

def g(y):
    return 1+y

print(g(f(4))) # (2*4) + 1
print(f(g(4))) # 2(1+4) 


#deletando do array
a = [1,2,3,4,5]
print(a.pop())
print(a)