1.a-
insumos_llenos = sem(0);
producto_llenos = sem(0);

insumos_vacios = sem(N);
producto_vacios = sem(M);


Fabrica:
insumos_llenos.wait();
producto_vacios.wait();

tomarLoteInsumos();

insumos_vacios.signal();

fabricar();

depositarLoteFabricado();
producto_llenos.signal();

1.b-
Me creo un wait_status tal que:

int wait_status(s){
	if s > 0:
		s = s-1
		return 1
	else:
		return 0
}

while(true){
	esperarLlegadaInsumos();
	if(wait_status(insumos_vacios) > 0){
		agregarInsumosAlDeposito();
		insumos_llenos.signal();
	}else{
		descartar();
	}
}

1.c- Uso lo mismo

while(true){
	esperarVentaDeProducto();

	if(wait_status(producto_llenos) > 0){
		vender();
		producto_vacios.signal();
	}else{
		rechazarPedido();
	}
}
