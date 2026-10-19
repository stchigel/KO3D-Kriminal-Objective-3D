# Relevamiento de Jugabilidad Actual y Propuestas de Diseño

**Proyecto:** KO3D — Juego de investigación en escritorio simulado  
**Equipo:** Grupo de Investigación y Documentación  
**Versión:** 1.0  
**Fecha:** 18 de octubre de 2026  

---

## Contenido

1. Propósito del documento
2. Cómo se juega actualmente
3. Qué herramientas tiene hoy el jugador en el escritorio
4. Cómo se resuelven los dos casos actuales del proyecto
5. Diagnóstico del grupo de investigación
6. El grupo de investigación propone los siguientes cambios
7. Cómo quedan estructuradas las historias con los cambios propuestos

---

## 1. Propósito del documento

Este documento fue armado por el grupo de investigación y documentación para dejar en claro dos cosas. Primero, explicar de forma sencilla cómo se juega hoy la versión actual del proyecto que está en desarrollo: qué ve el jugador cuando entra a un caso, qué aplicaciones puede usar y cómo llega a acusar a un sospechoso. Segundo, dejar asentadas por escrito las propuestas de cambio que planteamos desde el equipo para que el juego y las historias de crimen que escribimos funcionen bajo un mismo sistema.

Cuando armamos el documento original de prototipos de historias, lo pensamos con varias mecánicas que todavía no están integradas en el juego actual, y a la vez el juego sumó cosas muy buenas (como el escritorio completo, las carpetas ocultas y el interrogatorio por WhatsApp) que en el documento de historias no estaban contempladas. La idea de este relevamiento es unir las dos puntas antes de pasar todo al motor.

---

## 2. Cómo se juega actualmente

Hoy una partida sigue un recorrido directo y lineal:

1. **Menú principal y selección de caso:** Al abrir el juego, el jugador pasa a una pantalla donde puede elegir entre los casos disponibles sin necesidad de destrabar el primero para jugar el segundo.
2. **Presentación del caso (correo de encargo):** Antes de entrar a la computadora, aparece en pantalla un correo formal de la Unidad de Criminalística Digital. Ese mensaje presenta a la víctima, cuenta quién encontró el cuerpo, detalla qué elemento de la escena no cierra (por ejemplo, que solo falta una cámara fotográfica sin que hayan forzado la puerta) y muestra una tabla con los primeros sospechosos.
3. **Exploración del escritorio:** Al tocar el botón de acceso a la PC, el jugador entra al escritorio de la computadora de la víctima. A diferencia de un juego guiado paso por paso, acá las carpetas, los archivos, el correo y el WhatsApp ya están disponibles para revisarlos en el orden que uno quiera.
4. **Cierre de la sesión:** Cuando el jugador siente que ya reunió la información necesaria y sabe quién es el culpable, va al botón de apagado en la esquina superior derecha de la pantalla y elige **Desconectar**.
5. **Juicio y desenlace:** Desconectarse de la computadora lleva directamente a la pantalla de acusación. Ahí aparecen los nombres o fotos de los sospechosos (y, según el caso, la opción de archivar la muerte como accidente). Al elegir uno, el juego pasa a la pantalla final, indica si la elección fue correcta o incorrecta y muestra un texto contando qué pasó después con la causa.

---

## 3. Qué herramientas tiene hoy el jugador en el escritorio

En la versión actual, la investigación pasa por cruzar lo que dicen distintas aplicaciones dentro de la computadora:

### Carpetas, archivos y Papelera
El escritorio tiene acceso a la carpeta principal del usuario (`Home`) y a la Papelera (`Trash`). Adentro hay subcarpetas organizadas por temas (Fotos, Trabajo, Clientes, Personal, Notas, Análisis). Los archivos se abren con doble clic y pueden ser de tres tipos:
- **Notas de texto (`.txt`):** apuntes personales, diarios de viaje, listas o borradores de mensajes que la víctima nunca llegó a mandar.
- **Imágenes (`.png` / `.jpg`):** fotos tomadas por la víctima o guardadas en sus carpetas de trabajo.
- **Documentos tipo PDF:** informes, presupuestos, contratos o cartas que se muestran como una o dos páginas escaneadas.

Además, cada vez que arranca un caso, el juego reparte automáticamente entre las carpetas varios archivos de texto con trámites, actas y notas de oficina que no tienen que ver con el crimen. Eso sirve para que las carpetas tengan volumen y el jugador tenga que separar lo importante de lo cotidiano.

### Carpetas ocultas y archivos con contraseña
El escritorio actual tiene dos mecánicas muy buenas para esconder pruebas importantes:
- **Carpetas o archivos ocultos:** Hay iconos en el escritorio que a simple vista son invisibles. Para encontrarlos, el jugador tiene que hacer clic y arrastrar el rectángulo de selección del mouse por el escritorio; cuando el rectángulo pasa por encima de la posición del archivo oculto, el icono se revela y se puede abrir con doble clic.
- **Archivos protegidos con contraseña:** Algunos paquetes comprimidos (`.7z`) o carpetas piden clave al intentar abrirlos. La clave no se adivina al azar: siempre sale de cruzar una nota que explica cómo está formada (por ejemplo, el nombre de un cuadro más un año) con otro documento donde aparece ese dato.

### WhatsApp (historial e interrogatorio)
Desde la barra inferior se abre WhatsApp, que cumple una doble función:
- **Leer el pasado:** Al entrar a cada contacto se ve la conversación que tuvo esa persona con la víctima en los días previos a la muerte, con fecha y hora de cada mensaje.
- **Interrogar en el presente:** Abajo de cada conversación hay un menú desplegable con preguntas preparadas. El jugador escribe como investigador a cargo del caso: elige una pregunta, la envía y al segundo recibe la respuesta del contacto. Esta mecánica permite comparar lo que un sospechoso declara hoy con los correos o archivos privados que quedaron en la computadora.

### Correo electrónico (Gmail)
También desde la barra inferior se abre el correo de la víctima, con su bandeja de entrada y la vista de borradores. Ahí aparecen confirmaciones de trabajo, gastos del edificio, turnos médicos y, sobre todo, discusiones más formales o amenazas previas al crimen.

### Cámara 3D y Expediente (estado actual en el proyecto)
En el proyecto ya están programadas dos piezas más que hoy solo aparecen activas en una escena de prueba:
- **La ventana de Cámara 3D:** Muestra una habitación en tres dimensiones vista desde una cámara fija que el jugador puede rotar hacia la izquierda, derecha, arriba y abajo con flechas en pantalla. Al pasar el mouse por ciertos objetos de la habitación (como un celular sobre el escritorio, un papel tirado al lado del cesto o un cuadro torcido), el objeto se ilumina y al hacerle clic se anota como pista.
- **El Expediente desplegable:** Es una carpeta en el borde inferior derecho que sube cuando se registra una pista nueva (ya sea tocando un objeto en la cámara 3D o haciendo clic en una frase marcada dentro de un archivo de texto) y guarda el título, la descripción, la fuente y la hora.

Hoy por hoy, en los dos casos principales del juego, ni los chats ni los correos ni los archivos están conectados a ese Expediente, y la pantalla de Juicio tampoco revisa qué pistas juntó el jugador: solo se fija en qué botón de sospechoso tocó al final.

---

## 4. Cómo se resuelven los dos casos actuales del proyecto

Para entender cómo razona hoy el jugador con estas herramientas, sirve repasar los dos casos que ya están armados en el código:

### Caso 1: Lucas Rodrigo Mendez (Expediente 1108-F)
Lucas es un fotógrafo de 34 años que aparece muerto de un golpe en la cabeza en su departamento de Palermo. No forzaron la puerta ni se llevaron plata ni equipos, salvo su cámara principal. Los dos sospechosos son **Tomás Herrera** (ex amigo peleado por un trabajo) y **Camila Rossi** (su novia).

Al revisar la computadora, el jugador ve que Tomás estaba furioso porque Lucas le ganó un trabajo para una revista, pero en la Papelera hay un borrador donde Lucas le pide tomar un café a Tomás para contarle que encontró algo raro en las fotos de un evento. Eso muestra que el problema venía por otro lado.

En WhatsApp, Camila le pregunta a Lucas el jueves si ya procesó las fotos del evento, insiste con saber si sacó fotos de la **zona de cajas** y le pregunta si todavía las tiene todas en la cámara. Lucas le contesta que algunas siguen en la cámara y otras ya las pasó a la compu, y quedan en verse el viernes. En el correo, Lucas le avisa que en las fotos de la zona de cajas se ve algo raro y que prefiere hablarlo en persona. Cuando el jugador entra a la carpeta de trabajo del evento y abre las últimas fotos (`12.png` a `15.png`), ve a Camila robando plata de la caja.

El cierre sale por contradicción y horario: una nota en la carpeta Personal dice que Camila iba el viernes a las 21; el vecino Jorge cuenta por WhatsApp que a las 21 vio entrar a una mujer joven de pelo oscuro y más tarde escuchó un golpe fuerte; y cuando el jugador interroga a Camila por las fotos, ella miente diciendo que Lucas solo le mandó un link normal y que no había nada raro. Al desconectarse y acusar a **Camila**, el caso se resuelve.

### Caso 2: Marcelo A. Vidal (Expediente 1114-V)
Marcelo Vidal, perito tasador de obras de arte, aparece muerto al pie de la escalera interna de su departamento. Las tres opciones en el juicio son acusar al empresario **Lorenzo Machi**, acusar al galerista **Dante Ferreyra** o cerrar el caso como **Accidente**.

Primero el jugador descarta el accidente: en el correo hay un turno con el traumatólogo por la rodilla y, al interrogar por WhatsApp a Rosa (la empleada), ella asegura que Vidal jamás usaba la escalera y siempre bajaba en ascensor. Además, en el chat con `LM` (Lucas Mirabal), Vidal cuenta la noche del lunes a las 22:51 que alguien entró a su departamento y movió su notebook, minutos antes de dejar de contestar para siempre.

Entre Ferreyra y Machi, los correos y chats muestran que ambos estaban metidos en una red de certificados falsos de cuadros, pero Ferreyra estaba asustado y actuaba como intermediario, mientras que Machi amenazó directamente a Vidal cuando este se negó a firmar el certificado falso de un Quinquela Martín. En el interrogatorio, Mirabal avisa que Vidal dejó una copia de todas las pruebas en una carpeta oculta cuya clave tiene que ver con Giotto.

En la carpeta Personal hay una nota para el abogado Guillermo Saenz que indica buscar la carpeta oculta `.respaldo_nov` y abrir `paquete_final.7z` con el nombre del cuadro que vieron en Venecia más el año del viaje. Leyendo el diario de viaje de 1998 se encuentra el fresco de Giotto (*La Lamentación de Cristo*). El jugador arrastra el selector sobre el escritorio para descubrir `.respaldo_nov`, abre el archivo con la clave `lamentación1998` y encuentra la carta para la fiscalía donde Vidal documenta que la empresa fantasma Artes del Sur es de **Lorenzo Machi**.

---

## 5. Diagnóstico del grupo de investigación

Al comparar cómo se juega hoy el proyecto con las seis historias que diseñamos en el documento de prototipos, desde el grupo de investigación encontramos tres diferencias importantes que necesitamos resolver:

1. **Falta el navegador web en el escritorio:** Nuestras historias dependen mucho de salir de los archivos locales para investigar foros del barrio, redes sociales, páginas de reseñas, webs de colegios, hoteles o radios y sitios de compraventa. Hoy el escritorio solo tiene archivos locales, correo y WhatsApp.
2. **La lectura hoy es pasiva y sin subrayado:** En el juego actual el jugador lee chats, mails y notas, pero no puede subrayar fragmentos dentro de ellos para guardar pistas o destrabar lugares nuevos. Todo queda librado a lo que el jugador se acuerde de memoria.
3. **Las pistas no se agrupan por sospechoso ni se usan en el juicio:** Hoy el Expediente es una lista general desconectada de los casos, y en el Juicio solo hay botones con nombres. El jugador no puede revisar la ficha de cada sospechoso en el juicio ni respaldar su acusación con las pistas que fue encontrando.

---

## 6. El grupo de investigación propone los siguientes cambios

Para unificar el juego sin perder lo que ya funciona bien en el escritorio actual, el grupo de investigación propone tres cambios concretos en la jugabilidad:

### 6.1. Agregar más sitios web mediante un navegador en el escritorio
Proponemos sumar el **Navegador** como aplicación fija de la barra de tareas (junto a WhatsApp y Correo). Adentro del navegador, cada caso va a contar con varios sitios web propios del universo de la historia:
- Redes sociales y muros comunitarios (*Barrio*, *Chusmeo*, *Lienzo*, *Laburantes*), donde se pueden ver perfiles públicos, fotos, comentarios cruzados entre sospechosos y buscadores de usuarios o alias.
- Foros y páginas barriales (*Gateros del Oeste*, el muro de oyentes de *Radio Vecina* o el blog *Micrófono Abierto*).
- Sitios institucionales y comerciales (la web del *Hotel Mirador*, la web del *Instituto San Martín*, el portal de reseñas *Opiná*, la página de la colecta *Encontremos a Tomi* o el portal de compraventa *FeriArte*).
- Accesos web con inicio de sesión (como nubes de archivos *FrostCloud*, el *Drive* del curso o sistemas internos).

Algunos sitios pueden estar disponibles desde el inicio en los marcadores de la computadora, y otros se van habilitando en el navegador a medida que el jugador encuentra y subraya su mención en una nota, un correo o un chat.

### 6.2. Incorporar el subrayado como nuestra mecánica principal
Proponemos que **subrayar fragmentos de texto** sea la mecánica central con la que el jugador investiga en todas las ventanas del juego: archivos `.txt`, correos, chats e interrogatorios de WhatsApp, publicaciones de sitios web y descripciones de la cámara 3D.

El sistema que planteamos funciona así:
- Dentro de los textos hay fragmentos que se pueden subrayar con un clic. Para el jugador todos se ven con el mismo resaltado, sin distinguir visualmente si son pistas verdaderas o trampas.
- Cada documento, correo, chat o publicación tiene un **límite de subrayado de entre 3 y 5 fragmentos**. Eso evita que el jugador subraye todo sin leer. Si llega al límite y quiere marcar otra cosa, puede quitarle el subrayado a un fragmento anterior en cualquier momento.
- Internamente para el diseño, los fragmentos cumplen cinco funciones:
  - **Lugar (`[L]`):** menciona una página web, aplicación, carpeta o archivo y lo habilita o lo señala para ir a revisarlo.
  - **Pista de acceso (`[P]`):** guarda un dato concreto que sirve para armar una contraseña, un PIN o una búsqueda en el navegador.
  - **Contexto e indicio (`[C]`):** guarda motivos, horarios, contradicciones o coartadas que arman el caso a favor o en contra de un sospechoso.
  - **Trampa (`[T]`):** datos verdaderos pero irrelevantes o sospechas engañosas que ocupan lugar si el jugador se distrae.
  - **Pista definitiva (`[D]`):** la prueba irrefutable que termina de demostrar quién cometió el hecho.

### 6.3. Mejorar la recolección de pistas por sospechoso y usar su fichero en el Juicio
Proponemos transformar el Expediente actual en un **Fichero de sospechosos** que acompañe al jugador durante toda la investigación y sea la herramienta central de la pantalla de Juicio:

1. **Fichas individuales por sospechoso:** A medida que aparecen los involucrados del caso, el Fichero habilita una pestaña o ficha para cada sospechoso (además de un apartado para datos de acceso y contraseñas).
2. **Asociar las pistas subrayadas a cada sospechoso:** Cuando el jugador subraya un fragmento relevante (por ejemplo, una amenaza en un mail, una mentira en el interrogatorio de WhatsApp, una coartada que lo descarta o un rastro en la cámara 3D), esa pista se guarda y puede asociarse a la ficha del sospechoso correspondiente. Así el jugador va armando el expediente de cada persona: qué motivo tenía, dónde estaba, qué dijo en el chat y qué pruebas reales la comprometen o la dejan afuera.
3. **Leer el fichero de cada sospechoso en el Juicio y acusar con pruebas:** Cuando el jugador toca *Desconectar* y pasa al Juicio, ya no se encuentra con botones vacíos. En la pantalla de Juicio puede **abrir y leer el fichero completo de cada sospechoso** con todas las pistas que recolectó durante la partida. Para cerrar el caso, el jugador debe **marcar quién es el asesino (o culpable) y seleccionar dentro de su fichero las pistas que determinó para incriminarlo** (incluyendo la pista definitiva). Si elige al culpable correcto y lo respalda con las pistas que prueban su autoría, obtiene el final bueno; si acusa a un inocente o presenta pruebas que no sostienen el cargo, el juicio falla.

---

## 7. Cómo quedan estructuradas las historias con los cambios propuestos

Con la jugabilidad actual más estos tres cambios propuestos por el grupo de investigación, todas las historias del proyecto (tanto los seis prototipos como futuros casos) pasan a compartir la misma estructura completa:

| Componente del caso | Cómo se usa en las historias adaptadas |
|---|---|
| **Presentación inicial** | Mensaje o correo al arrancar la partida que plantea el hecho, el detalle que no cierra y el primer archivo a revisar en la PC. |
| **Escritorio y carpetas** | Archivos `.txt`, documentos, Papelera, carpetas o usuarios bloqueados con contraseña y archivos de contexto. |
| **WhatsApp (historial + interrogatorio)** | Conversaciones previas de la víctima y preguntas seleccionables para que el jugador interrogue a los sospechosos y testigos y pueda subrayar sus contradicciones. |
| **Navegador con sitios web** | Redes sociales, foros, webs institucionales, reseñas, nubes de backups y buscadores donde se rastrean perfiles, alias y publicaciones. |
| **Correo electrónico** | Bandeja de entrada y enviados/borradores con avisos formales, reclamos, turnos, claves y amenazas. |
| **Cámara 3D en vivo** | Habitación del caso que se recorre hacia izquierda, centro, derecha y abajo; al tocar los objetos se generan notas cuyos fragmentos también se pueden subrayar. |
| **Subrayado y Fichero de sospechosos** | El jugador subraya entre 3 y 5 fragmentos por documento y organiza los indicios (`[C]`, `[D]`) dentro de la ficha de cada sospechoso. |
| **Juicio con lectura del Fichero** | Al desconectarse, el jugador lee el fichero de cada sospechoso en el juicio, marca al culpable y presenta las pistas de su fichero que prueban el caso. |

