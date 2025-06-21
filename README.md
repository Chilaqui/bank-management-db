# 🏦 Sistema de Base de Datos Bancario

## 📋 Entidades Principales y Atributos

### 👥 Cliente
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **ClienteID** *(PK)* | `INT` | Identificador único del cliente |
| **Nombre** | `VARCHAR(50)` | Nombre del cliente |
| **Apellido** | `VARCHAR(50)` | Apellido del cliente |
| **FechaNacimiento** | `DATE` | Fecha de nacimiento |
| **Dirección** | `VARCHAR(255)` | Dirección de residencia |
| **Teléfono** | `VARCHAR(15)` | Número telefónico |
| **Email** | `VARCHAR(100)` | Correo electrónico |
| **FechaRegistro** | `DATETIME` | Fecha de registro en el sistema |

---

### 💳 Cuenta
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **CuentaID** *(PK)* | `INT` | Identificador único de la cuenta |
| **NúmeroCuenta** *(UNIQUE)* | `VARCHAR(20)` | Número único de cuenta |
| **TipoCuenta** | `ENUM` | Tipo: Ahorro, Corriente, Nómina |
| **Saldo** | `DECIMAL(15,2)` | Saldo actual de la cuenta |
| **FechaApertura** | `DATE` | Fecha de apertura |
| **Estado** | `ENUM` | Activa, Cerrada, Suspendida |
| **ClienteID** *(FK)* | `INT` | Referencia al cliente propietario |

---

### 👨‍💼 Empleado
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **EmpleadoID** *(PK)* | `INT` | Identificador único del empleado |
| **Nombre** | `VARCHAR(50)` | Nombre del empleado |
| **Apellido** | `VARCHAR(50)` | Apellido del empleado |
| **FechaNacimiento** | `DATE` | Fecha de nacimiento |
| **Puesto** | `VARCHAR(50)` | Cajero, Gerente, Asesor, etc. |
| **Departamento** | `VARCHAR(50)` | Departamento de trabajo |
| **FechaIngreso** | `DATE` | Fecha de ingreso a la empresa |
| **Email** | `VARCHAR(100)` | Correo electrónico corporativo |
| **Teléfono** | `VARCHAR(15)` | Número telefónico |

---

### 🏢 Sucursal
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **SucursalID** *(PK)* | `INT` | Identificador único de la sucursal |
| **NombreSucursal** | `VARCHAR(100)` | Nombre de la sucursal |
| **Dirección** | `VARCHAR(255)` | Dirección física |
| **Teléfono** | `VARCHAR(15)` | Teléfono de contacto |

---

### 💸 Transacción
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **TransaccionID** *(PK)* | `INT` | Identificador único de transacción |
| **FechaHora** | `DATETIME` | Fecha y hora de la transacción |
| **TipoTransaccion** | `ENUM` | Depósito, Retiro, Transferencia |
| **Monto** | `DECIMAL(15,2)` | Cantidad de la transacción |
| **CuentaOrigenID** *(FK)* | `INT` | Cuenta origen *(NULL para depósitos externos)* |
| **CuentaDestinoID** *(FK)* | `INT` | Cuenta destino *(NULL para retiros)* |
| **EmpleadoID** *(FK)* | `INT` | Empleado que procesó la transacción |

---

### 💳 Tarjeta
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **TarjetaID** *(PK)* | `INT` | Identificador único de la tarjeta |
| **NúmeroTarjeta** *(UNIQUE)* | `VARCHAR(16)` | Número único de tarjeta |
| **TipoTarjeta** | `ENUM` | Débito, Crédito |
| **FechaExpiración** | `DATE` | Fecha de vencimiento |
| **CVV** | `VARCHAR(4)` | Código de seguridad |
| **Estado** | `ENUM` | Activa, Bloqueada, Vencida |
| **CuentaID** *(FK)* | `INT` | Cuenta asociada |

---

### 💰 Préstamo
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **PrestamoID** *(PK)* | `INT` | Identificador único del préstamo |
| **Monto** | `DECIMAL(15,2)` | Monto del préstamo |
| **FechaOtorgamiento** | `DATE` | Fecha de otorgamiento |
| **FechaVencimiento** | `DATE` | Fecha límite de pago |
| **TasaInterés** | `DECIMAL(5,2)` | Tasa de interés anual |
| **Estado** | `ENUM` | Activo, Pagado, Vencido |
| **ClienteID** *(FK)* | `INT` | Cliente beneficiario |

---

### 💵 PagoPréstamo
| Atributo | Tipo | Descripción |
|----------|------|-------------|
| **PagoID** *(PK)* | `INT` | Identificador único del pago |
| **PrestamoID** *(FK)* | `INT` | Préstamo al que aplica |
| **FechaPago** | `DATETIME` | Fecha del pago |
| **MontoPago** | `DECIMAL(15,2)` | Cantidad pagada |
| **MétodoPago** | `ENUM` | Efectivo, Transferencia, Tarjeta |

---

## 🔗 Relaciones del Sistema

### Relaciones Principales

```
Cliente (1) ──────── (N) Cuenta
   │                     │
   │                     │
   └─── (1) ──── (N) Préstamo
                     │
                     └─── (1) ──── (N) PagoPréstamo

Cuenta (1) ──────── (N) Tarjeta

Empleado (1) ──────── (N) Transacción

Sucursal (1) ──────── (N) Empleado

Transacción ──── (N:1) ──── Cuenta (Origen)
            └─── (N:1) ──── Cuenta (Destino)
```

### Descripción de Relaciones

**🔸 Cliente - Cuenta** *(1:N)*
- Un cliente puede poseer múltiples cuentas
- Cada cuenta pertenece a un único cliente

**🔸 Cliente - Préstamo** *(1:N)*
- Un cliente puede solicitar varios préstamos
- Cada préstamo está asociado a un solo cliente

**🔸 Préstamo - PagoPréstamo** *(1:N)*
- Un préstamo puede tener múltiples pagos
- Cada pago corresponde a un préstamo específico

**🔸 Cuenta - Tarjeta** *(1:N)*
- Una cuenta puede tener varias tarjetas asociadas
- Cada tarjeta está vinculada a una cuenta

**🔸 Empleado - Transacción** *(1:N)*
- Un empleado puede procesar múltiples transacciones
- Cada transacción es procesada por un empleado

**🔸 Sucursal - Empleado** *(1:N)*
- Una sucursal tiene varios empleados
- Cada empleado pertenece a una sucursal

**🔸 Transacción - Cuenta** *(N:1)*
- Cada transacción puede involucrar una cuenta origen y/o destino
- Una cuenta puede participar en múltiples transacciones

---

## 🔑 Claves y Restricciones

### Claves Primarias (PK)
- Cada entidad tiene un identificador único autoincremental

### Claves Foráneas (FK)
- Mantienen la integridad referencial entre entidades relacionadas

### Restricciones Únicas
- `NúmeroCuenta` debe ser único en el sistema
- `NúmeroTarjeta` debe ser único en el sistema

### Restricciones de Dominio
- Los saldos y montos no pueden ser negativos
- Las fechas de vencimiento deben ser posteriores a las de otorgamiento
- Los estados están limitados a valores predefinidos

---