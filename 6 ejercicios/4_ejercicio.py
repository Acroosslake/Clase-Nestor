# Ejercicio 4: Comisión para 100 vendedores Mazda

for i in range(1, 101):
    venta = float(input(f"Ingrese ventas del vendedor {i}: "))

    if 1_000_000 <= venta < 3_000_000:
        comision = 0.03
    elif 3_000_000 <= venta < 5_000_000:
        comision = 0.04
    elif 5_000_000 <= venta < 7_000_000:
        comision = 0.05
    elif 7_000_000 <= venta < 10_000_000:
        comision = 0.06
    else:
        print("Valor fuera de rango (máximo 10 millones).")
        continue

    valor_final = venta * comision
    print(f"Vendedor {i} → Comisión anual: ${valor_final:,.2f}")
