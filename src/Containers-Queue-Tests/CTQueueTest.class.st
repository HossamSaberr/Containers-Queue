"
I provide a comprehensive suite of unit tests for the CTQueue class.
My tests cover basic operations, FIFO behavior, error handling, state management,
capacity growth, constructors, bulk operations, and various edge cases to ensure
the implementation is robust, correct, and performant.
"
Class {
	#name : 'CTQueueTest',
	#superclass : 'TestCase',
	#instVars : [
		'queue'
	],
	#category : 'Containers-Queue-Tests',
	#package : 'Containers-Queue-Tests'
}

{ #category : 'running' }
CTQueueTest >> setUp [
	super setUp.

	queue := CTQueue new: 5
]

{ #category : 'tests' }
CTQueueTest >> testAlternatingEnqueueDequeue [

	queue enqueue: 'a'.
	self assert: queue dequeue equals: 'a'.
	
	queue enqueue: 'b'; enqueue: 'c'.
	self assert: queue dequeue equals: 'b'.
	
	queue enqueue: 'd'.
	self assert: queue front equals: 'c'.
	self assert: queue size equals: 2
]

{ #category : 'tests' }
CTQueueTest >> testAsArray [

	| result |
	queue enqueue: 'first'; enqueue: 'second'; enqueue: 'third'.
	result := queue asArray.
	
	self assert: result equals: #('first' 'second' 'third').
	"Elements from front to rear"
]

{ #category : 'tests' }
CTQueueTest >> testAsOrderedCollection [

	| result |
	queue enqueue: 'a'; enqueue: 'b'; enqueue: 'c'.
	result := queue asOrderedCollection.
	
	self assert: result class equals: OrderedCollection.
	self assert: result asArray equals: #('a' 'b' 'c')
]

{ #category : 'tests' }
CTQueueTest >> testCapacityGrowth [

	| originalCapacity |
	originalCapacity := queue capacity.
	
	1 to: originalCapacity do: [ :i | queue enqueue: i ].
	self assert: queue capacity equals: originalCapacity.
	
	queue enqueue: 'overflow'.
	self assert: queue capacity equals: originalCapacity * 2.
	self assert: queue size equals: originalCapacity + 1
]

{ #category : 'tests' }
CTQueueTest >> testCircularArrayWrapping [

	| testQueue |
	testQueue := CTQueue new: 3.
	
	"Fill the queue"
	testQueue enqueue: 1; enqueue: 2; enqueue: 3.
	
	"Remove front elements"
	testQueue dequeue; dequeue.
	
	"Add more elements to test wraparound"
	testQueue enqueue: 4; enqueue: 5.
	
	self assert: testQueue front equals: 3.
	self assert: testQueue size equals: 3
]

{ #category : 'tests' }
CTQueueTest >> testCopyCreatesNewObject [

	| copy |
	queue
		enqueue: 'a';
		enqueue: 'b'.
	copy := queue copy.
	self deny: queue identicalTo: copy
]

{ #category : 'tests' }
CTQueueTest >> testCopyHasSameContents [

	| copy |
	queue
		enqueue: 'first';
		enqueue: 'second';
		enqueue: 'third'.
	copy := queue copy.
	self assert: copy size equals: queue size.
	self assert: copy front equals: queue front
]

{ #category : 'tests' }
CTQueueTest >> testCopyIsIndependent [

	| copy |
	queue enqueue: 'a'; enqueue: 'b'.
	copy := queue copy.
	"Now, modify the original queue"
	queue dequeue.
	queue enqueue: 'c'.
	
	self assert: copy size equals: 2.
	self assert: copy front equals: 'a'.
	self deny: copy front equals: queue front
]

{ #category : 'tests' }
CTQueueTest >> testDefaultQueueCreation [

	| defaultQueue |
	defaultQueue := CTQueue new.
	self assert: defaultQueue capacity equals: 10.
	self assert: defaultQueue isEmpty.
	self assert: defaultQueue size equals: 0
]

{ #category : 'tests' }
CTQueueTest >> testDequeueAllElements [

	queue
		enqueue: 'a';
		enqueue: 'b';
		enqueue: 'c'.
	queue
		dequeue;
		dequeue;
		dequeue.
	self assert: queue isEmpty.
	self assert: queue size equals: 0
]

{ #category : 'tests' }
CTQueueTest >> testDequeueMultipleElements [

	queue enqueue: 'first'; enqueue: 'second'; enqueue: 'third'.
	
	self assert: queue dequeue equals: 'first'.
	self assert: queue dequeue equals: 'second'.
	self assert: queue size equals: 1.
	self assert: queue front equals: 'third'
]

{ #category : 'tests' }
CTQueueTest >> testDequeueSingleElement [

	| element |
	queue enqueue: 'test'.
	element := queue dequeue.
	self assert: element equals: 'test'.
	self assert: queue isEmpty.
	self assert: queue size equals: 0
]

{ #category : 'tests' }
CTQueueTest >> testDoIteration [

	| elements |
	queue enqueue: 'first'; enqueue: 'second'; enqueue: 'third'.
	elements := OrderedCollection new.
	
	queue do: [ :each | elements add: each ].
	
	self assert: elements asArray equals: #('first' 'second' 'third').
	self assert: queue size equals: 3. "Iteration should not modify the queue"
]

{ #category : 'tests' }
CTQueueTest >> testDynamicQueue [

	| testQueue |
	testQueue := CTQueue new: 2.
	testQueue
		enqueue: 'a';
		enqueue: 'b'.
	self assert: testQueue capacity equals: 2.
	"Enqueue one more - should double capacity"
	testQueue enqueue: 'c'.
	self assert: testQueue capacity equals: 4.
	self assert: testQueue size equals: 3.
	self assert: testQueue front equals: 'a'
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueAll [

		| result |
	result := queue enqueueAll: #('a' 'b' 'c').
	
	self assert: queue size equals: 3.
	self assert: queue front equals: 'a'.
	self assert: result identicalTo: queue
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueAllLargeCollection [

	| collection size |
	size := 50000.
	collection := (1 to: size) asArray.
	queue enqueueAll: collection.
	self assert: queue size equals: size.
	1 to: size do: [ :i | self assert: queue dequeue equals: i ].
	self assert: queue isEmpty
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueAllWithEmptyCollection [

	| result |
	result := queue enqueueAll: #().
	self assert: queue isEmpty.
	self assert: result identicalTo: queue
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueMultipleElements [

	queue
		enqueue: 'first';
		enqueue: 'second';
		enqueue: 'third'.
	self assert: queue size equals: 3.
	self assert: queue front equals: 'first'.
	self deny: queue isEmpty
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueNilElement [

	queue enqueue: nil.
	self assert: queue size equals: 1.
	self assert: queue front isNil.
	self assert: queue dequeue isNil.
	self assert: queue isEmpty
]

{ #category : 'tests' }
CTQueueTest >> testEnqueueSingleElement [

	queue enqueue: 'first'.
	self assert: queue size equals: 1.
	self deny: queue isEmpty.
	self assert: queue front equals: 'first'
]

{ #category : 'tests' }
CTQueueTest >> testErrorHandling [

	self should: [ queue dequeue ] raise: Error.
	self should: [ queue front ] raise: Error.
	
	queue enqueue: 'test'.
	queue dequeue.
	
	self should: [ queue dequeue ] raise: Error.
	self should: [ queue front ] raise: Error
]

{ #category : 'tests' }
CTQueueTest >> testFIFOOrdering [

	queue enqueue: 'first'; enqueue: 'second'; enqueue: 'third'; enqueue: 'fourth'.
	
	self assert: queue dequeue equals: 'first'.
	self assert: queue dequeue equals: 'second'.
	self assert: queue dequeue equals: 'third'.
	self assert: queue dequeue equals: 'fourth'
]

{ #category : 'tests' }
CTQueueTest >> testFrontWithoutRemoving [

	queue enqueue: 'first'; enqueue: 'second'.
	
	self assert: queue front equals: 'first'.
	self assert: queue size equals: 2.
	self assert: queue front equals: 'first'. "Still there"
]

{ #category : 'tests' }
CTQueueTest >> testIncludes [

	queue enqueueAll: #(5 10 15).
	self assert: (queue includes: 10).
	self deny: (queue includes: 20).
	self assert: queue size equals: 3. 
]

{ #category : 'tests' }
CTQueueTest >> testInterleavedEnqueueDequeue [

	queue enqueue: 1.
	queue enqueue: 2.
	self assert: queue dequeue equals: 1.
	queue enqueue: 3.
	self assert: queue dequeue equals: 2.
	queue enqueue: 4.
	self assert: queue dequeue equals: 3.
	self assert: queue dequeue equals: 4.
	self assert: queue isEmpty
]

{ #category : 'tests' }
CTQueueTest >> testIsEmpty [

	self assert: queue isEmpty.
	queue enqueue: 'test'.
	self deny: queue isEmpty.
	queue dequeue.
	self assert: queue isEmpty
]

{ #category : 'tests' }
CTQueueTest >> testQueueCreationWithCapacity [

	| testQueue |
	testQueue := CTQueue new: 3.
	self assert: testQueue capacity equals: 3.
	self assert: testQueue isEmpty.
	self assert: testQueue size equals: 0
]

{ #category : 'tests' }
CTQueueTest >> testQueueCreationWithInvalidCapacity [

	self should: [ CTQueue new: -1 ] raise: Error.
	self should: [ CTQueue new: -10 ] raise: Error
]

{ #category : 'tests' }
CTQueueTest >> testQueueCreationWithZeroCapacity [

	| zeroQueue |
	zeroQueue := CTQueue new: 0.
	
	self assert: zeroQueue capacity equals: 0.
	self assert: zeroQueue isEmpty.
	self assert: zeroQueue size equals: 0.
	
	zeroQueue enqueue: 'first'.
	self assert: zeroQueue capacity equals: 10.
	self assert: zeroQueue size equals: 1
]

{ #category : 'tests' }
CTQueueTest >> testRemoveAll [

	queue
		enqueue: 'a';
		enqueue: 'b';
		enqueue: 'c'.
	queue removeAll.
	self assert: queue isEmpty.
	self assert: queue size equals: 0.
	queue enqueue: 'd'.
	self deny: queue isEmpty.
	self assert: queue size equals: 1.
	self assert: queue front equals: 'd'
]

{ #category : 'tests' }
CTQueueTest >> testRemoveAllOnEmptyQueue [

	queue removeAll.
	
	self assert: queue isEmpty.
	self assert: queue size equals: 0
]

{ #category : 'tests' }
CTQueueTest >> testSearchExistingElement [

	queue enqueue: 'a'; enqueue: 'b'; enqueue: 'c'; enqueue: 'b'.
	
	self assert: (queue search: 'a') equals: 1. "Front element"
	self assert: (queue search: 'b') equals: 2. "First occurrence"
	self assert: (queue search: 'c') equals: 3
]

{ #category : 'tests' }
CTQueueTest >> testSearchNonExistentElement [

	queue enqueue: 'a'; enqueue: 'b'; enqueue: 'c'.
	
	self assert: (queue search: 'x') equals: -1
]

{ #category : 'tests' }
CTQueueTest >> testSize [

	self assert: queue size equals: 0.
	queue enqueue: 'a'.
	self assert: queue size equals: 1.
	queue enqueue: 'b'; enqueue: 'c'.
	self assert: queue size equals: 3.
	queue dequeue.
	self assert: queue size equals: 2
]
