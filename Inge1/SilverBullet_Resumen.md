## Silver Bullet, Frederick P - Resumen

No sólo no hay balas de plata a la vista, sino que la misma naturaleza del software impide que las haya ningún invento de los que mejoraron la productividad, fiabilidad y simplicidad en el hardware, como la electrónica, los transistores y las altas escalas de integración (VLSI) harán lo mismo por el software. No podemos experar ver doblarse las prestaciones cada dos años.

La esencia de una entidad software es una construcción de conceptos entrelazados: conjuntos de datos, relaciones entre los datos, algoritmos y llamadas a funciones. Esta esencia nos indica que uno de estos conceptos abstractos construidos tiene muchas representaciones. Sin embargo es muy preciso y muy detallado.

Creo que la parte más dura de construir software es la especificación, diseño y prueba de este concepto construido, no el trabajo de representarlo y comprobar la fidelidad de la representación. Por lo que hacer software siempre sera algo duro. No hay ninguna bala de plata.

### Propiedades inherentes a la esencia de los sistemas de software:
#### Las dificultades esenciales
**Complejidad**: 

Las entidades del software son mas complejos debido a su tamano, en comparaciona a otra construccion humana, debido que no hay dos partes iguales. Si es que lo hay, entonces podemos unir ambas entidades y hacerla una. 
La complejidad del software es una propiedad esencial, no accidental. Además, una descripción de una entidad de software que elimine su complejidad a menudo elimina su esencia.

 Muchos de los problemas clásicos del desarrollo de software derivan de esta complejidad esencial y su incremento no lineal con el tamaño.De la complejidad procede la dificultad de comunicación entre los miembros del equipo, que conduce a productos defectuosos, sobrecostes y retrasos. De la complejidad procede la dificultad de enumerar, y aún más comprender, todos los posibles estados del programa, y de hay procede la falta de fiabilidad. De la complejidad de la función procede la dificultad de llamar a la función, lo que hace difícil de usar al programa. De la complejidad de la estructura procede la dificultad en extender el programa para realizar nuevas funciones sin crear efectos laterales. De la complejidad de la estructura proceden los estados no previstos que se convierten en agujeros en la seguridad.

 De la complejidad no sólo se derivan problemas técnicos, sino también problemas de gestión. Hace difícil tener una visión de conjunto, impidiendo la integridad conceptual. Dificulta encontrar y controlar todos los cabos sueltos. Crea los enormes agobios en aprender y comprender que lleva al personal hacia el desastre.

 **Conformidad:**

In software engineering, much of the complexity is arbitrary, meaning it doesn’t come from natural laws but from human-made systems and interfaces. Software engineers often have to follow rules that were created by different people or organizations, and these rules don’t always align. This makes the job harder because there’s no single, simple explanation or design that applies universally.

**Variabilidad:**

El software esta sometido a constantes presiones de cambio, a diferencia de productos manufacturados como autos o edificios, que rara vez se modifican tras su fabricación. Las razones son, 

Adaptación funcional: el software se ajusta a las funciones que cumple, y estas son las que más cambian. Además, al ser “puro pensamiento”, resulta mucho más fácil de modificar.

Éxito y extensión: cuando un programa funciona bien, los usuarios buscan ampliarlo para nuevas aplicaciones, más allá de su diseño original.

Supervivencia tecnológica: el software debe actualizarse para seguir siendo compatible con nuevo hardware y entornos.

En conclusión, el software cambia porque vive en un entorno cultural y tecnológico dinámico (usuarios, leyes, aplicaciones y hardware), lo que lo obliga a evolucionar constantemente.

**Invisibilidad:**

software es invisible e imposibilita una representación visual única, a diferencia de edificios, piezas mecánicas o moléculas, que pueden abstraerse en planos o modelos geométricos.

Las razones principales son:

El software no es espacial, sino lógico, y al intentar representarlo aparecen múltiples gráficos superpuestos (flujo de control, datos, dependencias, tiempos, nombres). Estas estructuras rara vez son jerárquicas ni planas, lo que dificulta su simplificación. Aunque se han hecho avances para limitar la complejidad, la invisualizabilidad es inherente al software.

En conclusión, esta invisibilidad complica tanto el razonamiento individual como la comunicación colectiva sobre su diseño y el software es invisible porque no existe una representación visual única, clara y completa de su estructura, lo que dificulta tanto pensarlo como comunicarlo.

### Los avances del pasado solucionaron dificultades accidentales

**Lenguajes de alto nivel**

Los lenguajes de alto nivel han sido el mayor avance en la historia del software en términos de productividad, confiabilidad y simplicidad. Se estima que aumentaron la productividad al menos cinco veces, además de mejorar la claridad y la facilidad de uso respecto al ensamblador.

La razón de este gran salto es que liberaron al programador de la complejidad accidental. Antes había que trabajar directamente con bits, registros, condiciones y saltos; ahora se puede pensar en operaciones, estructuras de datos, tipos y secuencias, es decir, en conceptos mucho más cercanos a cómo concebimos los programas en abstracto. Así, un lenguaje de alto nivel elimina un nivel de dificultad que nunca fue parte esencial del problema que el software debía resolver.

Sin embargo, estos lenguajes tienen un límite natural. Solo pueden ofrecer construcciones que el programador ya pueda imaginar en su modelo abstracto del programa. Aunque con el tiempo hemos refinado nuestras ideas sobre tipos de datos y estructuras, ese progreso se ha vuelto cada vez más lento. Además, cuando un lenguaje se hace demasiado sofisticado y acumula características muy especializadas, esas mismas complejidades terminan siendo una carga, porque la mayoría de los usuarios casi nunca las utiliza.

En resumen, los lenguajes de alto nivel eliminaron gran parte de la complejidad accidental y marcaron un hito en la programación. Pero ya se acercan a su techo de desarrollo, y no logran resolver las dificultades esenciales que siguen estando en la naturaleza misma del software.

**Time-Sharing**

Antes, al compilar y ejecutar un programa en batch, pasaba mucho tiempo entre escribir el código y ver el resultado. Durante ese tiempo, el programador olvidaba detalles o incluso la lógica completa de lo que estaba haciendo. Esto hacía que la gestión de la complejidad del software fuera más difícil.

El time-sharing solucionó esta dificultad accidental, porque permite que el programador vea los resultados casi inmediatamente, manteniendo la continuidad del pensamiento y ayudando a comprender mejor sistemas complejos. Sin embargo, esta ventaja tiene un límite: una vez que el tiempo de respuesta se hace tan rápido que el humano no lo percibe (unos 100 milisegundos), reducirlo más no aporta beneficios adicionales.

 **Unified programming environments**

Estos atacan dificultades accidentales relacionadas con el uso conjunto de programas. Antes, integrar distintos programas era complicado: cada uno podía tener formatos de archivo distintos, bibliotecas separadas y formas incompatibles de comunicarse. Los entornos unificados resolvieron esto al ofrecer bibliotecas integradas, formatos de archivo estandarizados y herramientas compatibles, lo que permitía que los programas se llamaran y alimentaran entre sí de manera mucho más sencilla.

Este avance también impulsó la creación de herramientas complementarias (toolbenches), porque cualquier nueva herramienta podía aplicarse fácilmente a todos los programas gracias a los formatos y estándares unificados.

En resumen, los entornos unificados mejoraron la productividad al reducir dificultades accidentales de integración y uso de programas, aunque, como los otros avances históricos, no eliminan las dificultades esenciales del software.

### Hopes for the Silver

Habla sobre un lenguaje de programacion, Ada. Basicamente habla sobre como tambien abarca como el diseno moderno y la modularizacion. Menciona que la filosofia de Ada es mas una ventaja que el propio lenguaje, por su filosofia sobre la modularizacion sobre la abstraccion de tipos de datos y estructuras jerarquicas. 

Aunque sea muy bueno, no sigue siendo una bala de plata, al final y al cabo sigue siendo otro lenguaje de alto nivel.

**Programacion Orientada a Objetos**

Brooks distingue dos ideas dentro de la POO: tipos abstractos de datos y tipos jerárquicos o clases. Los tipos abstractos permiten definir un objeto por su nombre, sus valores posibles y las operaciones válidas, sin exponer cómo se almacena internamente. Los tipos jerárquicos permiten crear interfaces generales que se refinan en subtipos, como las clases de Simula-67. Ambos conceptos son independientes y cada uno representa un avance real en la construcción de software.

Lo que logran estos conceptos es eliminar dificultades accidentales de alto nivel: permiten que el diseñador exprese la esencia del diseño sin tener que lidiar con detalles sintácticos que no aportan información. Esto facilita una expresión más clara y directa del diseño.

Sin embargo, Brooks enfatiza que esto solo ataca las dificultades accidentales. La complejidad esencial del software —la dificultad inherente al problema que se está resolviendo— permanece intacta. Por eso, los beneficios de POO son limitados: solo harían un cambio dramático si la mayoría del trabajo de programación fuera realmente lidiar con detalles de tipo y sintaxis, lo cual no suele ser el caso.

**Inteligencia Artificial**

Brooks distingue dos definiciones de IA: la primera (AI-1) es el uso de computadoras para resolver problemas que antes solo podían resolverse con inteligencia humana. La segunda (AI-2) se refiere a técnicas específicas, como la programación heurística o basada en reglas, que intentan replicar el modo en que los expertos humanos resuelven problemas.

El punto clave es que la mayoría de estas técnicas son muy específicas de cada problema. Por ejemplo, los métodos para reconocimiento de voz son distintos de los de reconocimiento de imágenes, y ambos son distintos de los usados en sistemas expertos. Esto hace difícil transferir los avances de un área a otra o generalizarlos para mejorar la programación en general.

Brooks enfatiza que el verdadero desafío del software no es escribir el código, sino decidir qué debe hacer el programa. La IA puede facilitar la expresión de ideas, pero no resuelve la complejidad esencial de diseñar correctamente un software. Por eso, aunque se espere que la IA genere mejoras radicales, Brooks considera que sus contribuciones serán, como mucho, marginales en términos de productividad o calidad general del software.

**Sistemas Expertos**

Un sistema experto es un programa con un motor de inferencia general y una base de reglas, capaz de tomar datos y suposiciones, deducir consecuencias lógicas y ofrecer conclusiones, explicando su razonamiento al usuario.

La gran ventaja de los sistemas expertos es que separa la complejidad de la aplicación de la programación misma. La tecnología del motor de inferencia se desarrolla de manera independiente y luego se aplica a distintas tareas, mientras que los elementos específicos de la aplicación se codifican en la base de reglas de forma uniforme. Esto permite gestionar mejor la complejidad del software y facilita herramientas para crear, modificar, probar y documentar las reglas.

En el contexto del desarrollo de software, los sistemas expertos pueden ser usados de muchas formas: sugiriendo reglas de interfaz, aconsejando estrategias de prueba, recordando frecuencias de errores, ofreciendo pistas de optimización, etc. Por ejemplo, un “asesor de pruebas” podría inicialmente dar sugerencias generales sobre posibles errores, y a medida que se enriquece su base de reglas, dar consejos cada vez más específicos y útiles para la depuración.

Brooks destaca que el trabajo de generar estas reglas de diagnóstico es en gran medida el mismo que se haría para diseñar casos de prueba, y si se hace de manera general y estructurada, puede reducir el esfuerzo total de prueba y mantenimiento. Además, la contribución más importante de los sistemas expertos es poner la experiencia de los mejores programadores al alcance de los menos experimentados, acortando la brecha entre la práctica promedio y la óptima en ingeniería de software.

**Programacion "Automatica"**

La programación automática se refiere a generar un programa directamente a partir de la especificación del problema. Sin embargo, Parnas señala que muchas veces este término se usa más como palabra de moda que con un contenido técnico real: en la práctica, siempre ha sido programación con un lenguaje de nivel más alto que el disponible en ese momento. En la mayoría de los casos, lo que se especifica no es el problema en sí, sino el método de solución.

Hay excepciones donde la programación automática funciona bien, por ejemplo en programas de ordenamiento o en sistemas de integración de ecuaciones diferenciales. En estos casos, el sistema puede evaluar parámetros, seleccionar métodos de una biblioteca y generar automáticamente los programas. Estas aplicaciones funcionan porque:

- Los problemas se caracterizan por pocos parámetros.

- Existen muchas soluciones conocidas que pueden almacenarse en bibliotecas.

- Hay reglas claras para elegir la técnica adecuada según los parámetros.

Brooks enfatiza que estas condiciones son raras en el software general, donde los problemas son más complejos y variados. Por eso, es difícil imaginar cómo la programación automática podría generalizarse para producir un avance revolucionario en la mayoría de los sistemas de software.

**Verficacion del Programa**

Brooks señala que, aunque la verificación formal es un concepto poderoso y útil, especialmente en sistemas críticos como núcleos de sistemas operativos seguros, no es una solución mágica. Verificar un programa requiere tanto trabajo que solo unos pocos programas sustanciales han sido completamente verificados. Además, la verificación no garantiza programas sin errores, porque incluso las pruebas matemáticas pueden contener fallas. Por lo tanto, aunque la verificación pueda reducir algo de la carga de pruebas, no puede eliminarla.

El punto más importante es que la verificación solo demuestra que un programa cumple con su especificación. Y en la práctica, lo más difícil del software no es escribir el código, sino llegar a una especificación completa y consistente. Gran parte de la esencia de construir software consiste precisamente en depurar y refinar la especificación, tarea que la verificación formal no puede reemplazar.

**Ambiente y Herramientas**

Brooks señala que los grandes problemas que los entornos de programación podían resolver —como sistemas de archivos jerárquicos, formatos de archivo uniformes e interfaces de programa estandarizadas, así como herramientas generales— ya han sido atacados y en buena medida resueltos. Nuevos desarrollos, como editores inteligentes específicos para un lenguaje, aún no son muy utilizados y, en el mejor de los casos, solo eliminan errores sintácticos o semánticos simples.

Un área con potencial todavía no completamente explotada es el uso de bases de datos integradas para gestionar la enorme cantidad de detalles que un programador debe recordar y mantener actualizados, especialmente en equipos que trabajan sobre un mismo sistema.

Sin embargo, Brooks enfatiza que, por la naturaleza de estas mejoras, los beneficios futuros serán marginales. Es decir, aunque valen la pena y pueden mejorar productividad y confiabilidad, no representan un avance revolucionario que elimine las dificultades esenciales del software.

**Estaciones de Trabajo**

Brooks señala que, aunque el aumento de velocidad y memoria de las estaciones de trabajo es bienvenido, no generará mejoras mágicas en la productividad del programador. Hoy en día, las tareas de composición, edición y compilación ya están bien soportadas por las velocidades actuales. Incluso si la máquina fuera diez veces más rápida, el tiempo de reflexión del programador seguiría siendo la actividad dominante.

**Great designers**

Este fragmento enfatiza que la mejora del software depende, sobre todo, de las personas, y no solo de tecnologías o metodologías.

Brooks explica que se puede lograr un buen diseño siguiendo buenas prácticas, y que estas prácticas pueden enseñarse. Esto ha dado lugar a nuevas currículas, literatura y organizaciones como el Software Engineering Institute, que buscan elevar el nivel de práctica de los programadores de pobre a bueno.

Sin embargo, la diferencia entre un buen diseño y un gran diseño no se logra únicamente mediante metodología. Los grandes diseños provienen de grandes diseñadores, porque la construcción de software es un proceso creativo. La metodología puede liberar y potenciar la creatividad, pero no puede generar genialidad donde no existe. Los mejores diseñadores producen estructuras más rápidas, simples, elegantes y con menos esfuerzo, con diferencias que pueden alcanzar un orden de magnitud respecto al promedio.

Brooks da ejemplos históricos: Unix, APL, Pascal, Modula, Smalltalk o Fortran son productos que entusiasmaron a usuarios y provienen de pocas mentes brillantes, mientras que Cobol, PL/I, Algol, MVS/370 o MS-DOS, aunque útiles, no generan la misma admiración.

Por eso, la propuesta central es que cada organización de software debe reconocer que los grandes diseñadores son tan importantes como los grandes gerentes y deben ser igualmente buscados, cultivados y recompensados, no solo con salario sino con reconocimiento, recursos y apoyo técnico.

Algunas estrategias para formar grandes diseñadores incluyen:

- Identificar sistemáticamente a los mejores talentos desde temprano.

- Asignarles un mentor responsable de su desarrollo.

- Diseñar un plan de carrera que combine aprendizaje formal, prácticas con diseñadores destacados, y asignaciones de liderazgo y diseño en solitario.

- Crear oportunidades de interacción y estimulación entre los diseñadores en crecimiento.
