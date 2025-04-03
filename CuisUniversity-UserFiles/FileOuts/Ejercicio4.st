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

!II class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:27:43'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
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


!II class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
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

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:53'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:53'!
+ num

	^ self previous  + num next.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:53'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:53'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!III class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
previous
	^previous .! !

!III class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
previous: aNumber

	previous := aNumber ! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: #Ejercicio4!
DenotativeObject subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: #Ejercicio4!
IV class
	instanceVariableNames: 'next previous'!

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
+ num

	^ self previous  + num next.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!IV class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:54'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:55'!
previous
	^previous .! !

!IV class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:28:55'!
previous: aNumber

	previous := aNumber ! !


!IV class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #IX category: #Ejercicio4!
DenotativeObject subclass: #IX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IX class' category: #Ejercicio4!
IX class
	instanceVariableNames: 'next previous'!

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
+ num

	^ self previous  + num next.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!IX class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := X.
	previous := VIII.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
previous
	^previous .! !

!IX class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
previous: aNumber

	previous := aNumber ! !


!IX class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := X.
	previous := VIII.! !


!classDefinition: #V category: #Ejercicio4!
DenotativeObject subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: #Ejercicio4!
V class
	instanceVariableNames: 'next previous'!

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:00'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:00'!
+ num

	^ self previous  + num next.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:00'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!V class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
previous
	^previous .! !

!V class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:01'!
previous: aNumber

	previous := aNumber ! !


!V class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !


!classDefinition: #VI category: #Ejercicio4!
DenotativeObject subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: #Ejercicio4!
VI class
	instanceVariableNames: 'next previous'!

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:06'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:06'!
+ num

	^ self previous  + num next.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!VI class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
previous
	^previous .! !

!VI class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
previous: aNumber

	previous := aNumber ! !


!VI class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !


!classDefinition: #VII category: #Ejercicio4!
DenotativeObject subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: #Ejercicio4!
VII class
	instanceVariableNames: 'next previous'!

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
+ num

	^ self previous  + num next.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!VII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:07'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
previous
	^previous .! !

!VII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
previous: aNumber

	previous := aNumber ! !


!VII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !


!classDefinition: #VIII category: #Ejercicio4!
DenotativeObject subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: #Ejercicio4!
VIII class
	instanceVariableNames: 'next previous'!

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
+ num

	^ self previous  + num next.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IX.
	previous := VII.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
previous
	^previous .! !

!VIII class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:08'!
previous: aNumber

	previous := aNumber ! !


!VIII class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IX.
	previous := VII.! !


!classDefinition: #X category: #Ejercicio4!
DenotativeObject subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'X class' category: #Ejercicio4!
X class
	instanceVariableNames: 'next previous'!

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
* aNum

	aNum = I ifTrue: [^self].
	^ self + aNum * aNum previous.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
+ num

	^ self previous  + num next.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
- aNum

	self <= aNum ifTrue: [^nil].
	aNum = I ifTrue: [^ self previous.].
	^ self previous - aNum previous.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
/ aNum

    aNum <= self ifFalse: [^ nil].
    aNum = I ifTrue: [^ self]. 
    self = aNum ifTrue: [^ I].
	aNum <= (self - aNum) ifFalse: [^I]. 
    ^ ((self - aNum) / aNum) + I.
! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:09'!
<= aNum
	
	aNum = I ifTrue:[^false ].
	^ self previous <= aNum previous.! !

!X class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := IX.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:10'!
nameOfNext
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV'), 'V'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III'), 'IV'].
	^self name, 'I'.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:10'!
next
	
	|nombre|
	nombre := self nameOfNext.
	
	next := Smalltalk at: nombre asSymbol ifAbsent: [II  cloneNamed: nombre.].
	next previous: self. 
	
	^next.! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:10'!
previous
	^previous .! !

!X class methodsFor: '-- all --' stamp: 'TM 3/28/2025 12:29:10'!
previous: aNumber

	previous := aNumber ! !


!X class methodsFor: '--** private fileout/in **--' stamp: 'TM 3/28/2025 12:30:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := IX.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
IX initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!
X initializeAfterFileIn!