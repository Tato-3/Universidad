1.a: N=16, M=3, P=4

int X[16];
int step = 3;

for(int i = 0; i < 16; i += step){
	if(esPar(i)){
		X[i] = X[i] + 1;
	}else{
		X[16-i] = X[i] + 1;
	}
}

valores i = 0,3,6,9,12,15
Tenemos 4 paginas y como N=16 entonces 
Paginas: P1{0,3}, P2{4,7}, P3{8,11}, P4{12,15} 

 	i 	| 	indices de x 	| paginas
--------------------------------------
	0	|		0 y 0		|	P1				
	3	|		3 y 13		|	P1 y P4
	6	|		6 y 6		|	P2			
	9	|		9 y 5		|	P3 y P2
	12	|		12 y 12		|	P4				
	15	|		15 y 1		|	P4 y P1

Accesos a paginas: P1, P1, P1, P4, P2, P2, P3, P2, P4, P4, P4, P1
