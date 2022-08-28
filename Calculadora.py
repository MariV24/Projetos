# Calculadora POO

class calculadora():
    def __init__(self, n1, n2) -> None:
        self.n1 = n1
        self.n2 = n2

    def soma(self):
        return self.n1 + self.n2

    '''def printSoma(self):
        print(self.soma)'''

n1 = int(input("Digite os numeros a serem somados: "))
n2 = int(input())

calcular = calculadora(n1, n2)
print(calcular.soma())