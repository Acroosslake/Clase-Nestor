# Ejercicio 3: Descuento según número al azar

total_compra = float(input("Total de la compra: "))
numero = int(input("Número escogido (0 a 100): "))

if numero < 74:
    descuento = 0.15
else:
    descuento = 0.20

monto_desc = total_compra * descuento

print("Descuento aplicado:", descuento * 100, "%")
print("Dinero descontado:", monto_desc)
print("Total a pagar:", total_compra - monto_desc)
