// Variables globales
let personaActual = null;

// Event Listeners
document.addEventListener('DOMContentLoaded', function() {
    const formulario = document.getElementById('formulario-persona');
    formulario.addEventListener('submit', manejarEnvioFormulario);

    // Agregar validación en tiempo real
    const campos = formulario.querySelectorAll('.input-campo');
    campos.forEach(campo => {
        campo.addEventListener('blur', function() {
            validarCampo(this);
        });
    });
});

// Función para manejar el envío del formulario
function manejarEnvioFormulario(e) {
    e.preventDefault();
    
    // Limpiar mensajes de error previos
    limpiarErrores();
    
    // Obtener valores del formulario
    const nombre = document.getElementById('nombre').value.trim();
    const apellido = document.getElementById('apellido').value.trim();
    const fechaNacimiento = document.getElementById('fecha-nacimiento').value;
    const email = document.getElementById('email').value.trim();
    const telefono = document.getElementById('telefono').value.trim();
    const genero = document.getElementById('genero').value;
    
    // Validar todos los campos
    let formularioValido = true;
    
    if (!validarNombre(nombre)) {
        mostrarError('error-nombre', 'El nombre es requerido y debe contener solo letras');
        formularioValido = false;
    }
    
    if (!validarApellido(apellido)) {
        mostrarError('error-apellido', 'El apellido es requerido y debe contener solo letras');
        formularioValido = false;
    }
    
    const resultadoFecha = validarFechaNacimiento(fechaNacimiento);
    if (!resultadoFecha.valido) {
        mostrarError('error-fecha', resultadoFecha.mensaje);
        formularioValido = false;
    }
    
    if (!validarEmail(email)) {
        mostrarError('error-email', 'Ingrese un email válido');
        formularioValido = false;
    }
    
    if (!validarTelefono(telefono)) {
        mostrarError('error-telefono', 'El teléfono debe contener entre 7 y 15 dígitos');
        formularioValido = false;
    }
    
    if (!validarGenero(genero)) {
        mostrarError('error-genero', 'Debe seleccionar un género');
        formularioValido = false;
    }
    
    // Si todo es válido, crear la persona
    if (formularioValido) {
        crearPersona(nombre, apellido, fechaNacimiento, email, telefono, genero);
    }
}

// Funciones de validación
function validarNombre(nombre) {
    return nombre.length > 0 && /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(nombre);
}

function validarApellido(apellido) {
    return apellido.length > 0 && /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/.test(apellido);
}

function validarFechaNacimiento(fecha) {
    if (!fecha) {
        return { valido: false, mensaje: 'La fecha de nacimiento es requerida' };
    }
    
    const fechaNac = new Date(fecha);
    const fechaActual = new Date();
    
    // Normalizar fechas para comparación
    fechaActual.setHours(0, 0, 0, 0);
    fechaNac.setHours(0, 0, 0, 0);
    
    if (fechaNac > fechaActual) {
        return { valido: false, mensaje: 'La fecha de nacimiento no puede ser mayor a la fecha actual' };
    }
    
    // Validar que la persona tenga al menos 1 año
    const edad = calcularEdad(fecha);
    if (edad < 1) {
        return { valido: false, mensaje: 'La persona debe tener al menos 1 año' };
    }
    
    // Validar que la edad sea razonable (máximo 120 años)
    if (edad > 120) {
        return { valido: false, mensaje: 'La edad no puede ser mayor a 120 años' };
    }
    
    return { valido: true };
}

function validarEmail(email) {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(email);
}

function validarTelefono(telefono) {
    const regex = /^\d{7,15}$/;
    return regex.test(telefono.replace(/[\s\-\(\)]/g, ''));
}

function validarGenero(genero) {
    return genero !== '';
}

// Función para validar un campo individual
function validarCampo(campo) {
    const id = campo.id;
    const valor = campo.value.trim();
    const errorId = 'error-' + id.replace('-', '-');
    
    limpiarError(errorId);
    campo.classList.remove('error');
    
    let valido = true;
    
    switch(id) {
        case 'nombre':
            valido = validarNombre(valor);
            if (!valido) mostrarError(errorId, 'El nombre es requerido y debe contener solo letras');
            break;
        case 'apellido':
            valido = validarApellido(valor);
            if (!valido) mostrarError(errorId, 'El apellido es requerido y debe contener solo letras');
            break;
        case 'fecha-nacimiento':
            const resultado = validarFechaNacimiento(valor);
            valido = resultado.valido;
            if (!valido) mostrarError(errorId, resultado.mensaje);
            break;
        case 'email':
            valido = validarEmail(valor);
            if (!valido) mostrarError(errorId, 'Ingrese un email válido');
            break;
        case 'telefono':
            valido = validarTelefono(valor);
            if (!valido) mostrarError(errorId, 'El teléfono debe contener entre 7 y 15 dígitos');
            break;
        case 'genero':
            valido = validarGenero(valor);
            if (!valido) mostrarError(errorId, 'Debe seleccionar un género');
            break;
    }
    
    return valido;
}

// Función para calcular la edad
function calcularEdad(fechaNacimiento) {
    const hoy = new Date();
    const nacimiento = new Date(fechaNacimiento);
    let edad = hoy.getFullYear() - nacimiento.getFullYear();
    const mes = hoy.getMonth() - nacimiento.getMonth();
    
    if (mes < 0 || (mes === 0 && hoy.getDate() < nacimiento.getDate())) {
        edad--;
    }
    
    return edad;
}

// Función para mostrar errores
function mostrarError(idElemento, mensaje) {
    const elemento = document.getElementById(idElemento);
    if (elemento) {
        elemento.textContent = mensaje;
        const campo = elemento.previousElementSibling;
        if (campo && campo.classList.contains('input-campo')) {
            campo.classList.add('error');
        }
    }
}

// Función para limpiar un error específico
function limpiarError(idElemento) {
    const elemento = document.getElementById(idElemento);
    if (elemento) {
        elemento.textContent = '';
    }
}

// Función para limpiar todos los errores
function limpiarErrores() {
    const mensajesError = document.querySelectorAll('.mensaje-error');
    mensajesError.forEach(mensaje => {
        mensaje.textContent = '';
    });
    
    const campos = document.querySelectorAll('.input-campo');
    campos.forEach(campo => {
        campo.classList.remove('error');
    });
}

// Función para crear la persona mediante AJAX
function crearPersona(nombre, apellido, fechaNacimiento, email, telefono, genero) {
    // Simular llamada AJAX (en un entorno real, esto sería una petición al servidor PHP)
    const datos = {
        nombre: nombre,
        apellido: apellido,
        fechaNacimiento: fechaNacimiento,
        email: email,
        telefono: telefono,
        genero: genero,
        edad: calcularEdad(fechaNacimiento)
    };
    
    // En un entorno real, aquí iría:
    // fetch('procesar_persona.php', {
    //     method: 'POST',
    //     headers: { 'Content-Type': 'application/json' },
    //     body: JSON.stringify(datos)
    // })
    // .then(response => response.json())
    // .then(data => {
    //     personaActual = data;
    //     mostrarInformacionPersona();
    // });
    
    // Para esta demostración, usamos los datos directamente
    personaActual = datos;
    mostrarInformacionPersona();
}

// Función para mostrar la información de la persona
function mostrarInformacionPersona() {
    if (!personaActual) return;
    
    document.getElementById('info-nombre-completo').textContent = 
        personaActual.nombre + ' ' + personaActual.apellido;
    document.getElementById('info-edad').textContent = 
        personaActual.edad + ' años';
    document.getElementById('info-fecha-nacimiento').textContent = 
        formatearFecha(personaActual.fechaNacimiento);
    document.getElementById('info-email').textContent = 
        personaActual.email;
    document.getElementById('info-telefono').textContent = 
        personaActual.telefono;
    document.getElementById('info-genero').textContent = 
        capitalizarPrimeraLetra(personaActual.genero);
    
    // Cambiar de sección
    document.getElementById('seccion-formulario').classList.remove('activo');
    document.getElementById('seccion-informacion').classList.add('activo');
}

// Función para formatear la fecha
function formatearFecha(fecha) {
    const date = new Date(fecha);
    const dia = String(date.getDate() + 1).padStart(2, '0');
    const mes = String(date.getMonth() + 1).padStart(2, '0');
    const año = date.getFullYear();
    return `${dia}/${mes}/${año}`;
}

// Función para capitalizar la primera letra
function capitalizarPrimeraLetra(texto) {
    return texto.charAt(0).toUpperCase() + texto.slice(1);
}

// Función para ejecutar acciones
function ejecutarAccion(accion) {
    if (!personaActual) return;
    
    // Simular llamada AJAX para ejecutar la acción
    // En un entorno real:
    // fetch('ejecutar_accion.php', {
    //     method: 'POST',
    //     headers: { 'Content-Type': 'application/json' },
    //     body: JSON.stringify({ accion: accion, persona: personaActual })
    // })
    // .then(response => response.json())
    // .then(data => {
    //     mostrarModal(data.titulo, data.mensaje);
    // });
    
    // Para esta demostración, generamos las respuestas localmente
    const respuestas = {
        reir: {
            titulo: '😄 Reír',
            mensaje: `${personaActual.nombre} está riendo a carcajadas. ¡Ja ja ja! La risa es contagiosa y alegra el día.`
        },
        comer: {
            titulo: '🍽️ Comer',
            mensaje: `${personaActual.nombre} está disfrutando de una deliciosa comida. ¡Qué rico! La comida es una de las mejores experiencias de la vida.`
        },
        dormir: {
            titulo: '😴 Dormir',
            mensaje: `${personaActual.nombre} está descansando profundamente. Zzz... El descanso es fundamental para recuperar energías.`
        },
        estudiar: {
            titulo: '📚 Estudiar',
            mensaje: `${personaActual.nombre} está estudiando con mucha concentración. ¡El conocimiento es poder! Cada día se aprende algo nuevo.`
        },
        caminar: {
            titulo: '🚶 Caminar',
            mensaje: `${personaActual.nombre} está caminando al aire libre. ¡Qué saludable! El ejercicio mantiene el cuerpo y la mente en forma.`
        }
    };
    
    const respuesta = respuestas[accion];
    mostrarModal(respuesta.titulo, respuesta.mensaje);
}

// Función para mostrar el modal
function mostrarModal(titulo, mensaje) {
    document.getElementById('modal-titulo').textContent = titulo;
    document.getElementById('modal-mensaje').textContent = mensaje;
    document.getElementById('modal-accion').classList.add('activo');
}

// Función para cerrar el modal
function cerrarModal() {
    document.getElementById('modal-accion').classList.remove('activo');
}

// Función para volver al formulario
function volverFormulario() {
    // Limpiar formulario
    document.getElementById('formulario-persona').reset();
    limpiarErrores();
    
    // Cambiar de sección
    document.getElementById('seccion-informacion').classList.remove('activo');
    document.getElementById('seccion-formulario').classList.add('activo');
    
    personaActual = null;
}

// Cerrar modal al hacer clic fuera de él
window.onclick = function(event) {
    const modal = document.getElementById('modal-accion');
    if (event.target === modal) {
        cerrarModal();
    }
}