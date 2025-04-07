!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 17:08:00'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := self electricMotorcycle .
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 17:44:48'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := self helicopter .
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 17:45:04'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := self electricMotorcycle .
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:13:51'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := self gasolineMotorcycle .
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:16:20'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := self helicopter .
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:16:31'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := self helicopter .
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:16:43'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := self electricMotorcycle .
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:26:10'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := self gasolineMotorcycle .
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'TM 4/7/2025 19:26:17'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := self helicopter .
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!VehicleTests methodsFor: 'misVehiculos' stamp: 'TM 4/7/2025 17:43:00'!
electricMotorcycle

	^ Motorcycle new initializeWithEngine: Electric new withLocation: City new.! !

!VehicleTests methodsFor: 'misVehiculos' stamp: 'TM 4/7/2025 19:29:23'!
gasolineMotorcycle

	^ Motorcycle new initializeWithEngine: Gasoline new withLocation: OpenRoad new.! !

!VehicleTests methodsFor: 'misVehiculos' stamp: 'TM 4/7/2025 17:44:17'!
helicopter

	^Helicopter new initializeWithEngine: JetFueled new withLocation: Skies new! !


!classDefinition: #Engine category: #'4.Replace-if-Strategy'!
Object subclass: #Engine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Engine methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 16:26:58'!
engineVehicle:  aVehicle

	self subclassResponsibility .! !


!classDefinition: #Electric category: #'4.Replace-if-Strategy'!
Engine subclass: #Electric
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Electric methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:12:37'!
engineVehicle: aVehicle
	
	^ (aVehicle getSpeed + (5 * kilometer / hour)) * 2.! !


!classDefinition: #Gasoline category: #'4.Replace-if-Strategy'!
Engine subclass: #Gasoline
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Gasoline methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:14:34'!
engineVehicle: aVehicle
	
	^ 10 * kilometer / hour.! !


!classDefinition: #JetFueled category: #'4.Replace-if-Strategy'!
Engine subclass: #JetFueled
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!JetFueled methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:15:57'!
engineVehicle: aVehicle
	
	|vehicleSpeed|
	
	vehicleSpeed := aVehicle getSpeed.
	
	^ ((vehicleSpeed amount + 1) ^ 2) * kilometer / hour .! !


!classDefinition: #EngineStatus category: #'4.Replace-if-Strategy'!
Object subclass: #EngineStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineStatus methodsFor: 'move' stamp: 'TM 4/7/2025 14:49:37'!
accelerate: aVehicle

	self subclassResponsibility.! !


!classDefinition: #EngineOff category: #'4.Replace-if-Strategy'!
EngineStatus subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineOff methodsFor: 'move' stamp: 'TM 4/7/2025 14:53:19'!
accelerate: aVehicle

	aVehicle accelerateEngineOff.! !


!classDefinition: #EngineOn category: #'4.Replace-if-Strategy'!
EngineStatus subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineOn methodsFor: 'move' stamp: 'TM 4/7/2025 14:53:09'!
accelerate: aVehicle

	aVehicle accelerateEngineOn.! !


!classDefinition: #Location category: #'4.Replace-if-Strategy'!
Object subclass: #Location
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Location methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 16:48:32'!
locateVehicleUse: aVehicle

	self subclassResponsibility.! !


!classDefinition: #City category: #'4.Replace-if-Strategy'!
Location subclass: #City
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!City methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:24:43'!
limit: vehicleSpeed

	^ (70 * kilometer / hour min: vehicleSpeed).! !

!City methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 16:50:45'!
locateVehicleUse: aVehicle

	aVehicle speedAt: (70 * kilometer / hour min: aVehicle getSpeed).! !


!classDefinition: #OpenRoad category: #'4.Replace-if-Strategy'!
Location subclass: #OpenRoad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!OpenRoad methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:25:36'!
limit: vehicleSpeed

	^130 * kilometer / hour min: vehicleSpeed.! !

!OpenRoad methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 16:50:59'!
locateVehicleUse: aVehicle

	aVehicle speedAt: (130 * kilometer / hour min: aVehicle getSpeed).! !


!classDefinition: #Skies category: #'4.Replace-if-Strategy'!
Location subclass: #Skies
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Skies methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 19:25:48'!
limit: vehicleSpeed

	^500 * kilometer / hour min: vehicleSpeed.! !

!Skies methodsFor: 'as yet unclassified' stamp: 'TM 4/7/2025 16:51:08'!
locateVehicleUse: aVehicle

	aVehicle speedAt: (500 * kilometer / hour min: aVehicle getSpeed).! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy'!
Object subclass: #Vehicle
	instanceVariableNames: 'engineStatus speed engine locate'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Vehicle methodsFor: 'initialization' stamp: 'TM 4/7/2025 17:04:19'!
initializeWithEngine: anEngine withLocation: aLocation
	
	engineStatus := EngineOff.
	speed := 0 * kilometer / hour.
	locate := aLocation.
	engine := anEngine.! !


!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 18:59:19'!
accelerate
	
	engineStatus accelerate: self.! !

!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 14:57:53'!
accelerateEngineOff

	self error: self canNotAccelerateErrorMessage.! !

!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 14:58:36'!
accelerateEngineOn

	self subclassResponsibility.! !

!Vehicle methodsFor: 'move' stamp: 'TM 4/7/2025 15:32:53'!
altitudeAt: anAltitude

	self subclassResponsibility.! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:23:27'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'TM 4/7/2025 15:35:03'!
turnOff

	engineStatus := EngineOff new.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'TM 4/7/2025 15:34:29'!
turnOn

	engineStatus := EngineOn new.! !


!Vehicle methodsFor: 'error messages' stamp: 'TM 4/7/2025 15:20:11'!
canNotAccelerateErrorMessage
	
	self subclassResponsibility.
	! !


!Vehicle methodsFor: 'get' stamp: 'TM 4/7/2025 16:37:23'!
getSpeed

	^speed.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'NR 9/7/2024 08:53:59'!
electricMotorcycle

	^ self new initializeWithType: #Motorcycle engineType: #ElectricEngine andSurroundings: #city

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'NR 9/7/2024 08:53:55'!
gasolineMotorcycle

	^ self new initializeWithType: #Motorcycle engineType: #GasolineEngine andSurroundings: #openRoad! !

!Vehicle class methodsFor: 'instance creation' stamp: 'TM 4/7/2025 14:45:13'!
helicopter

	^ self new initializeWithType: #Helicopter engineType: #JetFueledEngine andSurroundings: #skies! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Helicopter methodsFor: 'move' stamp: 'TM 4/7/2025 19:27:06'!
accelerateEngineOn

	speed := locate limit: (speed + (engine engineVehicle: self)).
	altitude := altitude + (5 * meter).! !

!Helicopter methodsFor: 'move' stamp: 'TM 4/7/2025 15:32:27'!
altitudeAt: anAltitude

	^ altitude = anAltitude! !


!Helicopter methodsFor: 'error' stamp: 'TM 4/7/2025 15:21:30'!
canNotAccelerateErrorMessage

	^'Can not fly when turned off'.! !


!Helicopter methodsFor: 'initialization' stamp: 'TM 4/7/2025 17:06:10'!
initializeWithEngine: anEngine withLocation: aLocation
	
	super initializeWithEngine: anEngine withLocation: aLocation.
	
	altitude := 0.! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Motorcycle methodsFor: 'move' stamp: 'TM 4/7/2025 19:24:19'!
accelerateEngineOn

	speed := locate limit: (speed + (engine engineVehicle: self)).
	! !


!Motorcycle methodsFor: 'error' stamp: 'TM 4/7/2025 15:21:25'!
canNotAccelerateErrorMessage

	^'Can not run when turned off'.! !
