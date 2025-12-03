
# Ejercicio 2: Descuento según clave

nombre = input("Nombre del artículo: ")
clave = input("Clave del artículo (01 o 02): ")
precio = float(input("Precio original: "))

if clave == "01":
    descuento = 0.10
elif clave == "02":
    descuento = 0.20
else:
    print("Clave inválida. Use 01 o 02.")
    exit()

precio_final = precio - (precio * descuento)

print("\n--- INFORMACIÓN DEL ARTÍCULO ---")
print("Artículo:", nombre)
print("Clave:", clave)
print("Precio original:", precio)
print("Descuento aplicado:", descuento * 100, "%")
print("Precio final:", precio_final)