!classDefinition: #Motor category: #'3.Replace-if-Type+State'!
Object subclass: #Motor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motor methodsFor: 'on/off' stamp: 'TM 4/7/2025 12:35:16'!
turnOff
	MotorOff new.! !

!Motor methodsFor: 'on/off' stamp: 'TM 4/7/2025 12:35:09'!
turnOn
	MotorOn new.! !


!Motor methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 12:46:15'!
accelerate: aVehicle

	self subclassResponsibility.
	

	! !


!classDefinition: #MotorOff category: #'3.Replace-if-Type+State'!
Motor subclass: #MotorOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!MotorOff methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 12:48:32'!
accelerate: aVehicle

	aVehicle acelerarMotorOff.
	! !


!classDefinition: #MotorOn category: #'3.Replace-if-Type+State'!
Motor subclass: #MotorOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!MotorOn methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 12:48:11'!
accelerate: aVehicle

	aVehicle acelerarMotorOn.
	! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'motorEstado speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'TM 4/7/2025 12:43:11'!
initialize

	speed := 0 * kilometer / hour.
! !


!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 12:45:32'!
accelerate

	motorEstado accelerate: self.
		
	! !

!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 12:51:04'!
acelerarMotorOff

	self error: self canNotAccelerateErrorMessage.! !

!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 12:53:14'!
acelerarMotorOn

	self subclassResponsibility .! !


!Vehicle methodsFor: 'on/off' stamp: 'TM 4/7/2025 12:44:07'!
turnOff

	motorEstado := MotorOff new.! !

!Vehicle methodsFor: 'on/off' stamp: 'TM 4/7/2025 12:43:57'!
turnOn

	motorEstado := MotorOn new.! !


!Vehicle methodsFor: 'error messages' stamp: 'TM 4/7/2025 12:56:55'!
canNotAccelerateErrorMessage

	self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !


!classDefinition: #Helicoptero category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicoptero
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicoptero methodsFor: 'move' stamp: 'TM 4/7/2025 12:54:51'!
acelerarMotorOn

	speed := speed + (10 * kilometer / hour).
			altitude := altitude + (5 * meter).! !


!Helicoptero methodsFor: 'initialization' stamp: 'TM 4/7/2025 12:53:54'!
initialize
	super initialize.
	altitude := 0*meter .! !


!Helicoptero methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 12:56:18'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'.! !


!classDefinition: #Moto category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Moto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Moto methodsFor: 'move' stamp: 'TM 4/7/2025 12:54:58'!
acelerarMotorOn
	speed := speed + (20 * kilometer / hour).! !


!Moto methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 12:56:47'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'.! !
