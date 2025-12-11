<?php
declare(strict_types=1);

/**
 * Clase base Deuda
 * Representa una deuda genérica con monto, tasa de interés y plazo.
 */
class Deuda
{
    protected float $monto;
    protected float $tasaInteres;
    protected int $plazo;

    public function __construct(float $monto, float $tasaInteres, int $plazo)
    {
        $this->monto        = $monto;
        $this->tasaInteres  = $tasaInteres;
        $this->plazo        = $plazo;
    }

    public function getMonto(): float
    {
        return $this->monto;
    }

    public function getTasaInteres(): float
    {
        return $this->tasaInteres;
    }

    public function getPlazo(): int
    {
        return $this->plazo;
    }

    /**
     * Método polimórfico que deberá ser implementado en las clases hijas
     */
    public function calcularCuota(): float
    {
        return 0.0;
    }
}
