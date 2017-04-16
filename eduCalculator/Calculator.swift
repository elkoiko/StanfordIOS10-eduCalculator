//
//  Calculator.swift
//  eduCalculator
//
//  Created by Thomas Couacault on 12/04/2017.
//  Copyright © 2017 Thomas Couacault. All rights reserved.
//

import Foundation

struct Calculator {
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private let operations: [String: Operation] = [
        "π": .constant(Double.pi),
        "%": .unaryOperation({ $0 / 100.0 }),
        "∓": .unaryOperation({ -$0 }),
        "×": .binaryOperation({ $0 * $1 }),
        "÷": .binaryOperation({ $0 / $1 }),
        "-": .binaryOperation({ $0 - $1 }),
        "+": .binaryOperation({ $0 + $1 }),
        "=": .equals
    ]
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let operation: (Double, Double) -> Double
        
        func performBinaryOperation(with secondOperand: Double) -> Double {
            return operation(firstOperand, secondOperand)
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    mutating func performPendingBinaryOperation(secondOperand: Double) {
        accumulator = pendingBinaryOperation?.performBinaryOperation(with: secondOperand)
        pendingBinaryOperation = nil
    }
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
                case .constant(let value):
                    accumulator = value
                case .unaryOperation(let function):
                    if accumulator != nil {
                        accumulator = function(accumulator!)
                    }
                case .binaryOperation(let function):
                    if accumulator != nil {
                        pendingBinaryOperation = PendingBinaryOperation(firstOperand: accumulator!, operation: function)
                        accumulator = nil
                    }
                case .equals:
                    if accumulator != nil {
                        performPendingBinaryOperation(secondOperand: accumulator!)
                    }
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
}
