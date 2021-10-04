-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-10-2021 a las 03:43:36
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pruebas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_CONSULTA_Insertar_POR_DOCUMENTO` (IN `Insertar` VARCHAR(50) CHARSET utf8)  INSERT INTO usp_consulta (DOC_IDENTIDAD) VALUES (Insertar)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_CONSULTA_NOMINA_POR_DOCUMENTO` (IN `Borrar` VARCHAR(50) CHARSET utf8, IN `Insertar` VARCHAR(50) CHARSET utf8)  DELETE FROM usp_consulta WHERE Usuario = Borrar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_CONSULTA_NOMINA_POR_DOCUMENTO_I` (IN `Insertar` VARCHAR(50) CHARSET utf8)  INSERT INTO usp_consulta (Usuario) VALUES (Insertar)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_consulta_nom_nomina_definitiva`
--

CREATE TABLE `log_consulta_nom_nomina_definitiva` (
  `id_registro` int(11) NOT NULL,
  `Usuario` varchar(30) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `operación` varchar(10) DEFAULT NULL,
  `descripción_de_evento` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nom_conceptos_nomina`
--

CREATE TABLE `nom_conceptos_nomina` (
  `Id_concepto` int(11) NOT NULL,
  `DESC_CONCEPTO` varchar(20) DEFAULT NULL,
  `cod_concepto` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nom_conceptos_nomina`
--

INSERT INTO `nom_conceptos_nomina` (`Id_concepto`, `DESC_CONCEPTO`, `cod_concepto`) VALUES
(1, '30', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nom_empleados`
--

CREATE TABLE `nom_empleados` (
  `Id_EMPLEADO` int(11) NOT NULL,
  `ID_Solicitud` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nom_empleados`
--

INSERT INTO `nom_empleados` (`Id_EMPLEADO`, `ID_Solicitud`) VALUES
(1, '101');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nom_nomina_definitiva`
--

CREATE TABLE `nom_nomina_definitiva` (
  `REGISTRO` int(11) NOT NULL,
  `FCH_CREACION` datetime DEFAULT NULL,
  `VAL_NOMINA` varchar(20) DEFAULT NULL,
  `CANTIDAD` varchar(20) DEFAULT NULL,
  `Id_concepto` int(2) DEFAULT NULL,
  `Id_empleado` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nom_nomina_definitiva`
--

INSERT INTO `nom_nomina_definitiva` (`REGISTRO`, `FCH_CREACION`, `VAL_NOMINA`, `CANTIDAD`, `Id_concepto`, `Id_empleado`) VALUES
(1, '0000-00-00 00:00:00', '30000', '10', 105, 87);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reg_solicitudes_ingreso`
--

CREATE TABLE `reg_solicitudes_ingreso` (
  `Id_solicitud` int(11) NOT NULL,
  `Documento` varchar(20) DEFAULT NULL,
  `Apellidos` varchar(20) DEFAULT NULL,
  `Nombres` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `reg_solicitudes_ingreso`
--

INSERT INTO `reg_solicitudes_ingreso` (`Id_solicitud`, `Documento`, `Apellidos`, `Nombres`) VALUES
(2608, '1032', 'Perea', 'Nestor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usp_consulta`
--

CREATE TABLE `usp_consulta` (
  `DOC_IDENTIDAD` varchar(50) NOT NULL,
  `Evento` varchar(5) DEFAULT NULL,
  `Usuario` varchar(50) DEFAULT NULL,
  `Fecha_Nueva` date NOT NULL DEFAULT current_timestamp(),
  `Fecha_Anterior` date NOT NULL DEFAULT current_timestamp(),
  `REGISTRO_NOMINA` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usp_consulta`
--

INSERT INTO `usp_consulta` (`DOC_IDENTIDAD`, `Evento`, `Usuario`, `Fecha_Nueva`, `Fecha_Anterior`, `REGISTRO_NOMINA`) VALUES
('', NULL, 'Kyra', '2021-10-02', '2021-10-02', ''),
('1008', '45', 'TOM', '0000-00-00', '2000-01-01', '506'),
('1009', '45', 'tom', '0000-00-00', '2000-01-01', '456'),
('1032', '11', 'Nestor Perea', '2021-10-02', '2021-10-02', ''),
('2802', NULL, NULL, '2021-10-02', '2021-10-02', '');

--
-- Disparadores `usp_consulta`
--
DELIMITER $$
CREATE TRIGGER `Actualizar_usp_usuario_BU` BEFORE INSERT ON `usp_consulta` FOR EACH ROW INSERT INTO usp_consulta_usuario
(DOC_IDENTIDAD, USUARIO, EVENTO, REGISTRO_NOMINA, FECHA_NUEVA, FECHA_ANTERIOR)
VALUES (NEW.DOC_IDENTIDAD, NEW.USUARIO, NEW.EVENTO, NEW.REGISTRO_NOMINA, NEW.FECHA_NUEVA, NEW.FECHA_ANTERIOR, CURRENT_USER, NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usp_consulta_usuario`
--

CREATE TABLE `usp_consulta_usuario` (
  `DOC_IDENTIDAD` varchar(50) DEFAULT NULL,
  `Evento` varchar(5) DEFAULT NULL,
  `Usuario` varchar(50) DEFAULT NULL,
  `REGISTRO_NOMINA` varchar(18) DEFAULT NULL,
  `Fecha_Anterior` date NOT NULL,
  `Fecha_Nueva` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usp_consulta_usuario`
--

INSERT INTO `usp_consulta_usuario` (`DOC_IDENTIDAD`, `Evento`, `Usuario`, `REGISTRO_NOMINA`, `Fecha_Anterior`, `Fecha_Nueva`) VALUES
('1003', '98', 'Kyra', '201', '0000-00-00', '0000-00-00'),
('1235', '74', 'Andres', '63', '0000-00-00', '2000-02-02');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `log_consulta_nom_nomina_definitiva`
--
ALTER TABLE `log_consulta_nom_nomina_definitiva`
  ADD PRIMARY KEY (`id_registro`);

--
-- Indices de la tabla `nom_conceptos_nomina`
--
ALTER TABLE `nom_conceptos_nomina`
  ADD PRIMARY KEY (`Id_concepto`);

--
-- Indices de la tabla `nom_empleados`
--
ALTER TABLE `nom_empleados`
  ADD PRIMARY KEY (`Id_EMPLEADO`);

--
-- Indices de la tabla `nom_nomina_definitiva`
--
ALTER TABLE `nom_nomina_definitiva`
  ADD PRIMARY KEY (`REGISTRO`);

--
-- Indices de la tabla `reg_solicitudes_ingreso`
--
ALTER TABLE `reg_solicitudes_ingreso`
  ADD PRIMARY KEY (`Id_solicitud`);

--
-- Indices de la tabla `usp_consulta`
--
ALTER TABLE `usp_consulta`
  ADD PRIMARY KEY (`DOC_IDENTIDAD`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
