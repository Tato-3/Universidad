2.a- En este codigo nos encontramos con un deadlock, lo que pasa es que si el proceso tipo 2 ejecuta primero mutex.wait(), esto ocasiona que el proceso de tipo 2 se quede esperando en jobs.wait() y que el proceso tipo 1 se quede esperando en mutex.wait(). Luego nos encontramos con un problema en el buffer, en este codigo se pueden agregar mas de n trabajos, cuando esto no deberia estar pasando. Correcion:

mutex = sem_init(1);
jobs = sem_init(0);
disponible = sem_init(N);
contador = 0;

//Proceso Tipo 1
trabajo = esperarPromptUsuario();
disponible.wait();
mutex.wait();
cola.add(trabajo);
mutex.signal();
jobs.signal();

//Proceso Tipo 2
jobs.wait();
mutex.wait();
trabajo = cola.pop()
mutex.signal();
disponible.signal();
enviarResultado(trabajo);

2.b-
Para que luego de k trabajos recien se envien vamos a usar un contador y dos semaforos:
barrera1 = sem_init(0)
barrera2 = sem_init(1)

//Proceso Tipo 2
jobs.wait();
mutex.wait();
trabajo = cola.pop()
contador++;
disponible.signal();
if(contador == k){
	barrera2.wait();
	barrera1.signal();
}
mutex.signal();

barrera1.wait();
barrera1.signal();

mutex.wait();
contador--;
if(contador == 0){
	barrera1.wait();
	barrera2.signal();
}
mutex.signal();

barrera2.wait();
barrera2.signal();

enviarResultado(trabajo);
