mutex = sem(1);
limite_ejecuciones = sem(M);
jobs = sem(0);

//Proceso Sensores
limite_ejecuciones.wait();
preprocDataSensor();
limite_ejecuciones.signal();
jobs.signal();

//Proceso Central

for(int i=0;i < N; i++){
	jobs.wait();
}
consolidarDataSensores();
