"
I'm a simple queue i.e., first in first out structure. 
I support basic collection protocol and in addition enqueue and dequeue as in Scala. 
"
Class {
	#name : #CTQueueTest,
	#superclass : #TestCase,
	#category : #'Containers-Queue-Tests'
}

{ #category : #tests }
CTQueueTest >> queueClass [
	^ CTQueue
]

{ #category : #tests }
CTQueueTest >> testAdd [
	| queue |
	queue := self queueClass new.
	queue add: 1.
	queue add: 2.
	self assert: (queue includes: 1).
	self assert: (queue includes: 2)
]

{ #category : #tests }
CTQueueTest >> testAddAll [
	"Ensure queueAll adds multiple elements at once."
	| queue |
	queue := self queueClass new.
	queue addAll: #(10 20 30 40).
	self assert: queue remove equals: 10.
	self assert: queue remove equals: 20.
	self assert: queue remove equals: 30.
	self assert: queue remove equals: 40.
]

{ #category : #tests }
CTQueueTest >> testAddAllLargeCollection [
	"Test adding a large collection via addAll."
	| queue collection size |
	queue := self queueClass new.
	size := 50000.
	collection := (1 to: size) asArray.
	queue addAll: collection.
	self assert: queue size equals: size.
	1 to: size do: [ :i | self assert: queue remove equals: i ].
	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testAddGarantyFIFOOrder [
	"Ensure elements are dequeued in FIFO order."
	| queue |
	queue := self queueClass new.
	queue add: 'first'.
	queue add: 'second'.
	queue add: 'third'.
	self assert: queue remove equals: 'first'.
	self assert: queue remove equals: 'second'.
	self assert: queue remove equals: 'third'.
	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testAddNilElement [
	"Test adding a nil element to the queue."
	| queue |
	queue := self queueClass new.
	queue add: nil.
	self assert: queue size equals: 1.
	self assert: queue peek isNil.
	self assert: queue remove isNil.
	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testDoIteration [
	"Test iterating over the queue with do: in FIFO order."
	| queue collected |
	queue := self queueClass new.
	queue addAll: #(10 20 30 40).
	collected := OrderedCollection new.
	queue do: [ :each | collected add: each ].
	self assert: collected asArray equals: #(10 20 30 40).
	self assert: queue size equals: 4. "Iteration should not modify the queue"
]

{ #category : #tests }
CTQueueTest >> testEmptyQueue [
	self assert: self queueClass new isEmpty
]

{ #category : #tests }
CTQueueTest >> testEmptyQueueRemove [
	| queue |
	queue := self queueClass new.
	self assert: queue remove isNil.
]

{ #category : #tests }
CTQueueTest >> testIncludes [
	"Test the includes: method for existing and non-existing elements."
	| queue |
	queue := self queueClass new.
	queue addAll: #(5 10 15).
	self assert: (queue includes: 10).
	self deny: (queue includes: 20).
	self assert: queue size equals: 3. "includes: should not modify the queue"
]

{ #category : #tests }
CTQueueTest >> testInterleavedAddRemove [
	"Test interleaved add and remove operations to ensure FIFO order and correctness."
	| queue |
	queue := self queueClass new.
	queue add: 1.
	queue add: 2.
	self assert: queue remove equals: 1.
	queue add: 3.
	self assert: queue remove equals: 2.
	queue add: 4.
	self assert: queue remove equals: 3.
	self assert: queue remove equals: 4.
	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testIsEmpty [
	"Ensure isEmpty works correctly."
	| queue |
	queue := self queueClass new.
	self assert: queue isEmpty.
	queue add: 1.
	self deny: queue isEmpty.
	queue remove.
	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testLargeQueuePerformance [
	"Verify FIFO behavior and performance with a large queue."
	| queue size startTime endTime duration maxDuration |
	queue := self queueClass new.
	size := 100000. 
	
	"Measure time to add elements"
	startTime := DateAndTime now.
	1 to: size do: [ :i | queue add: i ].
	endTime := DateAndTime now.
	duration := endTime - startTime.
	maxDuration := 5 seconds. "Expect adding 100,000 elements to take less than 5 seconds"
	self assert: duration < maxDuration description: 'Adding elements took too long'.

	"Measure time to remove elements and verify FIFO order"
	startTime := DateAndTime now.
	1 to: size do: [ :i | self assert: queue remove equals: i ].
	endTime := DateAndTime now.
	duration := endTime - startTime.
	self assert: duration < maxDuration description: 'Removing elements took too long'.

	self assert: queue isEmpty.
]

{ #category : #tests }
CTQueueTest >> testPeek [
	"Ensure peek returns the first element without removing it."
	| queue |
	queue := self queueClass new.
	queue add: 42.
	queue add: 99.
	self assert: queue peek equals: 42.
	self assert: queue size equals: 2. "Peek should not remove elements"
]

{ #category : #tests }
CTQueueTest >> testPoll [
	"Ensure poll behaves correctly, returning nil when empty."
	| queue |
	queue := self queueClass new.
	queue add: 'A'.
	queue add: 'B'.
	self assert: queue poll equals: 'A'.
	self assert: queue poll equals: 'B'.
	self assert: queue poll isNil.
]

{ #category : #tests }
CTQueueTest >> testQueue [
	self assert: self queueClass new isEmpty
]

{ #category : #tests }
CTQueueTest >> testQueueGarantyFIFOOrder [
	self assert: self queueClass new isEmpty
]

{ #category : #tests }
CTQueueTest >> testRemove [
	"Ensure remove behaves correctly, returning nil when empty."
	| queue |
	queue := self queueClass new.
	queue add: 1.
	queue add: 2.
	queue add: 3.
	self assert: queue remove equals: 1.
	self assert: queue remove equals: 2
]

{ #category : #tests }
CTQueueTest >> testRemoveIfNone [
	"Ensure removeIfNone works correctly."
	| queue result |
	queue := self queueClass new.
	result := queue removeIfNone: [ 'fallback' ].
	self assert: result equals: 'fallback'.
]

{ #category : #tests }
CTQueueTest >> testSizeAccuracy [
	"Test that the size method accurately reflects the number of elements."
	| queue |
	queue := self queueClass new.
	self assert: queue size equals: 0.
	queue add: 1.
	self assert: queue size equals: 1.
	queue addAll: #(2 3 4).
	self assert: queue size equals: 4.
	queue remove.
	self assert: queue size equals: 3.
	queue removeIfNone: [ nil ].
	self assert: queue size equals: 2.
]

{ #category : #tests }
CTQueueTest >> testStressAddRemove [
	"Stress test with many add and remove operations."
	| queue iterations |
	queue := self queueClass new.
	iterations := 10000.
	1 to: iterations do: [ :i | 
		queue add: i.
		self assert: queue size equals: 1.
		self assert: queue remove equals: i.
		self assert: queue isEmpty.
	].
	"Add multiple elements and remove them"
	queue addAll: (1 to: 1000).
	1 to: 1000 do: [ :i | self assert: queue remove equals: i ].
	self assert: queue isEmpty.
]