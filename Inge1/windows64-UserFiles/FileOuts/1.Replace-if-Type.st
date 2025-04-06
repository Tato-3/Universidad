!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'type speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'TM 4/6/2025 10:46:25'!
initialize

	speed := 0 * kilometer / hour.
! !

!Vehicle methodsFor: 'initialization' stamp: 'TM 4/6/2025 10:40:08'!
initializeWithType: typeToTake

	type := typeToTake.
	speed := 0 * kilometer / hour.
! !


!Vehicle methodsFor: 'move' stamp: 'TM 4/6/2025 10:36:33'!
accelerate

	^self subclassResponsibility.! !


!classDefinition: #Car category: #'1.Replace-if-Type'!
Vehicle subclass: #Car
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'move' stamp: 'TM 4/6/2025 10:34:55'!
accelerate

	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter).! !


!Helicopter methodsFor: 'as yet unclassified' stamp: 'TM 4/6/2025 10:42:47'!
initialize
	
	altitude := 0*meter .
	
	super initialize.! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'move' stamp: 'TM 4/6/2025 10:46:43'!
accelerate

	speed := speed + (20 * kilometer / hour).! !
