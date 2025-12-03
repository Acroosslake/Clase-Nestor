# Ejercicio 5: Vector original y vector al cuadrado

import random

vector_original = [random.randint(1, 100) for _ in range(500)]
vector_cuadrado = [num ** 2 for num in vector_original]

print("Vector original:")
print(vector_original)

print("\nVector al cuadrado:")
print(vector_cuadrado)
