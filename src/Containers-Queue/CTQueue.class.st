"
I implement a simple Queue (FIFO - First In, First Out) that grows dynamically as needed.
- #enqueue: adds a new object to the rear of the queue.
- #dequeue returns and removes the front element from the queue.
- #front answers the front element of the queue without removing it.
"
Class {
	#name : 'CTQueue',
	#superclass : 'Object',
	#instVars : [
		'elements',
		'frontIndex',
		'rearIndex',
		'size'
	],
	#category : 'Containers-Queue',
	#package : 'Containers-Queue'
}

{ #category : 'instance creation' }
CTQueue class >> new [

	"Create a new queue with default capacity of 10"
	
	^ self new: 10
]

{ #category : 'instance creation' }
CTQueue class >> new: anInteger [

	anInteger < 0 ifTrue: [ self error: 'Initial capacity cannot be negative' ].
	^ self basicNew
		initializeWithCapacity: anInteger;
		yourself
]

{ #category : 'converting' }
CTQueue >> asArray [

	| result |
	self isEmpty ifTrue: [ ^ #() ].
	
	result := Array new: self size.
	1 to: self size do: [ :i |
		result at: i put: (elements at: (self indexAt: i - 1))
	].
	^ result
]

{ #category : 'converting' }
CTQueue >> asOrderedCollection [

	| result |
	result := OrderedCollection new: self size.
	self do: [ :each | result add: each ].
	^ result
]

{ #category : 'accessing' }
CTQueue >> capacity [

	^ elements size
]

{ #category : 'copying' }
CTQueue >> copy [

	| newQueue |
	newQueue := self class new: self capacity.
	self do: [ :each | newQueue enqueue: each ].
	^ newQueue
]

{ #category : 'removing' }
CTQueue >> dequeue [

	| element |
	self isEmpty ifTrue: [ self error: 'Queue is empty' ].
	
	element := elements at: frontIndex.
	elements at: frontIndex put: nil.
	frontIndex := self nextIndex: frontIndex.
	size := size - 1.
	
	^ element
]

{ #category : 'enumerating' }
CTQueue >> do: aBlock [

	self isEmpty ifTrue: [ ^ self ].
	
	0 to: size - 1 do: [ :offset |
		aBlock value: (elements at: (self indexAt: offset))
	]
]

{ #category : 'adding' }
CTQueue >> enqueue: anObject [

	self isFull ifTrue: [ self grow ].
	
	elements at: rearIndex put: anObject.
	rearIndex := self nextIndex: rearIndex.
	size := size + 1.
	^ self
]

{ #category : 'adding' }
CTQueue >> enqueueAll: aCollection [

	aCollection do: [ :each | self enqueue: each ].
	^ self
]

{ #category : 'accessing' }
CTQueue >> front [

	self isEmpty ifTrue: [ self error: 'Queue is empty' ].
	^ elements at: frontIndex
]

{ #category : 'private' }
CTQueue >> grow [

	| newElements newCapacity |
	newCapacity := (self capacity = 0 ifTrue: [ 10 ] ifFalse: [ self capacity * 2 ]).
	newElements := Array new: newCapacity.
	
	1 to: size do: [ :i |
		newElements at: i put: (elements at: (self indexAt: i - 1))
	].
	
	elements := newElements.
	frontIndex := 1.
	rearIndex := size + 1
]

{ #category : 'testing' }
CTQueue >> includes: anElement [

	self isEmpty ifTrue: [ ^ false ].
	
	0 to: size - 1 do: [ :offset |
		(elements at: (self indexAt: offset)) = anElement ifTrue: [ ^ true ]
	].
	^ false
]

{ #category : 'accessing' }
CTQueue >> indexAt: offset [

	^ ((frontIndex - 1 + offset) rem: self capacity) + 1
]

{ #category : 'initialization' }
CTQueue >> initializeWithCapacity: anInteger [

	elements := Array new: anInteger.
	frontIndex := 1.
	rearIndex := 1.
	size := 0
]

{ #category : 'testing' }
CTQueue >> isEmpty [

	^ size = 0
]

{ #category : 'testing' }
CTQueue >> isFull [

	^ size = self capacity
]

{ #category : 'private' }
CTQueue >> nextIndex: currentIndex [

	^ currentIndex = self capacity 
		ifTrue: [ 1 ]
		ifFalse: [ currentIndex + 1 ]
]

{ #category : 'accessing' }
CTQueue >> peek [

	"Answer the front element, or nil if empty."
    self isEmpty ifTrue: [ ^ nil ].
    ^ self front
]

{ #category : 'removing' }
CTQueue >> removeAll [

	elements := Array new: self capacity.
	frontIndex := 1.
	rearIndex := 1.
	size := 0
]

{ #category : 'accessing' }
CTQueue >> search: anObject [

	self isEmpty ifTrue: [ ^ -1 ].
	
	0 to: size - 1 do: [ :offset |
		(elements at: (self indexAt: offset)) = anObject ifTrue: [ 
			^ offset + 1 
		]
	].
	^ -1
]

{ #category : 'accessing' }
CTQueue >> size [

	^ size
]
