//
//  RingBuffer.swift
//  DevPulse
//
//  Created by Nikhil Rastogi on 9/28/26.
//

import Foundation

public struct RingBuffer<Element: Sendable> : Sendable, Sequence {
    public let capacity: Int
    private var buffer: [Element?]
    private var writeIndex: Int = 0
    public private(set) var count: Int = 0
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.buffer = Array(repeating: nil, count: capacity)
    }
    
    public mutating func append(_ element: Element) {
        count = Swift.min(count + 1, capacity)
        buffer[writeIndex]  = element
        writeIndex = (writeIndex + 1) % capacity
    }
    
    public var allElements: [Element] {
        if isFull {
            let oldestToEnd = buffer[writeIndex..<capacity]
            let startToNewest = buffer[0..<writeIndex]
            return (oldestToEnd + startToNewest).compactMap { $0 }
        } else {
            return buffer[0..<count].compactMap { $0 }
        }
    }
    
    
    public var isFull: Bool {
        count == capacity
    }
    
    public func makeIterator() -> some IteratorProtocol<Element> {
        return RingBufferIterator(ring: self)
    }
    
    public struct RingBufferIterator: IteratorProtocol {
        
        private let ring: RingBuffer<Element>
        private var offset: Int = 0
        
        init(ring: RingBuffer<Element>) {
            self.ring = ring
        }
        
        public mutating func next() -> Element? {
            guard offset < ring.count else { return nil }
            defer { offset += 1}
            
            let startIndex = ring.isFull ? ring.writeIndex : 0
            let physicalIndex = (startIndex + offset) % ring.capacity
            return ring.buffer[physicalIndex]
        }
    }
}
