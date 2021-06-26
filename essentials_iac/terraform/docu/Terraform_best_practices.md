# Terraform
## Intro al documento
En el documento incluímos una primera versión de best practices que debemos tomar en consideración para estructurar un proyecto con terraform.

## Estructura del código
### Recomendaciones generales
- Usar siempre backends que permitan guardar el estado de forma remota.
- En los tfstate se guardan datos sensibles, no es buena idea tenerlos en git, los llevaremos a S3.
- Si los tfstate son remotos, podrán trabajar varias personas a la vez.
- Usar siempre que se pueda un lock de estado, para mantener la integridad de nuestros estados remotos.
- Crear cuantos menos recursos posibles y en su sección/carpeta correspondiente.
- Cuanto menor sea el radio de acción de un componente, menos posibilidad de que los componentes se pisen entre si y será más fácil que varias personas trabajen a la vez.
- Seguir la convención de nombres (se detalla con ejemplos abajo). Seguir una convención hace más fácil entender el proyecto sin haberlo hecho o sin haberlo modificado al cabo de meses desde la creación.
- No harcodear valores que se pueden pasar con variables o usando el data source.
- Usar los data source y especialmente terraform_remote_state como pegamento entre los diferentes recursos.

### Estructrua de un proyecto
En un proyecto, la estructura de directorios será similar a la siguiente:

```bash
.
├── environment
│   ├── dev
│   │   ├── 000-state_lock
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── README.md
│   │   │   └── terraform_config.tf
│   │   ├── 010-vpc
│   │   │   ├── data.tf
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── README.md
│   │   │   ├── terraform_config.tf
│   │   │   └── vars.tf
│   │   └── 020-security_groups
│   │       ├── data.tf
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── README.md
│   │       ├── terraform_config.tf
│   │       └── vars.tf
│   ├── global
│   │   └── iam
│   │       ├── main.tf
│   │       ├── README.md
│   │       └── terraform_config.tf
│   ├── pre
│   └── pro
├── modules
├── README.md
```

### Un poco más a detalle

- El código dentro de un proyecto se suele separar en entornos por componentes. Esto permite que varias personas puedan hacer modificaciones sin pisarse. También tener unos cimientos sólidos sobre los que poder crecer a medida que vamos incorporando recursos a nuestro proyecto. Por ejemplo, 000-state_lock y 010-vpc.
- Los números se usan para declarar el orden en el que se ejecuta el código. Se tiene que visualizar de forma secuencial, a la izquierda están los números más bajos y a la derecha los más altos: 000-state_lock, 010-vpc, 020-security_groups.
- Hay que evitar dependencias circulares. Cuando haya componentes que dependan entre si (por ejemplo una ec2 y su SG), hay que procurar declarar el recurso dependiente primero. Por ejemplo, los SG siempre irán en los números más bajos. La regla de oro visualizar los directorios como una secuencia y cada vez que se referencia a otro componente preguntarse “se referencia un componente a la izquierda?” si es que sí, estamos generando una dependencia circular. Si es que no, no lo hacemos y seremos más felices.
- En general, con crear un fichero main.tf en cada directorio será suficiente. Si hubiesen demasiados recursos, se podría añadir más ficheros con nombres descriptivos.

### Estructura de un recurso

- Siguiendo el ejemplo de organización anterior, dentro de cada componente se puede encontrar lo siguiente:
	- main.tf: Contiene el objeto principal del directorio. Por ejemplo en AWS, se creará una DynamoDB. A menos que el fichero sea demasiado grande, en cuyo caso veremos que se podría hacer a continuación.
	- data.tf: Contiene los data sources del componente.
	- locals.tf: Contiene los locals del componente. Estos se usan para convertir los datos de las variables o de algún componente de un tipo a otro. Por ejemplo, se puede tener una variable del tipo lista que tenga las regiones de una zona y en el locals se tiene el código que transforma esa lista a un string separado por comas.
	- outputs.tf: Contiene los outputs. Se definen principalmente para que otros componentes puedan referenciarlos usando el data source terraform_remote_state.
	- vars.tf: Contiene las variables del proyecto. Siempre que se pueda hay que definir la descripción, el tipo y dar un valor por defecto.
	- terraform_config.tf: Contiene la configuración del proyecto. En el caso de AWS, configura el bucket de s3 para guardar el estado, tiene la DynamoDB para el lock y tiene la versión de terraform mínima a usar.
	- Si el main.tf es demasiado grande, se puede partir en varios como vemos en el siguiente ejemplo:
```bash
.
├── dns.tf
├── nodes.tf
├── outputs.tf
├── variables.tf
├── README.md
└── templates
    └── nodes.tpl
```
	- La intención sería dividir en ficheros la lógica, no tanto por recursos concretos. Por ejemplo, en el caso de un módulo que crease un grupo de autoescalado de trabajo, con dominios asociados a los ELB y los SG necesarios para que todo funcione:
		- dns.tf: El dominio asociado a los ELB.
		- nodes.tf: Los ASG, los SG y los ELB.
		- templates/nodes.tpl: Si hubiesen ficheros a configurar en los nodos con plantillas, se pondrían en esta ruta.
		- variables.tf: Los parámetros de entrada del módulo.
		- outputs.tf: Los parámetros de salida del módulo.
		- locals.tf: Se usa para tratar variables. Por ejemplo, tenemos una variable en formato lista pero queremos tenerlo accesible como un string separado por comas.

### Convención de nombrado
#### Convenciones generales
- Usar guion bajo en vez de guion medio: nombres de recursos, variables, data sources.
- Usar sólo letras en minúsculas y números, sin ningún otro carácter.
- Usar inglés.
- Argumentos de los recursos.
- No repetir el nombre del recurso.
	- Bien: resource "aws_route_table" "public" {}
	- Mal: resource "aws_route_table" "public_route_table" {}
	- Mal: resource "aws_route_table" "public_aws_route_table" {}
- Si no hay ningún nombre descriptivo, usar this como nombre del recurso. Por ejemplo, si se tiene un aws_nat_gateway y varios aws_route_table, aws_nat_gateway será this y los aws_route_table tendrán nombres descriptivos, como public, private, database, ...
- Usar siempre nombres en singular.
- Usar los recursos count, for y similares al principio del recurso, para que quede claro que hay un bucle.
- Usar siempre el atributo tags si lo soporta el recurso, seguido por depends_on y lifecycle si son necesarios.
- this es una clave que se usa en distintos lenguajes de programación. Se usa para referenciarse a sí mismo.

#### Variables
- Lo mismo que aplica a los recursos.
- No definir valores vacíos y definir el tipo: Ejemplo type = "list".
- Usar el plural en las variables del tipo lista y mapa.
- Poner siempre las claves en el siguiente orden: description, type, default.
- Incluir descripción por muy obvio que parezca.

#### Outputs
- Es muy importante que sean consistentes y entendibles fuera de su alcance. Debería estar muy claro el qué atributos y de que tipo devuelve los valores.
- Seguir estructuras similares a {nombre}_{atributo}. 
- Nombre es el tipo de recurso sin el prefijo del proveedor. Por ejemplo, aws_vpc será vpc
- Atributo es el atributo del recurso. Por ejemplo, si se quiere el id del vpc, será id.
- Si solo hay un recurso, usar this: this_vpc_id
- Si se devuelve un solo valor, debería usarse en singular. Si es una lista o un mapa, debería ser en plural.
- Incluir descripción por muy obvio que parezca.
