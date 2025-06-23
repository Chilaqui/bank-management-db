
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
);

CREATE TABLE sucursal(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);


CREATE TABLE transaccion(
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_transaccion ENUM('Deposito', 'Retiro', 'Transferencia') NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    cuenta_origen_id INT,
    cuenta_destino_id INT,
    empleado_id INT NOT NULL,
    FOREIGN KEY (cuenta_origen_id) REFERENCES cuenta(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (cuenta_destino_id) REFERENCES cuenta(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (empleado_id) REFERENCES empleado(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

-- Tabla de tarjetas
CREATE TABLE tarjeta(
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_tarjeta VARCHAR(16) NOT NULL UNIQUE,
    tipo_tarjeta ENUM('Debito','Credito') NOT NULL,
    fecha_expiracion DATE NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    ESTADO ENUM('Activa', 'Inactiva', 'Bloqueada') NOT NULL DEFAULT 'Activa',
    cuenta_id INT NOT NULL,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)