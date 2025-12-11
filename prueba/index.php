<?php
require_once 'deudaAmortizable.php';

$tabla = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $monto       = floatval($_POST['monto']);
    $tasa        = floatval($_POST['tasa']);
    $plazo       = intval($_POST['plazo']);

    $deuda       = new DeudaAmortizable($monto, $tasa, $plazo);
    $tabla       = $deuda->generarTabla();
    $cuotaMensual = $deuda->calcularCuota();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Amortización de Deuda</title>

    <style>
        body { font-family: Arial; padding: 20px; }
        .container { width: 450px; margin-bottom: 30px; }
        input { width: 100%; padding: 8px; margin: 5px 0; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #eee; }
    </style>
</head>

<body>
    <h1>Simulador de Amortización</h1>

    <form method="POST" class="container">
        <label>Monto del préstamo:</label>
        <input type="number" name="monto" step="0.01" required>

        <label>Tasa de interés anual (%):</label>
        <input type="number" name="tasa" step="0.01" required>

        <label>Plazo (meses):</label>
        <input type="number" name="plazo" required>

        <button type="submit">Calcular</button>
    </form>

    <?php if (!empty($tabla)): ?>
        <h2>Cuota mensual: $<?= number_format($cuotaMensual, 2) ?></h2>

        <table>
            <tr>
                <th>Periodo</th>
                <th>Cuota</th>
                <th>Interés</th>
                <th>Abono Capital</th>
                <th>Saldo</th>
            </tr>

            <?php foreach($tabla as $fila): ?>
                <tr>
                    <td><?= $fila["periodo"] ?></td>
                    <td><?= $fila["cuota"] ?></td>
                    <td><?= $fila["interes"] ?></td>
                    <td><?= $fila["abono"] ?></td>
                    <td><?= $fila["saldo"] ?></td>
                </tr>
            <?php endforeach; ?>
        </table>
    <?php endif; ?>

</body>
</html>
