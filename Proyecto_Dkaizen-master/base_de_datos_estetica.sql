-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-09-2025 a las 15:26:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `barberia d'kaizen`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `inser_dato_emple` (IN `N_Sector` VARCHAR(30), IN `N_Serv_Perm` VARCHAR(50), IN `N_RH` VARCHAR(3), IN `N_Eps` VARCHAR(30))   BEGIN
    INSERT INTO empleado (Sector, Serv_Perm, RH, Eps, Tipo_Contrato, Estado)
    VALUES (N_Sector, N_Serv_Perm, N_RH, N_Eps);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inser_dato_usuario` (IN `N_Nombre` VARCHAR(50), IN `N_Doc_iden` VARCHAR(15), IN `N_Correo_Elec` VARCHAR(50), IN `N_Teléfono` VARCHAR(15))   BEGIN
	INSERT INTO usuario (Nombre, Doc_iden, Correo_Elec, Teléfono)
    VALUES (N_Nombre, N_Doc_iden, N_Correo_Elec, N_Teléfono);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `Cod_cliente` int(12) NOT NULL,
  `num_conta` varchar(15) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `patologias` varchar(125) NOT NULL,
  `Cod_Usuario` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`Cod_cliente`, `num_conta`, `fecha_nacimiento`, `patologias`, `Cod_Usuario`) VALUES
(1, '1', '2001-09-11', 'Ninguna', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `datos_empleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `datos_empleado` (
`Sector` varchar(30)
,`Servicio` varchar(50)
,`Tipo_Contrato` enum('fijo','temporal','prestación')
,`Rol` enum('cliente','empleado','administrador','')
,`Estado` enum('Activo','Inactivo','','')
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `datos_usu`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `datos_usu` (
`Nombre` varchar(50)
,`Correo_Elec` varchar(50)
,`Teléfono` varchar(15)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Cod_emple` int(12) NOT NULL,
  `Sector` varchar(30) NOT NULL,
  `Serv_Perm` varchar(50) NOT NULL,
  `RH` varchar(3) NOT NULL,
  `Eps` varchar(30) NOT NULL,
  `Tipo_Contrato` enum('fijo','temporal','prestación') NOT NULL,
  `Rol` enum('cliente','empleado','administrador','') NOT NULL,
  `Estado` enum('Activo','Inactivo','','') NOT NULL,
  `Cod_usuario` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Cod_emple`, `Sector`, `Serv_Perm`, `RH`, `Eps`, `Tipo_Contrato`, `Rol`, `Estado`, `Cod_usuario`) VALUES
(1, 'Barberia', 'Barbero', 'O+', 'Famisanar', 'fijo', 'empleado', 'Activo', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas_inventario`
--

CREATE TABLE `entradas_inventario` (
  `Cod_entrada` int(12) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `fecha_entrada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `motivo` varchar(125) NOT NULL,
  `Cod_producto` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `feedback`
--

CREATE TABLE `feedback` (
  `cod_feedback` int(12) NOT NULL,
  `comentario` varchar(125) NOT NULL,
  `calificacion` enum('1','2','3','4','5') NOT NULL,
  `fecha_feedback` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Cod_cliente` int(12) NOT NULL,
  `Cod_serv` int(12) NOT NULL,
  `Cod_emple` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fichas tecnicas`
--

CREATE TABLE `fichas tecnicas` (
  `Cod_ficha` int(12) NOT NULL,
  `parametrias` varchar(125) NOT NULL,
  `Notas` varchar(125) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Cod_serv` int(12) NOT NULL,
  `Cod_cliente` int(12) NOT NULL,
  `Cod_emple` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `info_pedido`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `info_pedido` (
`fecha_pedido` timestamp
,`estado` enum('pendiente','pagado','cancelado','entregado')
,`metodo_pago` enum('efectivo','transferencia','tarjeta')
,`total` decimal(6,3)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `Cod_produc` int(12) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` varchar(125) NOT NULL,
  `Stock_Actual` int(5) NOT NULL,
  `unidad_Medida` enum('ml','gr','unidad','kit') NOT NULL,
  `Precio_Unitatio` decimal(6,3) NOT NULL,
  `Estado` enum('Activo','Inactivo','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liquidaciones`
--

CREATE TABLE `liquidaciones` (
  `Cod_liquidacion` int(12) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `total_servicios` decimal(6,3) NOT NULL,
  `total_comisiones` decimal(6,3) NOT NULL,
  `bonificaciones` decimal(6,3) NOT NULL,
  `descuentos` decimal(6,3) NOT NULL,
  `total_pagar` decimal(6,3) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cod_empleado` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs`
--

CREATE TABLE `logs` (
  `Id` int(1) NOT NULL,
  `Accion` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_financieros`
--

CREATE TABLE `movimientos_financieros` (
  `cod_movimiento` int(12) NOT NULL,
  `tipo` enum('ingreso','egreso') NOT NULL,
  `descripcion` varchar(125) NOT NULL,
  `monto` decimal(6,3) NOT NULL,
  `fecha_movimiento` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Medio_Pago` enum('efectivo','transferencia','tarjeta') NOT NULL,
  `cod_Usuario` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `novedades_inventario`
--

CREATE TABLE `novedades_inventario` (
  `Cod_novedad` int(12) NOT NULL,
  `descripcion` varchar(125) NOT NULL,
  `fecha_Novedad` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `accion_tomada` varchar(125) NOT NULL,
  `Cod_producto` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `Cod_pedido` int(12) NOT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estado` enum('pendiente','pagado','cancelado','entregado') NOT NULL,
  `metodo_pago` enum('efectivo','transferencia','tarjeta') NOT NULL,
  `total` decimal(6,3) NOT NULL,
  `cod_cliente` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`Cod_pedido`, `fecha_pedido`, `estado`, `metodo_pago`, `total`, `cod_cliente`) VALUES
(1, '2025-09-25 06:17:39', 'pagado', 'efectivo', 100.000, 1);

--
-- Disparadores `pedidos`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pedido` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
    INSERT INTO logs (accion, fecha)
    VALUES (CONCAT('Se realizo exitosamente un pedido: ', NEW.Cod_pedido), CURRENT_TIMESTAMP);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recordatorios`
--

CREATE TABLE `recordatorios` (
  `Cod_record` int(12) NOT NULL,
  `Mensaje` varchar(125) NOT NULL,
  `Medio` enum('whatsapp','sms','correo') NOT NULL,
  `estado` enum('enviado','fallido','pendiente') NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `Cod_cliente` int(12) NOT NULL,
  `Cod_Reserva` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `Cod_reserva` int(12) NOT NULL,
  `Fecha_reserva` date NOT NULL,
  `Hora_reserva` time NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estado` enum('pendiente','confirmada','cancelada','realizada') NOT NULL,
  `observaciones` varchar(125) NOT NULL,
  `Cod_Cliente` int(12) NOT NULL,
  `Cod_serv` int(12) NOT NULL,
  `Cod_emple` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas_inventario`
--

CREATE TABLE `salidas_inventario` (
  `Cod_salida PK` int(12) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `fecha_Salida` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Uso` varchar(125) NOT NULL,
  `Cod_producto` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sanciones`
--

CREATE TABLE `sanciones` (
  `Cod_sanci` int(12) NOT NULL,
  `tipo_sancion` enum('ausencia','cancelación_tardia','otro') NOT NULL,
  `descripcion` int(125) NOT NULL,
  `duracion_dias` int(3) NOT NULL,
  `consecuencia` varchar(125) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Cod_cliente` int(12) NOT NULL,
  `Cod_emple` int(12) NOT NULL,
  `Cod_reserva` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `Cod_servi` int(12) NOT NULL,
  `Tipo_Serv` varchar(30) NOT NULL,
  `Nombre` int(50) NOT NULL,
  `Descripción` int(125) NOT NULL,
  `Duración` time NOT NULL,
  `Precio` decimal(6,3) NOT NULL,
  `Estado` enum('Activo','Inactivo','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Cod_usu` int(12) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Doc_iden` varchar(15) NOT NULL,
  `Correo_Elec` varchar(50) NOT NULL,
  `Teléfono` varchar(15) NOT NULL,
  `Contraseña` varchar(16) NOT NULL,
  `Rol` enum('cliente','empleado','administrador') NOT NULL,
  `Estado` enum('Activo','Inactivo') NOT NULL,
  `fecha_Regis` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Cod_usu`, `Nombre`, `Doc_iden`, `Correo_Elec`, `Teléfono`, `Contraseña`, `Rol`, `Estado`, `fecha_Regis`) VALUES
(1, 'Jeronimo Rodriguez', '123456', 'asdfgh@gmail,com', '1234567890', 'vbnm', 'cliente', 'Activo', '2025-09-25 04:54:56'),
(2, 'Jose Luis Peralez', '654321', 'zxcvbnm@gmail.com', '0987654321', 'asdqwrhethgaffsd', 'cliente', 'Activo', '2025-09-25 05:51:40'),
(3, 'Luis Carlos Marquez', '148789544', 'asdawdagh@gmail.com', '123687459', 'asdawdasdawf', 'empleado', 'Activo', '2025-09-25 05:55:32');

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `after_insert_usuario` AFTER INSERT ON `usuario` FOR EACH ROW BEGIN
    INSERT INTO logs (accion, fecha)
    VALUES (CONCAT('Se insertó el usuario: ', NEW.nombre), CURRENT_TIMESTAMP);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura para la vista `datos_empleado`
--
DROP TABLE IF EXISTS `datos_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `datos_empleado`  AS SELECT `empleado`.`Sector` AS `Sector`, `empleado`.`Serv_Perm` AS `Servicio`, `empleado`.`Tipo_Contrato` AS `Tipo_Contrato`, `empleado`.`Rol` AS `Rol`, `empleado`.`Estado` AS `Estado` FROM `empleado` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `datos_usu`
--
DROP TABLE IF EXISTS `datos_usu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `datos_usu`  AS SELECT `usuario`.`Nombre` AS `Nombre`, `usuario`.`Correo_Elec` AS `Correo_Elec`, `usuario`.`Teléfono` AS `Teléfono` FROM `usuario` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `info_pedido`
--
DROP TABLE IF EXISTS `info_pedido`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `info_pedido`  AS SELECT `pedidos`.`fecha_pedido` AS `fecha_pedido`, `pedidos`.`estado` AS `estado`, `pedidos`.`metodo_pago` AS `metodo_pago`, `pedidos`.`total` AS `total` FROM `pedidos` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`Cod_cliente`),
  ADD KEY `Cod_usu` (`Cod_Usuario`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`Cod_emple`),
  ADD KEY `Cod_Usu1` (`Cod_usuario`);

--
-- Indices de la tabla `entradas_inventario`
--
ALTER TABLE `entradas_inventario`
  ADD PRIMARY KEY (`Cod_entrada`);

--
-- Indices de la tabla `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`cod_feedback`),
  ADD KEY `Cod_cliente` (`Cod_cliente`),
  ADD KEY `Cod_serv` (`Cod_serv`),
  ADD KEY `Cod_emple` (`Cod_emple`);

--
-- Indices de la tabla `fichas tecnicas`
--
ALTER TABLE `fichas tecnicas`
  ADD PRIMARY KEY (`Cod_ficha`),
  ADD KEY `Cod_serv2` (`Cod_serv`),
  ADD KEY `Cod_cliente2` (`Cod_cliente`),
  ADD KEY `Cod_emple2` (`Cod_emple`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`Cod_produc`);

--
-- Indices de la tabla `liquidaciones`
--
ALTER TABLE `liquidaciones`
  ADD PRIMARY KEY (`Cod_liquidacion`),
  ADD KEY `cod_emple3` (`cod_empleado`);

--
-- Indices de la tabla `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `movimientos_financieros`
--
ALTER TABLE `movimientos_financieros`
  ADD PRIMARY KEY (`cod_movimiento`),
  ADD KEY `Cod_Usu2` (`cod_Usuario`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`Cod_pedido`),
  ADD KEY `Cod_Cliente3` (`cod_cliente`);

--
-- Indices de la tabla `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD PRIMARY KEY (`Cod_record`),
  ADD KEY `Cod_cliente5` (`Cod_cliente`),
  ADD KEY `Cod_reserva` (`Cod_Reserva`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`Cod_reserva`),
  ADD KEY `Cod_cliente6` (`Cod_Cliente`),
  ADD KEY `Cod_serv3` (`Cod_serv`),
  ADD KEY `Cod_emple4` (`Cod_emple`);

--
-- Indices de la tabla `salidas_inventario`
--
ALTER TABLE `salidas_inventario`
  ADD PRIMARY KEY (`Cod_salida PK`);

--
-- Indices de la tabla `sanciones`
--
ALTER TABLE `sanciones`
  ADD PRIMARY KEY (`Cod_sanci`),
  ADD KEY `Cod_cliente7` (`Cod_cliente`),
  ADD KEY `Cod_emple6` (`Cod_emple`),
  ADD KEY `Cod_reserva1` (`Cod_reserva`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`Cod_servi`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Cod_usu`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `Id` int(1) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `Cod_usu` FOREIGN KEY (`Cod_Usuario`) REFERENCES `usuario` (`Cod_usu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `Cod_Usu1` FOREIGN KEY (`Cod_usuario`) REFERENCES `usuario` (`Cod_usu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `Cod_cliente` FOREIGN KEY (`Cod_cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_emple` FOREIGN KEY (`Cod_emple`) REFERENCES `empleado` (`Cod_emple`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_serv` FOREIGN KEY (`Cod_serv`) REFERENCES `servicio` (`Cod_servi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `fichas tecnicas`
--
ALTER TABLE `fichas tecnicas`
  ADD CONSTRAINT `Cod_cliente2` FOREIGN KEY (`Cod_cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_emple2` FOREIGN KEY (`Cod_emple`) REFERENCES `empleado` (`Cod_emple`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_serv2` FOREIGN KEY (`Cod_serv`) REFERENCES `servicio` (`Cod_servi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `liquidaciones`
--
ALTER TABLE `liquidaciones`
  ADD CONSTRAINT `cod_emple3` FOREIGN KEY (`cod_empleado`) REFERENCES `empleado` (`Cod_emple`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimientos_financieros`
--
ALTER TABLE `movimientos_financieros`
  ADD CONSTRAINT `Cod_Usu2` FOREIGN KEY (`cod_Usuario`) REFERENCES `usuario` (`Cod_usu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `Cod_Cliente3` FOREIGN KEY (`cod_cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD CONSTRAINT `Cod_cliente5` FOREIGN KEY (`Cod_cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_reserva` FOREIGN KEY (`Cod_Reserva`) REFERENCES `reservas` (`Cod_reserva`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `Cod_cliente6` FOREIGN KEY (`Cod_Cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_emple4` FOREIGN KEY (`Cod_emple`) REFERENCES `empleado` (`Cod_emple`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_serv3` FOREIGN KEY (`Cod_serv`) REFERENCES `servicio` (`Cod_servi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sanciones`
--
ALTER TABLE `sanciones`
  ADD CONSTRAINT `Cod_cliente7` FOREIGN KEY (`Cod_cliente`) REFERENCES `cliente` (`Cod_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_emple6` FOREIGN KEY (`Cod_emple`) REFERENCES `empleado` (`Cod_emple`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Cod_reserva1` FOREIGN KEY (`Cod_reserva`) REFERENCES `reservas` (`Cod_reserva`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
