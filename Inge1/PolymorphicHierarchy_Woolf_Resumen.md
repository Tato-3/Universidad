## Polymorphic Hierarchy, Wolf - Resumen

### Reutilizar las descripciones de los metodos

Aca basicamente menciona que cuando usa metodos polimorficos como *print on:* en vez de comentar lo que hacer el metodo, pone el comentario "See superimplementor". Es la manera de decir que, el metodo hace lo mismo que la implementacion original. Y otra pista de lo que hace es que usar el protocolo.

### Una definicion de un implementador

Mencinoa que hay solo una descripcion y es en el metodo en la superclase que define la jerarquia. Este metodo solo devuelve self o subclassResponsibility, o una implementacion default que no genera problemas en las subclases. Aunque el metodo sea "inutil", define el *que* del metodo. 

### La Anatomia de la Descripcion de un Metodo

Aca basicamente menciona dos maneras de poner una descripcion a los metodos. Los metodos setter y getter no les pone enfasis ya que con el nombre del metodo se entiende lo que hace. Y que cuando tiene lineas de codigo que no pueden ser entendibles, lo encapsula en un metodo con un nombre muy descriptivo.

### Proposito y detalles de las Implementacion

Siguiendo con lo de antes, aca menciona otra manera. Divide la descripcion del metodo en dos partes, la parte del proposito y la de los detalles de la implementacion.

Proposito: Explica lo que hace el metodo. Ejemp: “If you send this message to this object, here’s what’ll happen. This method will...”. El proposito de un metodo es reusable, por eso lo documenta en el meotodo mas arriba de la jerarquia.

Detalles: A comparacion con el anterior, los detalles no son reusables. Porque si pasa esto, seria codigo repetido.

Luego menciona, que el proposito seria el *que* del metodo y los detalles serian el *como*. Como mencionamos antes, el que debe ser igual para toda la jerarquia, caso contrario con el como.

### Reutilizacion de la Descripcion para Polimorfismo

El pensaba que cualquier cosa que tenian en comun entre dos clases era coincidencia. Y la manera de como seleccionaba la superclase, era ver quien podia heredar mas cosas de gratis. No creaba jerarquias, sino grupo de clases. Now I can’t seem to think about a class without also needing to understand its superclasse (No sabia como traducirlo). Menciona que tratar de entender una clase sin su superclase es como escuchar un chiste privado sin saber el contexto. Ya que la superclase sabe que tiene que hacer pero no el como. Ya que las subclases lo hacen.

(Preguntar porque las superclases tambien saben el como a veces. Entiendo lo benefisioso pero siento una contradiccion)

### Proposito del Polimorfismo

Cuando todas las implementaciones en una jerarquia tienen el mismo proposito, son polimorficos. Cuando todos los metodos que las subclases implementan son polimorficas con sus versiones heredadas, la heredicion es polimorfica. Esto significa que un objeto colaborador puede usar una instancia de la jerarquia asi de facil como otra instancia. Porque las instancia se comportan iguales.

### Definiendo Polimorfismo

La definicion es muy extensa. La def que el aprendio fue que dos metodos son polimorficos si sus nombres son el mismo. Pero esto no es siempre cierto. Para que dos metodos sean polimorficos, no solo tienen que tener el mismo nombre, sino que se deben comportar de misma manera. 

Ambos metodos deberian aceptar los mismos metodos y producir los mismos efectos secuandarios, tal como cambiar el estado del objeto recibido de la misma forma. A su vez, deben devolver el mismo tipo. Muchas veces las clases no comparten siempre la misma interfaz, pero comparten un *core*. Y siempre y cuando, un colaborador use solo la interfaz del core puede usar una instacioa de una clase como de otra.

### Haciendo una Jerarquia Polimorfica

Cuando en distintas clases implementa el mismo metodo, piensa que esta faltando un "superimplementor". Y como no quiere codigo repetido ni nada por el esitlo, crea un superimplementor. Pero a veces se encuentre que no hay superclases para poner el superimplementor. Y no piensa poner un metodo asi en la clase Object o algo por el estilo, por lo que menciona que, si dos metodos son realmente polimorficos, entonces sus clases tienen que ser polirmorficas. Por lo que crea, una clase de abstraccion que describe el comportamiento polimorfico.

### Patron Template Class

La clase de abstraccion que uso para hacer la jerarquia polimorfica es llamado Template Class, este es un patron que crea jerarquias polimorficas. Esta clase, define la interfaz de un metodo mientras que lo que hace lo hacen las subclases.





  
