# Relevamiento De Jugabilidad Y Propuestas

Equipo de Investigación y Documentación

Cómo se juega hoy el proyecto, cómo se resuelven los casos actuales y qué cambios propone el grupo de investigación para unificar el juego con las historias.

**Proyecto:** KO3D — Juego de investigación en escritorio simulado

**Documento:** Jugabilidad actual y propuestas de diseño

**Equipo:** Grupo de Investigación y Documentación

**Versión:** 1.0

**Fecha:** 18 de octubre de 2026

**Control de versiones**

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 18/10/2026 | Relevamiento completo de la jugabilidad actual del proyecto y propuestas del grupo de investigación para sumar sitios web, mecánicas de subrayado y fichero de sospechosos en el juicio. |

**Contenido**

1. Propósito del documento

2. Cómo se juega actualmente

3. Herramientas que hoy tiene el jugador en el escritorio

4. Cómo descubre el jugador al asesino en los casos actuales

5. Diagnóstico del grupo de investigación

6. El grupo de investigación propone los siguientes cambios

7. Cómo se adaptan nuestras historias al juego con estos cambios

## 1. Propósito del documento

Desde el grupo de investigación y documentación armamos este documento con dos objetivos. El primero es explicar en claro cómo se juega hoy la versión actual del proyecto: qué ve una persona cuando arranca una partida, qué puede tocar dentro de la computadora y cómo hace hoy para descubrir quién es el asesino. El segundo es dejar asentadas por escrito las propuestas de mejora que planteamos desde el equipo para que el juego incorpore las mecánicas que necesitan nuestras historias de crimen.

Cuando escribimos el documento de prototipos de historias, lo habíamos pensado para una estructura distinta, mucho más guiada paso por paso y centrada en resaltar texto dentro de un fichero. Por su lado, la versión actual del juego desarrolló cosas muy sólidas que queremos conservar, como el escritorio libre con carpetas, las carpetas ocultas, los archivos con contraseña y el interrogatorio por WhatsApp. Este documento explica cómo funciona hoy el juego y qué cambios concretos proponemos para unir las dos cosas.

## 2. Cómo se juega actualmente

En el estado actual del proyecto, una partida completa recorre cinco momentos bien marcados, sin límite de tiempo ni pantallas de derrota intermedias:

| Etapa | Qué hace el jugador hoy |
|---|---|
| 1. Menú y selección de caso | El jugador entra al menú principal y pasa a una pantalla de selección donde elige cuál de los casos quiere investigar. Hoy los casos están abiertos desde el principio, sin necesidad de resolver el primero para destrabar el siguiente. |
| 2. Correo inicial de encargo | Antes de ver el escritorio, aparece un correo de la Unidad de Criminalística Digital. Ese mensaje cuenta quién es la víctima, cómo encontraron el cuerpo, qué detalle de la escena no cierra y quiénes son los primeros sospechosos. Abajo tiene el botón para entrar a la computadora. |
| 3. Investigación en el escritorio | El jugador entra a la computadora de la víctima. A diferencia de una aventura lineal, acá tiene acceso libre a las carpetas del sistema, la Papelera, el correo electrónico y el WhatsApp para revisar todo en el orden que quiera. |
| 4. Desconexión | Cuando el jugador cree que ya entendió qué pasó y quién es el culpable, hace clic en el botón de apagado arriba a la derecha de la pantalla y toca el botón Desconectar. |
| 5. Juicio y desenlace | Al desconectarse, pasa a la pantalla de Juicio donde aparecen los nombres o fotos de los sospechosos (y, según el caso, la opción de que haya sido un accidente). Al hacer clic en uno, el juego pasa a la pantalla final, dice si acertó o falló y muestra un texto contando cómo terminó la causa. |

## 3. Herramientas que hoy tiene el jugador en el escritorio

Hoy toda la jugabilidad ocurre adentro de una computadora que imita un sistema operativo con barra de tareas abajo, barra de estado arriba e iconos en el escritorio. Las ventanas se abren, se arrastran con el mouse desde la barra superior y se cierran con la X.

### 3.1 Carpetas, archivos y Papelera

En el escritorio están la carpeta personal (Home) y la Papelera (Trash). Adentro hay subcarpetas ordenadas por temas como Fotos, Trabajo, Clientes, Personal o Notas. Los archivos se abren con doble clic y hoy existen tres visores distintos:

**Archivos de texto (.txt):** muestran notas personales, diarios de viaje, recordatorios de agenda, listas de música o borradores que la víctima dejó sin mandar.

**Visor de imágenes (.png / .jpg):** abre fotos individuales, tanto de carpetas personales como de coberturas de eventos.

**Visor de documentos PDF:** muestra contratos, informes técnicos, presupuestos o cartas a la fiscalía en formato de una o dos páginas escaneadas.

Además, cada vez que empieza una partida, el juego genera automáticamente archivos de texto con nombres de oficina (presupuestos, actas, memos, balances) y los reparte al azar por las carpetas: entre 3 y 8 en el caso de Lucas y entre 8 y 15 en el de Vidal. Eso hace que la computadora no tenga solamente los archivos del crimen y obliga al jugador a separar lo importante del papelerío normal.

### 3.2 Carpetas ocultas y archivos con contraseña

Para que no todo esté a la vista desde el primer minuto, el escritorio actual tiene dos mecánicas de descubrimiento muy interesantes:

**Carpetas ocultas con selección del mouse:** hay carpetas o archivos en el escritorio que arrancan invisibles. La única forma de verlos es haciendo clic y arrastrando el rectángulo azul de selección del mouse por el escritorio. Cuando el rectángulo pasa por encima del lugar donde está la carpeta oculta, el icono aparece en pantalla y el jugador puede abrirlo con doble clic.

**Archivos protegidos con contraseña:** algunos archivos comprimidos (.7z) o carpetas no se abren directo al hacer doble clic, sino que muestran un recuadro pidiendo una contraseña. Para sacarla, el jugador tiene que cruzar dos documentos: uno que le dice cómo está armada la clave (por ejemplo, el nombre de una pintura más un año) y otro donde aparece ese dato.

### 3.3 WhatsApp: historial previo e interrogatorio en vivo

WhatsApp se abre desde el icono de la barra inferior y es una de las herramientas más fuertes que tiene hoy el juego, porque junta dos momentos distintos en la misma ventana:

**El historial de la víctima:** al tocar un contacto de la lista de la izquierda, aparecen todos los mensajes que esa persona intercambió con la víctima en los días anteriores a su muerte, con fecha y hora.

**El interrogatorio del jugador:** abajo de la conversación hay un desplegable donde el jugador, actuando como el agente a cargo del caso, puede elegir entre 3 y 4 preguntas para mandarle a ese contacto en el presente. Cuando envía una pregunta, al segundo llega la respuesta del sospechoso o testigo.

Esta combinación funciona muy bien porque permite leer primero lo que el sospechoso hablaba en privado con la víctima y después hacerle preguntas para ver en qué miente o qué intenta ocultar.

### 3.4 Correo electrónico (Gmail)

También desde la barra inferior se abre el correo de la víctima. Tiene botones de Recibidos, Enviados y Borradores, aunque hoy solo Recibidos tiene contenido: Enviados todavía no funciona y la lista de borradores está vacía en los dos casos. Se usa para encontrar comunicaciones que no pasarían por WhatsApp: reclamos formales, amenazas, turnos médicos, expensas y correos donde la víctima dejó asentado algún problema antes de morir.

### 3.5 Cámara 3D y Expediente (en qué estado están hoy)

En el código del proyecto ya están armadas dos herramientas más que todavía no se aprovechan en los dos casos jugables:

**La ventana de Cámara 3D:** muestra una habitación en tres dimensiones que el jugador puede mirar girando la cámara hacia la izquierda, la derecha, arriba y abajo mediante botones en pantalla. Ciertos objetos del cuarto (como un celular arriba del escritorio, un bollo de papel cerca del tacho o un cuadro torcido en la pared) se iluminan al pasar el mouse y, cuando el jugador les hace clic, se anotan como pista. También tiene un botón para volver a la vista inicial. Hoy esta ventana solo está colocada en la escena de pruebas, no en los escritorios de los casos.

**El Expediente:** es una pestaña en la esquina inferior derecha del escritorio. Cuando el jugador hace clic en un objeto 3D de la cámara o en una frase enlazada dentro de un archivo de texto, el Expediente se asoma automáticamente y agrega una tarjeta con el título de la pista, una breve descripción, de qué archivo o cámara salió y la hora.

La pestaña del Expediente ya aparece en los escritorios de los dos casos, pero queda vacía: ninguna nota, chat, correo ni imagen de esos casos tiene pistas conectadas, y los enlaces dentro de textos solo existen en la escena de pruebas. Además, cuando el jugador pasa a la pantalla de Juicio, lo anotado no se usa para nada.

## 4. Cómo descubre el jugador al asesino en los casos actuales

Como hoy el juicio no pide presentar pruebas sino elegir un nombre, toda la deducción ocurre en la cabeza del jugador atando cabos entre carpetas, correos y chats. Así funcionan los dos casos que hoy están en el juego:

### 4.1 Caso 1: Lucas Rodrigo Mendez (Expediente 1108-F)

| Aspecto | Detalle |
|---|---|
| Víctima y escena | Lucas Mendez (34 años, fotógrafo). Aparece muerto de un golpe en la cabeza en su departamento de Palermo. La puerta no fue forzada y no robaron plata ni computadoras: lo único que falta es su cámara Canon EOS R5. |
| Sospechosos en el juicio | Tomás Herrera (ex amigo y rival laboral) y Camila Rossi (novia de Lucas). |
| El sospechoso falso (Tomás) | En WhatsApp y en el correo se ve que Tomás estaba muy enojado porque Lucas le había ganado un trabajo para una revista. Sin embargo, en la Papelera hay un borrador donde Lucas le escribe a Tomás que encontró algo en unas fotos de un evento, que no sabe qué hacer y que le propone tomar un café. Eso sugiere que lo que preocupaba a Lucas venía por otro lado. Cuando se lo interroga, Tomás dice que estuvo solo en su casa y que no tiene coartada. |
| Las pruebas contra Camila | En el historial de WhatsApp del jueves 17/10, Camila le pregunta a Lucas si ya procesó las fotos del evento del jueves, le pregunta específicamente si sacó fotos de la zona de cajas y si todavía las tiene todas en la cámara. Lucas le responde que algunas siguen en la cámara y otras ya las pasó a la compu, y quedan en verse el viernes. |
| La evidencia visual y la mentira | En el correo, Lucas le avisa a Camila que en las fotos de la zona de cajas se ve algo raro y que prefiere hablarlo en persona, y ella le contesta que no hace falta que haga nada con esas fotos porque las encargó ella. En Trabajo > Eventos > evento_jueves_rossi_import, las últimas cuatro fotos (12.png a 15.png) muestran a una mujer sacando plata de la caja. El juego no dice quién es: el jugador la vincula con Camila por el chat y los correos. Cuando se la interroga por esas fotos, Camila dice que Lucas solo le mandó un link con fotos del evento y que no había nada raro, lo que choca con el correo. |
| Ubicación en la noche del crimen | En Personal > Notas > viernes.txt, Lucas anotó que Camila iba a las 21 a hablar de las fotos, y en el interrogatorio Camila admite que fue al departamento esa noche. El vecino Jorge cuenta que escuchó un golpe fuerte y que vio entrar a una mujer joven de pelo oscuro como a las 21. Con todo eso el jugador acusa a Camila Rossi. |

### 4.2 Caso 2: Marcelo A. Vidal (Expediente 1114-V)

| Aspecto | Detalle |
|---|---|
| Víctima y escena | Marcelo Vidal, perito tasador de arte, aparece muerto en su departamento. El correo de presentación de este caso tiene el asunto correcto, pero el cuerpo repite el texto del caso de Lucas Mendez, así que hoy el jugador no recibe un resumen propio. La idea de una caída por la escalera interna surge del interrogatorio a Rosa y de la opción Accidente del juicio. |
| Opciones en el juicio | Lorenzo Machi (empresario), Dante Ferreyra (galerista) o Accidente. |
| Cómo se descarta el accidente | En el correo hay un turno confirmado con el traumatólogo por la rodilla de Vidal. Al interrogar por WhatsApp a Rosa, la empleada doméstica, ella asegura que por esa rodilla Vidal jamás usaba la escalera y bajaba siempre en ascensor. Además, en el chat con LM (Lucas Mirabal), Vidal cuenta el lunes a las 22:51 que alguien entró a su departamento y movió su notebook, minutos antes de dejar de responder. |
| Cómo se separa al cómplice del asesino | Los correos y chats muestran que Dante Ferreyra estaba metido en la maniobra de obras falsas, pero estaba asustado y advertía que había gente incómoda con los tiempos. En cambio, Lorenzo Machi amenazó directamente a Vidal por mail y por WhatsApp cuando Vidal se negó a certificar un supuesto Quinquela Martín de 1938 con pigmentos que no existían antes de 1958. Además, al interrogar a LM, este señala directamente a Machi y describe a Ferreyra como cómplice económico. |
| El puzle de la carpeta oculta | Al interrogar a LM por WhatsApp, revela que Vidal guardó una copia de las pruebas en una carpeta oculta y que la clave tiene que ver con Giotto. En Home > Personal hay una nota dirigida a Guillermo, el amigo con quien Vidal viajó a Italia, que dice que en la carpeta oculta .respaldo_nov está paquete_final.7z y que la clave es el nombre del cuadro que vieron juntos en Venecia más el año en que lo vieron. La misma nota afirma que Artes del Sur SRL es de Machi, que Iturbe es su testaferro y que Ferreyra sabía. En el diario de viaje de 1998, Vidal cuenta que el fresco que más lo impactó fue La Lamentación de Cristo, de Giotto. Arrastrando el rectángulo de selección sobre el escritorio aparece .respaldo_nov, y con la clave lamentación1998 (con tilde y todo junto) se abre el paquete con la carta para la fiscalía. |

## 5. Diagnóstico del grupo de investigación

Al revisar el código actual junto con nuestro documento de historias (Prototipos de Historias de Crimen), desde el equipo de investigación encontramos estos puntos a resolver:

**1. Las historias nuevas necesitan salir a internet:** en nuestros seis casos aparecen foros barriales, redes sociales, páginas de reseñas, sitios web de hoteles, colegios y radios, nubes privadas y portales de compraventa. Hoy el escritorio del juego solo tiene archivos locales, correo y WhatsApp, pero no tiene navegador web.

**2. En el juego actual falta la mecánica de subrayar:** hoy el jugador lee todo pero no puede subrayar fragmentos en los documentos, correos ni chats. En cambio, nuestro diseño narrativo se apoya en que el jugador tenga que decidir qué frases subraya dentro de un límite por documento.

**3. El Expediente y el Juicio hoy están desconectados:** en el juego actual las pistas no se organizan por sospechoso y en la pantalla de Juicio el jugador toca un nombre a ciegas, sin poder leer lo que juntó sobre cada sospechoso ni demostrar por qué lo acusa.

**4. Hay detalles de contenido para corregir en los casos actuales:** el cuerpo del correo de presentación del caso de Vidal repite el texto del caso de Lucas; en el caso de Lucas, Tomás dice por WhatsApp que no tiene coartada, pero el final del juicio dice que estuvo en un casamiento con cincuenta testigos; el vecino Jorge describe a una mujer de pelo oscuro, mientras que la foto de perfil de Camila la muestra rubia; en el caso de Vidal, la pregunta a Machi habla de la noche del martes 12, pero los mensajes muestran que Vidal dejó de responder el lunes 11 a la noche; la nota para Guillermo ubica el fresco en Venecia, aunque el diario lo sitúa en Padua; el escritorio de Vidal conserva un borrador para Tomás copiado del caso de Lucas, que no se puede abrir desde ninguna carpeta; y el botón Enviados del correo no tiene función.

## 6. El grupo de investigación propone los siguientes cambios

Para que el juego aproveche todo lo que ya tiene hecho y a la vez soporte nuestras historias completas, el grupo de investigación propone implementar tres cambios en la jugabilidad. Estas propuestas definen cómo debe jugarse la versión unificada del proyecto:

### 6.1 Propuesta 1: Agregar el navegador y más sitios web consultables

Proponemos sumar una aplicación de Navegador en la barra de tareas de la computadora (al lado de WhatsApp y del Correo). Adentro del navegador, el jugador va a poder consultar distintos sitios web propios de cada caso:

**Redes sociales y muros públicos:** sitios como Barrio, Chusmeo, Lienzo o Laburantes, donde el jugador puede revisar perfiles de las víctimas y los sospechosos, ver fotos publicadas, leer peleas o comentarios en los posteos y usar el buscador para rastrear un usuario o un alias bancario.

**Foros, blogs y páginas comunitarias:** como el foro Gateros del Oeste, el blog Micrófono Abierto o el muro de mensajes en vivo de los oyentes de la radio.

**Páginas institucionales, reseñas y portales de venta:** la página web del Hotel Mirador, la web del Instituto San Martín, la web de Radio Vecina, el sitio de reseñas Opiná, la colecta Encontremos a Tomi y el portal de compraventa FeriArte.

**Servicios web con contraseña:** nubes de archivos y sistemas internos como FrostCloud, el Drive compartido del curso o el sistema de reservas del hotel, que piden usuario y contraseña deducidos durante la investigación.

Para que la navegación sea ordenada y no abrume al jugador con veinte pestañas desde el minuto cero, algunos sitios estarán en los marcadores iniciales y los demás se irán habilitando en el navegador cuando el jugador encuentre y subraye su mención en una nota, correo o conversación.

### 6.2 Propuesta 2: Incorporar el subrayado como nuestra mecánica principal

Proponemos que subrayar fragmentos de texto sea la mecánica central de investigación en todas las ventanas del juego: notas de texto, correos electrónicos, chats e interrogatorios de WhatsApp, páginas web del navegador y notas descriptivas de la cámara 3D.

El funcionamiento concreto que plantea el grupo de investigación es el siguiente:

| Regla del sistema | Cómo funciona en la partida |
|---|---|
| Selección y subrayado | Dentro de cada documento, correo, chat o página web hay frases y datos que el jugador puede subrayar con un clic. Para el jugador todos los fragmentos subrayables tienen el mismo aspecto visual, sin revelar de antemano si son pistas reales o distractores. |
| Límite por documento | Cada documento tiene un límite de entre 3 y 5 subrayados (indicado arriba del texto). Esto obliga al jugador a leer con atención y elegir qué datos realmente importan. Si llega al límite, puede quitar un subrayado anterior en cualquier momento para liberar lugar. |
| Destrabe de lugares y claves | Cuando el jugador subraya la mención a un sitio web, una aplicación o un archivo (fragmentos de tipo Lugar), ese acceso se habilita en la computadora. Cuando subraya un dato clave para un acceso o búsqueda (fragmentos de tipo Pista), ese dato queda disponible para armar contraseñas o buscar perfiles. |
| Trampas y ruido | En todos los documentos hay fragmentos verdaderos pero irrelevantes o sospechas falsas (fragmentos de tipo Trampa). Subrayarlos no hace perder la partida, pero ocupa espacio del límite y mete ruido si el jugador no los descarta. |

### 6.3 Propuesta 3: Recolección de pistas en el Fichero de cada sospechoso y uso en el Juicio

El cambio más importante que propone el grupo de investigación es reformular cómo se guardan las pistas y cómo se resuelve el Juicio, para que la investigación tenga peso real al momento de acusar:

**1. Fichero organizado por sospechosos:** en lugar de que el Expediente sea una lista única donde cae todo mezclado, el Fichero pasa a tener una ficha individual por cada sospechoso del caso (que se agrega cuando ese personaje aparece en la investigación), además de una pestaña general para los documentos abiertos y datos de contraseñas.

**2. Guardar y asociar pistas al sospechoso:** cada vez que el jugador subraya un indicio relevante —por ejemplo, una amenaza en un correo, una contradicción al interrogarlo por WhatsApp, una publicación sospechosa en una red social, una coartada que lo descarta o un rastro en la cámara 3D—, puede asignar esa pista a la ficha del sospechoso correspondiente. De esa manera, el jugador va construyendo el fichero de cada involucrado con las pruebas a favor o en contra.

**3. Leer el fichero de cada sospechoso en el Juicio:** cuando el jugador toca Desconectar y entra a la pantalla de Juicio, tiene a la vista las fichas de todos los sospechosos del caso y puede abrir y leer el fichero de cada uno con todas las pistas que fue recolectando y subrayando durante la partida.

**4. Marcar al asesino respaldado por las pistas determinadas por el jugador:** para realizar la acusación en el Juicio, el jugador ya no toca solamente el nombre del sospechoso. Debe elegir a quién acusa como culpable y marcar dentro del fichero de ese sospechoso cuáles son las pistas que determinó que prueban su culpabilidad (incluyendo la pista definitiva y las pruebas de contexto o contradicción). Si acusa al culpable real y presenta las pistas correctas de su fichero, gana el caso; si acusa a un inocente o presenta pistas equivocadas o de trampa, la acusación se cae y lleva a un final malo o incompleto.

## 7. Cómo se adaptan nuestras historias al juego con estos cambios

Con esta propuesta, el documento de historias (Prototipos de Historias de Crimen) se actualiza para combinar lo mejor del juego actual con los tres cambios del grupo de investigación:

| Parte del caso | Cómo queda en el documento de historias actualizado |
|---|---|
| Inicio y escritorio | Cada caso arranca con el mensaje de presentación en pantalla y da paso al escritorio de esa computadora (con sus carpetas, archivos, Papelera y accesos protegidos con contraseña) hasta que el jugador decide tocar Apagar > Desconectar. |
| Navegador y sitios web | Se mantienen todos los sitios web de los seis casos (Gateros del Oeste, Barrio, Chusmeo, Encontremos a Tomi, FrostCloud, Hotel Mirador, Opiná, Laburantes, Instituto San Martín, Radio Vecina, Micrófono Abierto, Lienzo y FeriArte) dentro del Navegador del escritorio. |
| WhatsApp e interrogatorios | Cada caso incorpora contactos en WhatsApp con historial previo y preguntas seleccionables de interrogatorio, con fragmentos subrayables en las respuestas para atrapar contradicciones o confirmar coartadas. |
| Cámara 3D y Correo | Todos los casos conservan su cámara 3D interactiva (izquierda, centro, derecha, abajo) y su bandeja de correo electrónico con fragmentos subrayables. |
| Subrayado y Fichero por sospechoso | Se mantiene el marcado de fragmentos [L], [P], [C], [T] y [D] con límite de 3 a 5 por documento, indicando cómo se suman los sospechosos al Fichero y qué pistas van a la ficha de cada uno. |
| Juicio con Fichero | En el cierre de cada caso se detalla qué contiene el fichero de cada sospechoso al llegar al Juicio, qué pistas descartan a los inocentes y qué combinación de culpable + pistas de su fichero (con la pista definitiva [D]) resuelve el juicio. |
