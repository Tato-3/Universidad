!classDefinition: #Cashier category: #'IRobot-Enunciado'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Cashier methodsFor: 'closing buy order' stamp: 'TM 4/10/2025 16:11:49'!
receiveOrder: aRobot
	
	aRobot status closeOrderUsing: self.
! !

!Cashier methodsFor: 'closing buy order' stamp: 'TM 4/10/2025 15:58:16'!
receiveProductsFrom: aRobot
	
	|aTrailer|
	aTrailer  := aRobot trailer.
	self assertTrailerNotEmpty: aTrailer.
	
	^true.! !

!Cashier methodsFor: 'closing buy order' stamp: 'TM 4/10/2025 16:00:03'!
receiveProductsFromMechanicalFailure: aRobot
	
	 aRobot outOfOrder.
	^self receiveProductsFrom: aRobot .! !

!Cashier methodsFor: 'closing buy order' stamp: 'TM 4/10/2025 15:59:01'!
receiveProductsFromNormal: aRobot
	
	^self receiveProductsFrom: aRobot .! !

!Cashier methodsFor: 'closing buy order' stamp: 'TM 4/10/2025 16:01:04'!
receiveProductsFromSensorsFailure: aRobot
	
	 aRobot outOfOrder.
	self signalRobotSensorsFailure .! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'IRobot-Enunciado'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'IRobot-Enunciado'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'IRobot-Enunciado'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'IRobot-Enunciado'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'IRobot-Enunciado'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: #'IRobot-Enunciado'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Robot methodsFor: 'actions' stamp: 'TM 4/10/2025 16:09:17'!
closeOrderUsing: aCashier
	
	 ^status closeOrderUsing: aCashier.
	
! !

!Robot methodsFor: 'actions' stamp: 'TM 4/10/2025 16:12:55'!
take: aProduct

	status take: aProduct fromTrailer: trailer .
	
! !


!Robot methodsFor: 'status' stamp: 'TM 4/10/2025 13:47:01'!
outOfOrder
	
	
	status := OutOfOrder new initialize: self.
! !

!Robot methodsFor: 'status' stamp: 'TM 4/10/2025 13:47:10'!
withMechanicalFailure

	status := MechanicalFailure new initialize: self.
! !

!Robot methodsFor: 'status' stamp: 'TM 4/10/2025 13:47:15'!
withSensorsFailure

	status := SensorsFailure new initialize: self.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/4/2020 18:35:21'!
status

	^ status
! !

!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'TM 4/10/2025 13:39:29'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := WorkingNormal new initialize: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'IRobot-Enunciado'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: #'IRobot-Enunciado'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotStatus methodsFor: 'initialization' stamp: 'TM 4/10/2025 13:39:45'!
initialize: aRobot

	robot := aRobot .
! !


!RobotStatus methodsFor: 'actions' stamp: 'TM 4/10/2025 12:07:21'!
closeOrderUsing: aCashier

	self subclassResponsibility. ! !

!RobotStatus methodsFor: 'actions' stamp: 'TM 4/10/2025 13:54:24'!
take: aProduct fromTrailer: aTrailer

	self subclassResponsibility. ! !


!classDefinition: #MechanicalFailure category: #'IRobot-Enunciado'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!MechanicalFailure methodsFor: 'actions' stamp: 'TM 4/10/2025 16:03:57'!
closeOrderUsing: aCashier

	^aCashier receiveProductsFromMechanicalFailure: robot! !

!MechanicalFailure methodsFor: 'actions' stamp: 'TM 4/10/2025 13:54:00'!
take: aProduct fromTrailer: aTrailer

	^aTrailer carry: aProduct . ! !


!classDefinition: #OutOfOrder category: #'IRobot-Enunciado'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!OutOfOrder methodsFor: 'actions' stamp: 'TM 4/10/2025 13:42:19'!
closeOrderUsing: aCashier

	^robot class signalOutOfOrder. ! !

!OutOfOrder methodsFor: 'actions' stamp: 'TM 4/10/2025 13:55:18'!
take: aProduct fromTrailer: aTrailer

	^ robot class signalOutOfOrder . ! !


!classDefinition: #SensorsFailure category: #'IRobot-Enunciado'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!SensorsFailure methodsFor: 'actions' stamp: 'TM 4/10/2025 16:04:28'!
closeOrderUsing: aCashier

	^aCashier receiveProductsFromSensorsFailure: robot! !

!SensorsFailure methodsFor: 'actions' stamp: 'TM 4/10/2025 13:55:32'!
take: aProduct fromTrailer: aTrailer

	^aTrailer carry: aProduct . ! !


!classDefinition: #WorkingNormal category: #'IRobot-Enunciado'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!WorkingNormal methodsFor: 'actions' stamp: 'TM 4/10/2025 16:04:12'!
closeOrderUsing: aCashier

	^aCashier receiveProductsFromNormal: robot! !

!WorkingNormal methodsFor: 'actions' stamp: 'TM 4/10/2025 13:55:39'!
take: aProduct fromTrailer: aTrailer

	^aTrailer carry: aProduct . ! !


!classDefinition: #Trailer category: #'IRobot-Enunciado'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'TM 4/10/2025 18:08:33'!
total: aContainer in: aBlock

	^aContainer sum: [:aProduct | (aBlock value: aProduct )] ifEmpty: [0].! !

!Trailer methodsFor: 'accessing' stamp: 'TM 4/10/2025 18:10:09'!
totalHeight: aContainer 

	^self total: aContainer in: [:aProduct | aProduct height ]. ! !

!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'TM 4/10/2025 18:14:00'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"

	^ self totalHeight: (container select: [:aProduct | aProduct isStackable ]).! !

!Trailer methodsFor: 'accessing' stamp: 'TM 4/10/2025 18:14:25'!
totalProductsWeight
	
	^self totalWeight: container.! !

!Trailer methodsFor: 'accessing' stamp: 'TM 4/10/2025 18:11:40'!
totalWeight: aContainer 

	^self total: aContainer in: [:aProduct | aProduct weight ]. ! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'TM 4/10/2025 17:57:09'!
add: aProduct asserting: aBlock
	
	aBlock value.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'TM 4/10/2025 17:57:55'!
carryProductA: aProduct
	
	self add: aProduct asserting: [self assertWeightAdding: aProduct.].
	! !

!Trailer methodsFor: 'action' stamp: 'TM 4/10/2025 17:59:12'!
carryProductB: aProduct
	
	self add: aProduct  asserting: 
	[self assertWeightAdding: aProduct.
	self assertHeightAdding: aProduct.
	].! !


!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:29'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'FRT 5/5/2020 11:27:41'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'IRobot-Enunciado'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !


!classDefinition: #CashierTest category: #'IRobot-Enunciado'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'TM 4/10/2025 18:39:25'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	self shouldRaise: [Cashier trailerIsEmptyErrorDescription.] inTheContext:  [:aTrailer :aRobot :aCashier | aCashier receiveProductsFromNormal: aRobot].

! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'TM 4/10/2025 18:39:16'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot


	self
		shouldRaise: [ Cashier trailerIsEmptyErrorDescription.		]
		inTheContext: [:aTrailer :aRobot :aCashier 	| 
					   aRobot withMechanicalFailure.
			                 aCashier receiveProductsFromMechanicalFailure: aRobot ].
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'TM 4/10/2025 18:39:08'!
test03ShouldNotAcceptSensorsFailureRobot

	self
		shouldRaise: [ Cashier robotSensorsFailureErrorDescription.]
			
		inTheContext: [:aTrailer :aRobot :aCashier |
					aRobot withSensorsFailure.
					aCashier receiveProductsFromSensorsFailure: aRobot ]
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'TM 4/10/2025 18:38:55'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot


	self
		shouldRaise: [ Robot outOfOrderErrorDescription.]
			
		inTheContext: [:aTrailer :aRobot :aCashier |
			aRobot take: (ProductA with: 1  and: 1).
			aRobot withMechanicalFailure.
			
			aCashier receiveProductsFromMechanicalFailure: aRobot.
			
			aRobot take: (ProductA with: 1 and: 1) ]
				 

! !


!CashierTest methodsFor: 'should' stamp: 'TM 4/10/2025 18:32:18'!
shouldRaise: errorMessage inTheContext: aBlock

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self  should: [aBlock value: aTrailer value: aRobot value: aCashier ]
		raise: Error
		withMessageText: errorMessage .! !


!classDefinition: #ProductTest category: #'IRobot-Enunciado'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: #'IRobot-Enunciado'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: #'IRobot-Enunciado'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:29:39'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		should: [ Trailer with: 0  and: 100 ]
		raise: Error
		withMessageText: Trailer invalidWeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:30:47'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self
		should: [ Trailer with: 1  and: 0 ]
		raise: Error
		withMessageText: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:04'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self
		should: [ Trailer with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:29'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self
		should: [ Trailer with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:43:36'!
test05ShouldRejectProductAIfWeightExceeded

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (ProductA with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:43:28'!
test06ShouldRejectProductBIfWeightExceeded

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (ProductB with: 21 and: 1) ]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/5/2020 11:27:50'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
		
	self assert: aTrailer totalProductsAmount equals: 4.
	self assert: aTrailer totalProductsWeight equals: 10.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/5/2020 11:27:57'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
	aTrailer carry: (ProductB with: 1 and: 1).
	
	self assert: aTrailer totalProductsAmount equals: 5.
	self assert: aTrailer totalProductsWeight equals: 11.! !


!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:03'!
test09ShouldAcceptProductAIgnoringMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: 0.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:07'!
test10ShouldIgnoreAProductsInMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:16'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !
