
--Sistema de datos bancarios


-- Tabla de clientes
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Tabla de cuentas
CREATE TABLE cuenta(
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(20) NOT NULL UNIQUE,
    tipo_cuenta ENUM('Ahorros', 'Corriente', 'Nomina') NOT NULL,
    saldo DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    cliente_id INT NOT NULL,
    Foreign Key (cliente_id ) REFERENCES cliente(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE empleado(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    puesto ENUM('Gerenete', 'Cajero', 'Asesor') NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL
)