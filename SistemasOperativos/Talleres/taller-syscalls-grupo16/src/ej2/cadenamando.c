/*
 * SSOO - La Cadena de Mando (template)
 *
 * Uso: ./bin/cadenamando N K J   (o: make run-ej2 N=4 K=5 J=1)
 *   N: cantidad de hijos a crear (1 <= N < 10)
 *   K: cantidad de rondas (K > 0)
 *   J: numero maldito (0 <= J < N)
 *
 * Formato de salida esperado (no lo cambies, la corrección automática
 * depende de esto):
 *
 *   HIJO <id> PID <pid> ULTIMAS_PALABRAS mando_total=<valor>
 *   SOBREVIVIENTE <id> PID <pid>
 *   PADRE mando_total=<valor>
 *
 * Restricciones:
 *   - Solo señales y llamadas de gestión de procesos (fork, la
 *     familia de wait, kill, pause, etc). Nada de pipes, memoria
 *     compartida ni sockets.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <time.h>
#include <signal.h>

#define MAX_N 10

/* ---------------------------------------------------------------------
 * TODO 1: Declarar la(s) variable(s) global(es) que van a representar
 * la cuenta de pases del mando (una en el padre, y una por cada hijo,
 * ya que cada proceso tiene su propia copia desde el fork()).
 *
 * Pensá: ¿qué la va a leer? ¿qué la va a escribir? ¿desde dónde
 * (flujo normal del programa, o un manejador de señal)?
 *
 * ------------------------------------------------------------------ */


int mando = 0;

/* TODO 2: variables globales que necesite el padre para llevar el
 * estado del juego: PIDs de los hijos, quién sigue vivo, a quién le
 * toca el mando ahora, cuántas rondas van, etc.
 */
static pid_t pids[MAX_N];
int ronda_actual = 0;
int mando_actual = 0;
int sobrevivientes;
/* flags */
int mando_recibido = 0;
int paso_mando = 0;
int hijo_termino = 0;


static int N, K, J;

/* ---------------------------------------------------------------------
 * Manejadores de señal.
 *
 * Recordá: dentro de un manejador sólo podés usar funciones
 * async-signal-safe (nada de printf). Si necesitás "avisar" algo al
 * resto del programa, la forma habitual es levantar una bandera y
 * procesarla fuera del handler.
 * ------------------------------------------------------------------ */

static void manejador_mando_recibido(int sig) {
    (void) sig;
    /* TODO 3 (hijo): marcar que llegó el mando (sólo levantar un
     * flag acá; el trabajo real -sortear el número, decidir si
     * termina o sigue- se hace en el loop principal del hijo). */
    mando_recibido = 1;
}

static void manejador_alguien_paso(int sig) {
    (void) sig;
    /* TODO 4 (padre): un hijo avisó que quiere pasar el mando.
     * ¿Qué es lo mínimo que hay que hacer acá adentro, y qué es mejor
     * dejar para el loop principal del padre? */
     paso_mando = 1;
}

static void manejador_hijo_termino(int sig) {
    (void) sig;
    /* TODO 5 (padre): un hijo terminó y el padre fue notificado por señal.
     * Ojo: esta señal no encola. Si reapeás con un único wait, ¿qué puede pasar
     * si mueren dos hijos casi al mismo tiempo (por ejemplo, cuando el
     * padre manda SIGKILL a varios sobrevivientes juntos al final)?
     * ¿Hace falta hacer el reapeo real acá adentro, o alcanza con que
     * este handler haga que pause() se despierte? */
     hijo_termino = 1;
}

/* ---------------------------------------------------------------------
 * Lógica del hijo
 * ------------------------------------------------------------------ */

static void correr_hijo(int id) {
    /* TODO 6: sembrar el generador de números aleatorios. Pensá bien
     * en qué momento hay que hacer esto (antes o después del fork?) y
     * con qué semilla, para que cada hijo saque números distintos. */
    srand(time(NULL)^getpid());
    /* TODO 7: instalar el/los manejador(es) de señal que necesite este
     * proceso hijo (con signal(), no con sigaction). */
    signal(SIGUSR1, manejador_mando_recibido);

    for (;;) {
        while (mando_recibido == 0){
            pause();
        }
        
        mando_recibido = 0;
        mando_actual = id;

        /* TODO 8: si llegó el mando (ver bandera de TODO 3):
         *   - incrementar la copia local de la cuenta de pases
         *   - sortear un numero entre 0 y N-1
         *   - si es el numero maldito J: imprimir las ultimas palabras
         *     con el formato pedido y terminar (exit) usando el propio
         *     id como codigo de salida
         *   - si no: avisarle al padre que hay que pasar el mando
         *     (¿con qué señal? ¿a quién hay que mandársela?), y volver
         *     a esperar
         */
         mando++;
         int numero = rand() % N;
         if(numero == J){
            //Hijo muere
            printf("HIJO %d PID %d ULTIMAS_PALABRAS mando_total=%d\n", id, getpid(), mando);
            fflush(stdout);
            //kill(getppid(), SIGCHLD);
            exit(id);
         } else {
            //Hijo vive
            kill(getppid(), SIGUSR2);
         }
    }
}

/* ---------------------------------------------------------------------
 * Lógica del padre
 * ------------------------------------------------------------------ */

static int validar_parametros(int argc, char **argv) {
    if (argc != 4) {
        fprintf(stderr, "uso: %s N K J\n", argv[0]);
        return -1;
    }
    N = atoi(argv[1]);
    K = atoi(argv[2]);
    J = atoi(argv[3]);
    if (N <= 0 || N >= MAX_N) {
        fprintf(stderr, "N debe ser mayor a 0 y menor a %d\n", MAX_N);
        return -1;
    }
    if (K <= 0) {
        fprintf(stderr, "K debe ser mayor a 0\n");
        return -1;
    }
    if (J < 0 || J >= N) {
        fprintf(stderr, "J debe cumplir 0 <= J < N\n");
        return -1;
    }
    return 0;
}

int main(int argc, char **argv) {
    if (validar_parametros(argc, argv) != 0) {
        return 1;
    }

    /* TODO 9: instalar en el padre los manejadores de señal que
     * necesite (¿cuáles señales le van a llegar al padre a lo largo
     * del juego?). */

    signal(SIGUSR2, manejador_alguien_paso);

    signal(SIGCHLD, manejador_hijo_termino);

    for (int i = 0; i < N; i++) {
        pid_t pid = fork();
        if (pid < 0) {
            perror("fork");
            /* TODO: decidir qué hacer si falla un fork a mitad de
             * camino (¿matar a los ya creados? Sí) */
            for(int h = 0; h < i; h++){
                kill(pids[h], SIGKILL);
                waitpid(pids[h], NULL, 0);
            }
            return 1;
        }
        if (pid == 0) {
            correr_hijo(i);
            _exit(1); /* correr_hijo nunca deberia retornar */
        }
        pids[i] = pid;
    }

    //usleep(100000);

    /* TODO 10: arrancar el juego (¿quién tiene el mando al empezar la
     * primera ronda?), y despues loopear esperando señales (pause())
     * hasta cubrir las K rondas o quedar un solo sobreviviente.
     *
     * En cada despertar conviene, sin asumir nada sobre cuántas
     * señales concretas llegaron, revisar el estado real de los
     * hijos (pista: la familia de wait con WNOHANG en loop). */

int sobrevivientes = N;
    int ronda_actual = 0;
    int mando_actual = 0;
    int mando_por_ronda = 0;

    while (ronda_actual < K && (N == 1 ? sobrevivientes > 0 : sobrevivientes > 1)) {
        paso_mando = 0;
        hijo_termino = 0;

        kill(pids[mando_actual], SIGUSR1);
        mando++;

        while (paso_mando == 0 && hijo_termino == 0) {
            pause();
        }

        if (hijo_termino) {
            pid_t muerto;
            while ((muerto = waitpid(-1, NULL, WNOHANG)) > 0) {
                for (int k = 0; k < N; k++) {
                    if (pids[k] == muerto) {
                        pids[k] = 0;
                        sobrevivientes--;
                        break;
                    }
                }
            }
        }

        if (N == 1 ? sobrevivientes == 0 : sobrevivientes <= 1) {
            break;
        }

        mando_por_ronda++;
        if (mando_por_ronda >= sobrevivientes) {
            ronda_actual++;
            mando_por_ronda = 0;
        }

        int indice = (mando_actual + 1) % N;
        while (pids[indice] == 0) {
            indice = (indice + 1) % N;
        }
        mando_actual = indice;
    }

    /* TODO 11: al terminar, imprimir los sobrevivientes (formato
     * pedido), mandarles SIGKILL a los que queden vivos, reapearlos
     * (¡que no queden zombies!), e imprimir la cuenta final del
     * padre. */
    
    for(int i = 0; i < N; i++){
        if(pids[i] != 0){
            printf("SOBREVIVIENTE %d PID %d\n", i, pids[i]);
            kill(pids[i], SIGKILL);
            waitpid(pids[i], NULL, 0); // Espero a que el hijo muera 
        }
    }
    fflush(stdout); // (!)

    //while(wait(NULL) > 0){} // Espero a todos los hijos al mismo tiempo (está bien de ambas maneras)
    printf("PADRE mando_total=%d\n", mando);
    fflush(stdout);

    return 0;
}
