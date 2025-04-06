!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'TM 4/6/2025 17:08:24'!
initialize

	AutoOff new.
	speed := 0 * kilometer / hour! !


!Automobile methodsFor: 'on/off' stamp: 'TM 4/6/2025 17:07:28'!
turnOff

	AutoOff new.! !

!Automobile methodsFor: 'on/off' stamp: 'TM 4/6/2025 17:07:15'!
turnOn

	AutoOn new.! !


!Automobile methodsFor: 'move' stamp: 'TM 4/6/2025 17:02:50'!
accelerate
		
	self subclassResponsibility.
	! !


!classDefinition: #AutoOff category: #'2.Replace-if-State'!
Automobile subclass: #AutoOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutoOff methodsFor: 'move' stamp: 'TM 4/6/2025 17:02:05'!
accelerate
	self error: 'Can not accelerate when turned off'.! !


!classDefinition: #AutoOn category: #'2.Replace-if-State'!
Automobile subclass: #AutoOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!AutoOn methodsFor: 'move' stamp: 'TM 4/6/2025 17:02:37'!
accelerate
	speed := speed + (10 * kilometer / hour).! !
