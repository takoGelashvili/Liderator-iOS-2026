//
//  Clamping.swift
//  Helpers
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

@propertyWrapper
struct Clamping<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>
    
    init(wrappedValue: Value, in range: ClosedRange<Value>) {
        self.value = range.clamped(value: wrappedValue)
        self.range = range
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = range.clamped(value: newValue) }
    }
}

extension ClosedRange {
    func clamped(value: Bound) -> Bound {
        guard value > lowerBound else { return lowerBound }
        guard value < upperBound else { return upperBound }
        
        return value
    }
}
