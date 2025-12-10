# Ejercicio 6: Matriz de 50 alumnos con tres notas y promedio final

alumnos = []  # M(50,5)

for i in range(50):
    print(f"\n--- Alumno {i+1} ---")
    codigo = input("Código estudiantil: ")

    notas = []
    for j in range(1, 4):
        nota = float(input(f"Calificación {j} (1.0 a 5.0): "))
        while nota < 1.0 or nota > 5.0:
            print("Nota inválida. Debe ser entre 1.0 y 5.0")
            nota = float(input(f"Calificación {j} (1.0 a 5.0): "))
        notas.append(nota)

    promedio = sum(notas) / 3
    alumnos.append([codigo, notas[0], notas[1], notas[2], promedio])

# --- Cálculos ---
aprobados = sum(1 for a in alumnos if a[4] >= 3.0)
recuperan = sum(1 for a in alumnos if 2.0 <= a[4] <= 2.9)
maximos = sum(1 for a in alumnos if a[4] == 5.0)

print("\n===== RESULTADOS =====")
print("A) Alumnos aprobados:", aprobados)
print("B) Alumnos que recuperan:", recuperan)
print("C) Alumnos con 5.0:", maximos)
