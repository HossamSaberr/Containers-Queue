"
I'm a simple FIFO queue i.e., first in first out structure. I support basic collection protocol with efficient O(1) add and remove operations using a singly linked list.
"
Class {
	#name : #CTQueue,
	#superclass : #Object,
	#instVars : [
		'head',
		'tail',
		'size'
	],
	#category : #'Containers-Queue'
}

{ #category : #adding }
CTQueue >> add: anElement [
	"Add an element to the end of the queue (FIFO order)."
	| newNode |
	newNode := CTQueueNode new value: anElement.
	head ifNil: [ 
		head := newNode.
		tail := newNode.
	] ifNotNil: [ 
		tail next: newNode.
		tail := newNode.
	].
	size := size + 1.
	^ anElement
]

{ #category : #adding }
CTQueue >> addAll: aCollection [
	"Add all elements from aCollection to the end of the queue."
	aCollection do: [ :each | self add: each ].
	^ aCollection
]

{ #category : #iterating }
CTQueue >> do: aBlock [
	"Iterate over elements in FIFO order."
	| current |
	current := head.
	[ current notNil ] whileTrue: [ 
		aBlock value: current value.
		current := current next.
	]
]

{ #category : #testing }
CTQueue >> includes: anElement [
	"Check if anElement exists in the queue."
	| current |
	current := head.
	[ current notNil ] whileTrue: [ 
		current value = anElement ifTrue: [ ^ true ].
		current := current next.
	].
	^ false
]

{ #category : #initialization }
CTQueue >> initialize [
	"Initialize an empty queue."
	super initialize.
	head := nil.
	tail := nil.
	size := 0.
]

{ #category : #testing }
CTQueue >> isEmpty [
	"Return true if the queue is empty."
	^ head isNil
]

{ #category : #accessing }
CTQueue >> peek [
	"Return the front element without removing it, or nil if empty."
	^ head ifNil: [ nil ] ifNotNil: [ head value ]
]

{ #category : #removing }
CTQueue >> poll [
	"Return and remove the front element, or nil if empty."
	^ self remove
]

{ #category : #removing }
CTQueue >> remove [
	"Return and remove the oldest element, or nil if empty."
	| value |
	head ifNil: [ ^ nil ].
	value := head value.
	head := head next.
	head ifNil: [ tail := nil ].
	size := size - 1.
	^ value
]

{ #category : #removing }
CTQueue >> removeIfNone: aBlock [
	"Return and remove the oldest element, or evaluate aBlock if empty."
	head ifNil: [ ^ aBlock value ].
	^ self remove
]

{ #category : #accessing }
CTQueue >> size [
	"Return the number of elements in the queue."
	^ size
]