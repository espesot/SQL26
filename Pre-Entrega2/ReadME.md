## CODERHOUSE

### Practica N 2
### Alumno: Spesot Enzo

#### Base de datos retail_project

- Se crea la base de datos **retail_project**
- Luego se crean las 3 tablas solicitadas.

#### Tabla clientes
cuenta con
  - **id** que es serial y es la **FK**
  - **nombre** que es **VARCHAR(100)**
  - **email** varchar not null y ademas tiene que ser unico
  - **edad** que es intero
  - **activo** es una boolean para saber si el cliente sigue activo
  - **fecha_baja** que es cuando el cliente se va de baja
  - **chk_edad** Es un check que esta chequeando que la edad del cliente sea mauyor o igual a 18

#### Tabla productos
  - **id** que es serial y es la **PK** de la tabla
  - **codigo** es varchar no puede ser nulo y ademas es unico
  - **nombre**
  - **precio** es **decimal(10,2)** lo que significa que puede tener 10 digitos de los cuales 2 son decimales
  - **stock** es entero
  - **categoria** 
  - **chk_precio** es una restriccion para que el precio tiene que ser mayor a 0 (cero)
  - **chk_stock** el stock no puede ser negativo

#### Tabla ventas
  - **id** es serial y el la **PK** de la tabla
  - **cantidad** es entero y no puede ser nulo
  - **cliente_id** es int y se guarda el cliente que realizo la compra
  - **producto_id** es int y se guarda el producto que fue comprado
  - **chk_cantidad** la cantidad vendida tiene que ser mayor a 0
  - **fk_ventas_clinete** es una clave foranea que indica que el cliente que realiza la compra tiene que estar en la tabla **clientes**
  - **chk_ventas_productos** es una clave foranea que indica que el producto que fue vendido tiene que estar previamente registrado en la tabla **productos**

> Luego se cargan 5 registros en cada tabla, teniendo en cuentas las restricciones de cada tabla

>Se realiza un **UPDATE** en la tabla **productos** donde se hace un **SET** al campo **precio** y se le incrementa un 10% al precio actual, se utiliza un **WHERE** para filtrar y no hacer el aumento a todos solo a los que cumplan la condicion de **categoria = 'Hogar'**

>Se realiza un **DELETE** en la tabla **ventas** donde el campo **id = 1** para poder eliminar un solo registro y no toda la tabla.


