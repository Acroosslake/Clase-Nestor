<?php
declare(strict_types=1);

require_once 'deuda.php';

/**
 * Implementación de una deuda amortizable mediante cuota fija.
 */
class DeudaAmortizable extends Deuda
{
    public function calcularCuota(): float
    {
        $i = ($this->tasaInteres / 100) / 12;
        $n = $this->plazo;
        $P = $this->monto;

        if ($i == 0) {
            return $P / $n;
        }

        return $P * ($i / (1 - pow(1 + $i, -$n)));
    }

    public function generarTabla(): array
    {
        $cuota     = $this->calcularCuota();
        $saldo     = $this->monto;
        $tabla     = [];

        for ($periodo = 1; $periodo <= $this->plazo; $periodo++) {

            $interes = $saldo * (($this->tasaInteres / 100) / 12);
            $abono   = $cuota - $interes;
            $saldo   = max(0, $saldo - $abono);

            $tabla[] = [
                "periodo" => $periodo,
                "cuota"   => round($cuota, 2),
                "interes" => round($interes, 2),
                "abono"   => round($abono, 2),
                "saldo"   => round($saldo, 2)
            ];
        }

        return $tabla;
    }
}
