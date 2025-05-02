Class {
	#name : #CTQueueNode,
	#superclass : #Object,
	#instVars : [
		'value',
		'next'
	],
	#category : #'Containers-Queue'
}

{ #category : #accessing }
CTQueueNode >> next [
	^ next
]

{ #category : #accessing }
CTQueueNode >> next: aNode [
	next := aNode
]

{ #category : #accessing }
CTQueueNode >> value [
	^ value
]

{ #category : #accessing }
CTQueueNode >> value: anObject [
	value := anObject
]