!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 12:24:59'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	self accionAlCliente:  [customerBook addCustomerNamed: 'John Lennon'] 
		enMenosDe: 50.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 12:25:17'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self accionAlCliente:[	customerBook removeCustomerNamed: paulMcCartney.]
		enMenosDe: 100.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:18:26'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	 self 
	       accionAlCliente: [customerBook addCustomerNamed: '']
		fallo: Error 
		confirmarFallo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:18:26'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
	accionAlCliente: [ customerBook removeCustomerNamed: 'Paul McCartney']
		fallo: NotFound 
		confirmarFallo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:42:52'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self clientesEnReserva: customerBook clientesActivos: 0 clientesSuspendidos: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:43:12'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self clientesEnReserva: customerBook clientesActivos: 0 clientesSuspendidos: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:46:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
	accionAlCliente: [ customerBook suspendCustomerNamed: 'George Harrison'.]
		fallo: CantSuspend 
		confirmarFallo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TM 4/2/2025 15:45:52'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
	accionAlCliente: [customerBook suspendCustomerNamed: johnLennon.]
		fallo: CantSuspend 
		confirmarFallo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'TM 4/2/2025 12:24:14'!
accionAlCliente: bloqueFuncionDelCliente enMenosDe: tiempoAComparar 

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	bloqueFuncionDelCliente.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (tiempoAComparar * millisecond )! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'TM 4/2/2025 15:18:26'!
accionAlCliente: bloqueAccionAlCliente fallo: tipoDeError confirmarFallo: bloqueConfirmacionError

	 [bloqueAccionAlCliente value. self fail] on: tipoDeError do: bloqueConfirmacionError.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'TM 4/2/2025 15:41:20'!
clientesEnReserva: customerBook clientesActivos: clientesActivos clientesSuspendidos: clientesSuspendidos

	self assert: clientesActivos equals:  customerBook numberOfActiveCustomers.
	self assert: clientesSuspendidos equals: customerBook numberOfSuspendedCustomers.
	self assert: clientesActivos + clientesSuspendidos equals: customerBook numberOfCustomers.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 17:53:45'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self incluyeClienteNombre: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 17:16:09'!
buscar: aName estadoCliente: estado sinoEsta: bloque

	1 to: estado size do:
	[:index | 
		aName = (estado at: index)
			ifTrue:[
				estado removeAt: index.
				^aName 
			]
	].

	^bloque value.! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 17:54:32'!
incluyeClienteNombre: aName

	^((active includes: aName) or: [suspended includes: aName])! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 12:16:43'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 17:17:04'!
removeCustomerNamed: aName 
 
	self buscar: aName estadoCliente: active sinoEsta: [
		self buscar: aName estadoCliente: suspended sinoEsta:[
			^NotFound signal.].].
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 4/2/2025 17:57:46'!
suspendCustomerNamed: aName 
	
	self buscar: aName estadoCliente: active sinoEsta: [^CantSuspend signal].
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
