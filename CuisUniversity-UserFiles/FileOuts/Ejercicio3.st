!classDefinition: #testEj3 category: #Ejercicio3!
DenotativeObject subclass: #testEj3
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'testEj3 class' category: #Ejercicio3!
testEj3 class
	instanceVariableNames: ''!

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:29:32'!
testFalsoOFalso
	Assert that: (Falso o: Falso) isEqualTo: Falso. ! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:29:01'!
testFalsoOVerdadero
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero. ! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:39:10'!
testFalsoSiFalsoBloque1
	Assert that: (Falso siFalso: [1 + 1]) isEqualTo: 2.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:42:11'!
testFalsoSiVerdaderoBloque1
	Assert that: (Falso siVerdadero: [1 + 1]) isEqualTo: nil.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:27:51'!
testFalsoYFalso
	Assert that: (Falso y: Falso) isEqualTo: Falso.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:26:31'!
testFalsoYVerdadero
	Assert that: (Falso y: Verdadero) isEqualTo: Falso.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:24:37'!
testNegFalsoAVerdadero
	Assert that: Falso no isEqualTo: Verdadero.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:44:09'!
testNegVerdadero
	Assert  that: Verdadero no isEqualTo: Falso.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:48:54'!
testVerdaderoOFalso
	
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero. ! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:48:41'!
testVerdaderoOVerdadero
	
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero. ! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:51:11'!
testVerdaderoSiFalsoBloque1
	Assert that: (Verdadero siFalso: [1 + 1]) isEqualTo: nil.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:51:26'!
testVerdaderoSiVerdaderoBloque1
	Assert that: (Verdadero siVerdadero: [1 + 1]) isEqualTo: 2.! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:45:26'!
testVerdaderoYFalso

	Assert  that: (Verdadero y: Falso) isEqualTo: Falso ! !

!testEj3 class methodsFor: '-- all --' stamp: 'TM 3/22/2025 10:45:48'!
testVerdaderoYVerdadero

	Assert  that: (Verdadero y: Verdadero) isEqualTo: Verdadero ! !


!classDefinition: #Falso category: #Ejercicio3!
Object subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Ejercicio3!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:25:30'!
no
	^Verdadero.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:30:50'!
o: unBool

	(unBool == Verdadero) ifTrue: [^Verdadero] ifFalse: [^Falso].  ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:42:59'!
siFalso: bloque

	^bloque value.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:43:11'!
siVerdadero: bloque

	^nil.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:27:02'!
y: unBool

	^Falso.! !


!classDefinition: #Verdadero category: #Ejercicio3!
Object subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Ejercicio3!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:44:41'!
no

	^Falso.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:50:12'!
o: unBool

	^Verdadero.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:51:57'!
siFalso: bloque

	^nil.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:51:46'!
siVerdadero: bloque

	^bloque value.! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'TM 3/22/2025 10:46:55'!
y: unBool

	(Verdadero == unBool) ifTrue: [^Verdadero] ifFalse: [^Falso]. ! !
