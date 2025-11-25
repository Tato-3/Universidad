!classDefinition: #Developer category: #'2024-1C-2P'!
Object subclass: #Developer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!

!Developer methodsFor: 'work' stamp: 'TM 11/24/2025 22:28:27'!
workingTime

	self subclassResponsibility! !


!classDefinition: #DeveloperSingular category: #'2024-1C-2P'!
Developer subclass: #DeveloperSingular
	instanceVariableNames: 'name amountOfHoursPerDay salaryPerHour'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!

!DeveloperSingular methodsFor: 'initialization' stamp: 'TM 11/24/2025 22:04:47'!
initializeNamed: aName working: anAmountOfHoursPerDay earns: aSalaryPerHour 
	
	name := aName.
	amountOfHoursPerDay := anAmountOfHoursPerDay.
	salaryPerHour := aSalaryPerHour.! !


!DeveloperSingular methodsFor: 'work' stamp: 'TM 11/24/2025 22:05:56'!
workingTime
	
	^amountOfHoursPerDay ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DeveloperSingular class' category: #'2024-1C-2P'!
DeveloperSingular class
	instanceVariableNames: ''!

!DeveloperSingular class methodsFor: 'instance creation' stamp: 'TM 11/24/2025 22:04:30'!
named: aName working: anAmountOfHoursPerDay earns: aSalaryPerHour 
	
	^self new initializeNamed: aName working: anAmountOfHoursPerDay earns: aSalaryPerHour ! !


!classDefinition: #DeveloperTeam category: #'2024-1C-2P'!
Developer subclass: #DeveloperTeam
	instanceVariableNames: 'name developers'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!

!DeveloperTeam methodsFor: 'initialization' stamp: 'TM 11/24/2025 22:22:25'!
initializeNamed: aTeamName developers: aCollectionOfDevelopers 
	
	name := aTeamName.
	developers := aCollectionOfDevelopers.! !


!DeveloperTeam methodsFor: 'work' stamp: 'TM 11/24/2025 22:25:11'!
workingTime
	
	^developers min: [:aDeveloper | aDeveloper workingTime ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DeveloperTeam class' category: #'2024-1C-2P'!
DeveloperTeam class
	instanceVariableNames: ''!

!DeveloperTeam class methodsFor: 'instance creation' stamp: 'TM 11/24/2025 22:21:52'!
named: aTeamName developers: aCollectionOfDevelopers 
	
	^self new initializeNamed: aTeamName developers: aCollectionOfDevelopers ! !


!classDefinition: #TaskConcrete category: #'2024-1C-2P'!
Object subclass: #TaskConcrete
	instanceVariableNames: 'name desiredStartDate effort dependencies responsible'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!

!TaskConcrete methodsFor: 'initialization' stamp: 'TM 11/24/2025 22:47:20'!
initializeName: aTaskName startingDeveloping: aStartingDate withEffort: anEffort dependingOn: aCollectionOfTasks takenBy: aResponsible 
	
	name := aTaskName.
	desiredStartDate := aStartingDate.
	effort := anEffort.
	dependencies := aCollectionOfTasks.
	responsible := aResponsible.! !


!TaskConcrete methodsFor: 'testing' stamp: 'TM 11/24/2025 22:05:39'!
calculateTimeToCompleteTask


	^ (effort / responsible workingTime) ceiling! !

!TaskConcrete methodsFor: 'testing' stamp: 'TM 11/24/2025 22:54:43'!
endsDate

	^ (self startingDate next: self calculateTimeToCompleteTask) previous! !

!TaskConcrete methodsFor: 'testing' stamp: 'TM 11/24/2025 22:44:57'!
hasFinishedAt: anEstimatedDate 
	
	^self endsDate = anEstimatedDate ! !


!TaskConcrete methodsFor: 'developer' stamp: 'TM 11/24/2025 21:58:15'!
cost
	
	^ responsible value * effort * (self calculateTimeToCompleteTask amount)! !


!TaskConcrete methodsFor: 'task' stamp: 'TM 11/24/2025 22:55:35'!
startingDate

	^ dependencies 
			ifEmpty: [desiredStartDate ]
			ifNotEmpty: [(dependencies max: [:aDependent | aDependent endsDate ]) next]! !

!TaskConcrete methodsFor: 'task' stamp: 'TM 11/24/2025 22:55:48'!
startsOn: aPotentialStartingDate 
	
	^ self startingDate = aPotentialStartingDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TaskConcrete class' category: #'2024-1C-2P'!
TaskConcrete class
	instanceVariableNames: ''!

!TaskConcrete class methodsFor: 'instance creation' stamp: 'TM 11/24/2025 19:42:39'!
name: aTaskName startingDeveloping: aStartingDate withEffort: anEffort dependingOn: aCollectionOfTasks takenBy: aResponsible 
	
	^self new initializeName: aTaskName startingDeveloping: aStartingDate withEffort: anEffort dependingOn: aCollectionOfTasks takenBy: aResponsible ! !


!classDefinition: #ConcreteTaskTest category: #'2024-1C-2P'!
TestCase subclass: #ConcreteTaskTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:25:47'!
alanKay

	^ DeveloperSingular named: 'Alan Kay' working: 6*hour/day earns: 80*dollar/hour.! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:25:47'!
danIngalls

	^ DeveloperSingular named: 'Dan Ingalls' working: 8*hour/day earns: 60*dollar/hour! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:13:41'!
test01DeveloperWithSameDedicationAsTaskEffortFinishItsInTheSameDay

	| ssaTask |
	ssaTask := TaskConcrete 
								name: 'SS A'
								startingDeveloping: July/1/2024
								withEffort: 8*hour
								dependingOn: {}
								takenBy: self danIngalls.
								
	
	self assert: (ssaTask hasFinishedAt: July/1/2024)
	
	
	! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:16:45'!
test02TaskWithMoreEffortTakesMoreDaysToFinished

	| ssbTask |
	ssbTask := TaskConcrete 
								name: 'SS B'
								startingDeveloping: July/1/2024
								withEffort: 16*hour
								dependingOn: {}
								takenBy: self danIngalls.
								
	
	self deny: (ssbTask hasFinishedAt: July/1/2024)
	
	
	! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:17:27'!
test03TaskWithMoreEffortThanDeveloperDedicationFinishesInMoraThanOneDay

	| ssbTask |
	ssbTask := TaskConcrete 
								name: 'SS B'
								startingDeveloping: July/1/2024
								withEffort: 16*hour
								dependingOn: {}
								takenBy: self danIngalls.
								
	
	self assert: (ssbTask hasFinishedAt: July/2/2024)
	
	
	! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:37:53'!
test04TaskTakenByATeamFinishByTheSlowestDeveloperOnTeam

	| ssbTask |
	ssbTask := TaskConcrete 
						name: 'SS B'
						startingDeveloping: July/1/2024
						withEffort: 16*hour
						dependingOn: {}
						takenBy: self parcMobTeam.
								
	
	self assert: (ssbTask hasFinishedAt: July/3/2024)
	
	
	! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:52:01'!
test05TaskWithDependenciesStartsWhenAllDependenciesAreFinished

	| sscTask |
	
	sscTask := TaskConcrete 
						name: 'SS C'
						startingDeveloping: July/2/2024
						withEffort: 16*hour
						dependingOn: {self ssaTask. self ssbTask}
						takenBy: self alanKay.
								
	self assert: (sscTask startsOn: self ssbTask endsDate next).
	
	
	! !

!ConcreteTaskTest methodsFor: 'tests' stamp: 'TM 11/24/2025 22:53:32'!
test06TaskWithDependenciesEndsWhenAllDependenciesAreFinished

	| sscTask |
	
	sscTask := TaskConcrete 
						name: 'SS C'
						startingDeveloping: July/2/2024
						withEffort: 16*hour
						dependingOn: {self ssaTask. self ssbTask}
						takenBy: self alanKay.
								
	self assert: (sscTask hasFinishedAt: July/6/2024).
	
	
	! !


!ConcreteTaskTest methodsFor: 'as yet unclassified' stamp: 'TM 11/24/2025 22:21:23'!
parcMobTeam
	
	^DeveloperTeam named: 'Parc MobTeam' developers: {self danIngalls. self alanKay}! !

!ConcreteTaskTest methodsFor: 'as yet unclassified' stamp: 'TM 11/24/2025 22:37:27'!
ssaTask
	
	^ TaskConcrete 
					name: 'SS A'
					startingDeveloping: July/1/2024
					withEffort: 8*hour
					dependingOn: {}
					takenBy: self danIngalls.! !

!ConcreteTaskTest methodsFor: 'as yet unclassified' stamp: 'TM 11/24/2025 22:38:02'!
ssbTask
	
	^TaskConcrete 
				name: 'SS B'
				startingDeveloping: July/1/2024
				withEffort: 16*hour
				dependingOn: {}
				takenBy: self parcMobTeam.! !


!classDefinition: #ProjectTest category: #'2024-1C-2P'!
TestCase subclass: #ProjectTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-1C-2P'!
