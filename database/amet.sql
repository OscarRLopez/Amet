/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : 127.0.0.1:3306
 Source Schema         : amet

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 09/04/2021 18:52:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Areas
-- ----------------------------
DROP TABLE IF EXISTS `Areas`;
CREATE TABLE `Areas` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Areas
-- ----------------------------
BEGIN;
INSERT INTO `Areas` VALUES (1, 'Cocina');
INSERT INTO `Areas` VALUES (2, 'Lobby');
INSERT INTO `Areas` VALUES (3, 'Estacionamiento');
INSERT INTO `Areas` VALUES (4, 'Pista de baile');
COMMIT;

-- ----------------------------
-- Table structure for CasinoArea
-- ----------------------------
DROP TABLE IF EXISTS `CasinoArea`;
CREATE TABLE `CasinoArea` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_casino` int unsigned NOT NULL,
  `id_area` int unsigned NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas` (`id_casino`) USING BTREE,
  KEY `idx_are` (`id_area`) USING BTREE,
  CONSTRAINT `fk_area_cas` FOREIGN KEY (`id_area`) REFERENCES `Areas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cas_area` FOREIGN KEY (`id_casino`) REFERENCES `Casinos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoArea
-- ----------------------------
BEGIN;
INSERT INTO `CasinoArea` VALUES (1, 3, 4, 'Pista de baile para 40 personas');
INSERT INTO `CasinoArea` VALUES (2, 1, 3, 'Estacionamiento con capacidad de 20 cajones');
COMMIT;

-- ----------------------------
-- Table structure for CasinoHorariosFijos
-- ----------------------------
DROP TABLE IF EXISTS `CasinoHorariosFijos`;
CREATE TABLE `CasinoHorariosFijos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_casino` int unsigned NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `lunes` enum('S','N') DEFAULT NULL,
  `martes` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `miercoles` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `jueves` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `viernes` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sabado` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `domingo` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `precio` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas` (`id_casino`) USING BTREE,
  CONSTRAINT `fk_cas_hor_fij` FOREIGN KEY (`id_casino`) REFERENCES `Casinos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoHorariosFijos
-- ----------------------------
BEGIN;
INSERT INTO `CasinoHorariosFijos` VALUES (1, 1, '09:00:00', '14:00:00', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 1200);
INSERT INTO `CasinoHorariosFijos` VALUES (2, 1, '09:00:00', '14:00:00', 'N', 'N', 'N', 'N', 'S', 'S', 'S', 1500);
INSERT INTO `CasinoHorariosFijos` VALUES (3, 1, '16:00:00', '22:00:00', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 1500);
INSERT INTO `CasinoHorariosFijos` VALUES (4, 1, '16:00:00', '22:00:00', 'N', 'N', 'N', 'N', 'S', 'S', 'S', 2000);
INSERT INTO `CasinoHorariosFijos` VALUES (7, 3, '09:00:00', '14:00:00', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 2000);
INSERT INTO `CasinoHorariosFijos` VALUES (8, 3, '09:00:00', '14:00:00', 'N', 'N', 'N', 'N', 'S', 'S', 'S', 2500);
INSERT INTO `CasinoHorariosFijos` VALUES (9, 3, '16:00:00', '22:00:00', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 2500);
INSERT INTO `CasinoHorariosFijos` VALUES (10, 3, '16:00:00', '22:00:00', 'N', 'N', 'N', 'N', 'S', 'S', 'S', 3000);
COMMIT;

-- ----------------------------
-- Table structure for CasinoHorariosFlexibles
-- ----------------------------
DROP TABLE IF EXISTS `CasinoHorariosFlexibles`;
CREATE TABLE `CasinoHorariosFlexibles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `id_cas_pre_flex` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas_pre_fle` (`id_cas_pre_flex`) USING BTREE,
  CONSTRAINT `fk_cas_pre_fle` FOREIGN KEY (`id_cas_pre_flex`) REFERENCES `CasinoPreciosFlexibles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoHorariosFlexibles
-- ----------------------------
BEGIN;
INSERT INTO `CasinoHorariosFlexibles` VALUES (1, '09:00:00', '17:00:00', 2);
INSERT INTO `CasinoHorariosFlexibles` VALUES (2, '14:00:00', '16:00:00', 2);
COMMIT;

-- ----------------------------
-- Table structure for CasinoPreciosFlexibles
-- ----------------------------
DROP TABLE IF EXISTS `CasinoPreciosFlexibles`;
CREATE TABLE `CasinoPreciosFlexibles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_casino` int unsigned NOT NULL,
  `lunes` enum('S','N') DEFAULT NULL,
  `martes` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `miercoles` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `jueves` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `viernes` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sabado` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `domingo` enum('S','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `precio` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas` (`id_casino`) USING BTREE,
  CONSTRAINT `fk_cas_pre_flex` FOREIGN KEY (`id_casino`) REFERENCES `Casinos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoPreciosFlexibles
-- ----------------------------
BEGIN;
INSERT INTO `CasinoPreciosFlexibles` VALUES (1, 1, 'S', 'S', 'S', 'S', 'N', 'N', 'N', 400);
INSERT INTO `CasinoPreciosFlexibles` VALUES (2, 1, 'N', 'N', 'N', 'N', 'S', 'S', 'S', 500);
COMMIT;

-- ----------------------------
-- Table structure for CasinoServicio
-- ----------------------------
DROP TABLE IF EXISTS `CasinoServicio`;
CREATE TABLE `CasinoServicio` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_casino` int unsigned NOT NULL,
  `id_servicio` int unsigned NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas` (`id_casino`) USING BTREE,
  KEY `idx_ser` (`id_servicio`) USING BTREE,
  CONSTRAINT `fk_cas` FOREIGN KEY (`id_casino`) REFERENCES `Casinos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ser` FOREIGN KEY (`id_servicio`) REFERENCES `Servicios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoServicio
-- ----------------------------
BEGIN;
INSERT INTO `CasinoServicio` VALUES (1, 1, 1, 'Estufa electrica de dos mechas');
INSERT INTO `CasinoServicio` VALUES (2, 3, 3, 'Congelador chico de 20 lts');
COMMIT;

-- ----------------------------
-- Table structure for CasinoServicioExtra
-- ----------------------------
DROP TABLE IF EXISTS `CasinoServicioExtra`;
CREATE TABLE `CasinoServicioExtra` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_casino` int unsigned NOT NULL,
  `id_servicio_extra` int unsigned NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `costo` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cas` (`id_casino`) USING BTREE,
  KEY `idx_ser_ext` (`id_servicio_extra`) USING BTREE,
  CONSTRAINT `fk_cas_ser_ext` FOREIGN KEY (`id_casino`) REFERENCES `Casinos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ser_ext_cas` FOREIGN KEY (`id_servicio_extra`) REFERENCES `ServiciosExtras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of CasinoServicioExtra
-- ----------------------------
BEGIN;
INSERT INTO `CasinoServicioExtra` VALUES (1, 1, 3, 'Trampolin tamaño mediano.', 200);
INSERT INTO `CasinoServicioExtra` VALUES (2, 1, 3, 'Brincolin de Spiderman.', 400);
INSERT INTO `CasinoServicioExtra` VALUES (3, 1, 4, 'Rockola con muchas canciones variadas.', 200);
INSERT INTO `CasinoServicioExtra` VALUES (4, 3, 1, '10 mesas circulares con 200 sillas', 500);
INSERT INTO `CasinoServicioExtra` VALUES (5, 3, 2, 'Paquete de manteles para mesas rentadas', 0);
COMMIT;

-- ----------------------------
-- Table structure for Casinos
-- ----------------------------
DROP TABLE IF EXISTS `Casinos`;
CREATE TABLE `Casinos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_usr` int unsigned NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `rfc` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_id_usr` (`id_usr`) USING BTREE,
  CONSTRAINT `fk_usr_casino` FOREIGN KEY (`id_usr`) REFERENCES `Usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Casinos
-- ----------------------------
BEGIN;
INSERT INTO `Casinos` VALUES (1, 1, 'Gonzalez Gallo 227', 'Terraza Jalapeños', 'Hermosa terraza con hermosa vista.', 'MARI3011986u7');
INSERT INTO `Casinos` VALUES (3, 3, 'Juan Alvarez 2020', 'Salon de Eventos Diosdado', 'Hermoso salon de ventos techado con gran pista de baile.', 'MARI3011986u7');
COMMIT;

-- ----------------------------
-- Table structure for EventoCasinoSE
-- ----------------------------
DROP TABLE IF EXISTS `EventoCasinoSE`;
CREATE TABLE `EventoCasinoSE` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_evento` int unsigned DEFAULT NULL,
  `id_cas_se` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_eve_se` (`id_evento`) USING BTREE,
  KEY `idx_se_eve` (`id_cas_se`) USING BTREE,
  CONSTRAINT `fk_cas_se_eve` FOREIGN KEY (`id_cas_se`) REFERENCES `CasinoServicioExtra` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_eve_cas_se` FOREIGN KEY (`id_evento`) REFERENCES `Eventos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of EventoCasinoSE
-- ----------------------------
BEGIN;
INSERT INTO `EventoCasinoSE` VALUES (1, 1, 3);
INSERT INTO `EventoCasinoSE` VALUES (2, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for Eventos
-- ----------------------------
DROP TABLE IF EXISTS `Eventos`;
CREATE TABLE `Eventos` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` int unsigned NOT NULL,
  `id_cas_hor_fijo` int unsigned DEFAULT NULL,
  `id_cas_hor_flex` int unsigned DEFAULT NULL,
  `fecha` date NOT NULL,
  `importe` float(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_clie_eve` (`id_cliente`) USING BTREE,
  KEY `idx_cas_hor_fij_eve` (`id_cas_hor_fijo`) USING BTREE,
  KEY `idx_cas_hor_flex_eve` (`id_cas_hor_flex`) USING BTREE,
  CONSTRAINT `fk_clie_eve` FOREIGN KEY (`id_cliente`) REFERENCES `Usuarios` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_hor_fij_eve` FOREIGN KEY (`id_cas_hor_fijo`) REFERENCES `CasinoHorariosFijos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_hor_fle_eve` FOREIGN KEY (`id_cas_hor_flex`) REFERENCES `CasinoHorariosFlexibles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Eventos
-- ----------------------------
BEGIN;
INSERT INTO `Eventos` VALUES (1, 3, 4, NULL, '2021-11-11', 2400.00);
INSERT INTO `Eventos` VALUES (2, 3, NULL, 1, '2021-11-10', 4000.00);
INSERT INTO `Eventos` VALUES (3, 3, 4, 2, '2021-11-09', 3000.00);
COMMIT;

-- ----------------------------
-- Table structure for Roles
-- ----------------------------
DROP TABLE IF EXISTS `Roles`;
CREATE TABLE `Roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Roles
-- ----------------------------
BEGIN;
INSERT INTO `Roles` VALUES (1, 'Cliente');
INSERT INTO `Roles` VALUES (2, 'Proveedor');
INSERT INTO `Roles` VALUES (3, 'Administrador');
COMMIT;

-- ----------------------------
-- Table structure for Servicios
-- ----------------------------
DROP TABLE IF EXISTS `Servicios`;
CREATE TABLE `Servicios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Servicios
-- ----------------------------
BEGIN;
INSERT INTO `Servicios` VALUES (1, 'Estufa');
INSERT INTO `Servicios` VALUES (2, 'Refrigerador');
INSERT INTO `Servicios` VALUES (3, 'Congelador');
COMMIT;

-- ----------------------------
-- Table structure for ServiciosExtras
-- ----------------------------
DROP TABLE IF EXISTS `ServiciosExtras`;
CREATE TABLE `ServiciosExtras` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ServiciosExtras
-- ----------------------------
BEGIN;
INSERT INTO `ServiciosExtras` VALUES (1, 'Mobiliario');
INSERT INTO `ServiciosExtras` VALUES (2, 'Manteleria');
INSERT INTO `ServiciosExtras` VALUES (3, 'Juegos Infantiles');
INSERT INTO `ServiciosExtras` VALUES (4, 'Rockola');
COMMIT;

-- ----------------------------
-- Table structure for Usuarios
-- ----------------------------
DROP TABLE IF EXISTS `Usuarios`;
CREATE TABLE `Usuarios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombres` varchar(25) DEFAULT NULL,
  `ap_paterno` varchar(25) DEFAULT NULL,
  `ap_materno` varchar(25) DEFAULT NULL,
  `nacimiento` date DEFAULT NULL,
  `sexo` enum('M','F') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `id_rol` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `indx_rol` (`id_rol`) USING BTREE,
  CONSTRAINT `fk_usr_rol` FOREIGN KEY (`id_rol`) REFERENCES `Roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Usuarios
-- ----------------------------
BEGIN;
INSERT INTO `Usuarios` VALUES (1, 'Isaac Andrés', 'Márquez', 'Rodríguez', '1998-11-30', 'M', 'iamr_30@hotmail-com', '3336608630', '3331011654', 2);
INSERT INTO `Usuarios` VALUES (3, 'Paris', 'Flores', 'Belmares', '1999-05-07', 'M', 'Parisfb@hotmail.com', '3336608630', '3311223344', 2);
INSERT INTO `Usuarios` VALUES (4, 'Oscar', 'Lopez', 'Lopez', '1996-12-12', 'M', 'oscar@hotmail.com', '3311223344', '3311223344', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
