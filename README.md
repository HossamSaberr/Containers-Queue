# Containers-Queue
A High-performance, Circular Array based Queue implementation providing efficient FIFO (First In, First Out) operations with dynamic capacity and proper error handling.

![Pharo Version](https://img.shields.io/badge/Pharo-10+-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## What is a Queue?

A Queue is a linear data structure that follows the FIFO (First In, First Out) principle. Elements are added at the rear (enqueue) and removed from the front (dequeue). Think of it like a line at a store - the first person in line is the first person served.

### Key Benefits
- **O(1) Performance**: Constant time enqueue, dequeue, and front operations
- **Dynamic Growth**: Circular array implementation that doubles capacity when needed
- **Memory Safe**: Automatic cleanup prevents memory leaks
- **Simple API**: Clean, intuitive interface following standard queue conventions
- **Robust Error Handling**: Proper empty queue protection with clear error messages

## Loading 
The following script installs Containers-Queue in Pharo.

```smalltalk
Metacello new
  baseline: 'ContainersQueue';
  repository: 'github://pharo-containers/Containers-Queue/src';
  load.
```

## If you want to depend on it 

Add the following code to your Metacello baseline or configuration 

```smalltalk
spec 
   baseline: 'ContainersQueue' 
   with: [ spec repository: 'github://pharo-containers/Containers-Queue/src' ].
```

## Quick Start

```smalltalk
"Create a queue with default capacity of 10"
queue := CTQueue new.

"Enqueue elements"
queue enqueue: 'first'.
queue enqueue: 'second'.
queue enqueue: 'third'.

"Check front element without removing"
queue front.         "Returns 'first'"
queue size.          "Returns 3"

"Dequeue elements (FIFO order)"
queue dequeue.       "Returns 'first'"
queue dequeue.       "Returns 'second'"  
queue dequeue.       "Returns 'third'"

"Queue is now empty"
queue isEmpty.       "Returns true"
```

## Contributing

This is part of the Pharo Containers project. Feel free to contribute by implementing additional methods, improving tests, or enhancing documentation.