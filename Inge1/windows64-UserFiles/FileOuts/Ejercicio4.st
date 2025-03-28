!classDefinition: #I category: #Ejercicio4!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Ejercicio4!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:52:36'!
* aMultiplicand

	^aMultiplicand.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:52:00'!
+ anAdder
	^ anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:52:17'!
- sustrahend

	^nil.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:35:53'!
/ dividend

	(dividend == I) ifTrue: [^I] ifFalse: [^nil]! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 16:37:47'!
<= aNum

	^true.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:27:56'!
nameOfNext

	^self name, 'I'.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:51:13'!
next

	^II.! !

!I class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:51:28'!
previous
	^nil.! !


!classDefinition: #II category: #Ejercicio4!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Ejercicio4!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 16:50:10'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 15:57:14'!
+ num

	^ self previous  + num next.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 16:46:19'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:40'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 16:38:47'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 13:55:13'!
nameOfNext

	^self name, 'I'.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 16:33:19'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 14:54:11'!
previous
	^previous .! !

!II class methodsFor: '-- all --' stamp: 'TM 3/23/2025 15:36:16'!
previous: aNumber

	previous := aNumber ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: #Ejercicio4!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Ejercicio4!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
+ num

	^ self previous  + num next.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!III class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
nameOfNext

	^self name, 'I'.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
previous
	^previous .! !

!III class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:55'!
previous: aNumber

	previous := aNumber ! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: #Ejercicio4!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Ejercicio4!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
+ num

	^ self previous  + num next.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := III.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
nameOfNext

	^self name, 'I'.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
previous
	^previous .! !

!IIII class methodsFor: '-- all --' stamp: 'TM 3/23/2025 18:43:56'!
previous: aNumber

	previous := aNumber ! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/23/2025 18:44:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!