class_name Pista
extends Resource

## Una pista que el analista anota en el expediente.
## Se puede crear a mano desde codigo (ver Global.anotar) o guardarse
## como .tres dentro de casos/casoN/pistas/ igual que los chats y mails.

## Identificador unico. Sirve para no anotar dos veces la misma pista.
@export var id: String = ""
## Titulo corto, lo que se ve en negrita en el expediente.
@export var titulo: String = ""
## El texto de la pista.
@export_multiline var texto: String = ""
## De donde salio: "WhatsApp", "Gmail", "Camara 2", etc. Opcional.
@export var fuente: String = ""
## Momento en que se anoto. Lo completa Global si queda vacio.
@export var hora: String = ""
