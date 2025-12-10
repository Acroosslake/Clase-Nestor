<?php
/**
 * Archivo para ejecutar las acciones de una persona
 * Recibe datos por POST en formato JSON
 */

// Incluir la clase Persona
require_once 'Persona.php';

// Configurar headers para JSON
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Iniciar sesión
session_start();

// Procesar la solicitud POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Obtener datos JSON del cuerpo de la solicitud
        $datosJSON = file_get_contents('php://input');
        $datos = json_decode($datosJSON, true);
        
        if (!$datos || !isset($datos['accion'])) {
            throw new Exception('Datos inválidos');
        }
        
        // Verificar si hay una persona en sesión
        if (!isset($_SESSION['persona'])) {
            // Si no hay persona en sesión, crearla con los datos recibidos
            if (!isset($datos['persona'])) {
                throw new Exception('No hay persona registrada');
            }
            
            $datosPersona = $datos['persona'];
            $persona = new Persona(
                $datosPersona['nombre'],
                $datosPersona['apellido'],
                $datosPersona['fechaNacimiento'],
                $datosPersona['email'],
                $datosPersona['telefono'],
                $datosPersona['genero']
            );
        } else {
            // Obtener la persona de la sesión
            $persona = unserialize($_SESSION['persona']);
        }
        
        // Ejecutar la acción correspondiente
        $accion = strtolower($datos['accion']);
        $resultado = null;
        
        switch ($accion) {
            case 'reir':
                $resultado = $persona->reir();
                break;
            case 'comer':
                $resultado = $persona->comer();
                break;
            case 'dormir':
                $resultado = $persona->dormir();
                break;
            case 'estudiar':
                $resultado = $persona->estudiar();
                break;
            case 'caminar':
                $resultado = $persona->caminar();
                break;
            default:
                throw new Exception('Acción no válida');
        }
        
        // Responder con el resultado de la acción
        echo json_encode([
            'exito' => true,
            'resultado' => $resultado,
            'persona' => $persona->toArray()
        ]);
        
    } catch (Exception $e) {
        echo json_encode([
            'exito' => false,
            'mensaje' => 'Error al ejecutar la acción: ' . $e->getMessage()
        ]);
    }
} else {
    echo json_encode([
        'exito' => false,
        'mensaje' => 'Método no permitido'
    ]);
}
?>