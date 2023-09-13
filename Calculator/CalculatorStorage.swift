//
//  File.swift
//  Calculator
//
//  Created by Sriram R on 06/07/23.
//

import Foundation

struct CalculatorStorage {
    
    private var curIndex = 0
    private var operands = [Int:Double]()
    private var operators = [Int:String]()
    private(set) var displayView: String = "0"
    
    mutating func addOperand(_ value: Double) {
        if operands.isEmpty || !(operands.contains(where: {$0.key == curIndex-1})){
            operands[curIndex] = value
            curIndex += 1
            updateDisplay()
        } else {
            operands[curIndex-1] = operands[curIndex-1]! * 10 + value
        }
        updateDisplay()
    }
    
    mutating func addOperator(_ value: String){
        if operands.keys.contains(curIndex-1){
            operators[curIndex] = value
            curIndex += 1
            updateDisplay()
        }
    }
    
    mutating func updateDisplay(){
        displayView = "0"
        for x in (0..<curIndex){
            if operands.keys.contains(x){
                if floor(operands[x]!) == (operands[x]!){
                    if displayView == "0"{
                        displayView = "\(Int(operands[x]!))"
                    } else {
                        displayView += "\(Int(operands[x]!))"
                    }
                } else{
                    if displayView == "0"{
                        displayView = "\(operands[x]!)"
                    } else {
                        displayView += "\(operands[x]!)"
                    }
                }
            } else if operators.keys.contains(x){
                displayView += operators[x]!
            }
            
        }
    }
    
    mutating func clearAll(){
        curIndex = 0
        operands = [Int:Double]()
        operators = [Int:String]()
        displayView = "0"
    }
    
    mutating func calculate(){
        if operands.keys.contains(curIndex-1){
            let postfix = postifxOf(operands, operators)
            let result = calculatePostfix(with: postfix.numbers, postfix.operators)
            if floor(result) == (result){
                displayView = "\(Int(result))"
            } else{
                displayView = "\(result)"
            }
            operands = [0: result]
            operators = [Int:String]()
            curIndex = 1
        }
    }
    
    private func postifxOf(_ numbers: [Int: Double], _ operators: [Int: String]) -> (numbers: [Int: Double], operators: [Int: String]) {
        var outputNumbers: [Int: Double] = [:]
        var outputOperators: [Int: String] = [:]
        var stack = [String]()
        var index = 0
        for valueCount in (0..<curIndex){
            if numbers.keys.contains(valueCount){
                outputNumbers[index] = numbers[valueCount]
                index += 1
            } else{
                let char = operators[valueCount]!
                if stack.isEmpty{
                    stack.append(char)
                } else if getPrecedence(stack.last!) < getPrecedence(char){
                    stack.append(char)
                } else{
                    while getPrecedence(stack.last!) >= getPrecedence(char){
                        outputOperators[index] = stack.popLast()
                        index += 1
                        if stack.isEmpty{break}
                    }
                    stack.append(char)
                }
            }
        }
        while !(stack.isEmpty){
            outputOperators[index] = stack.popLast()
            index += 1
        }
        return (numbers: outputNumbers, operators: outputOperators)
    }
    
    private func calculatePostfix(with numbers: [Int:Double], _ operators: [Int: String]) -> Double {
        var stack: [Double] = []
        var index = 0
        for valueCount in (0..<curIndex){
            if numbers.keys.contains(valueCount){
                stack.append(numbers[valueCount]!)
                index += 1
            } else{
                let num2 = stack.popLast()!
                let num1 = stack.popLast()!
                stack.append(performOperation(operators[valueCount]!, operand1: num1, operand2: num2))
            }
        }
        return stack.first!
    }
    private func getPrecedence(_ char: String) -> Int {
        switch char {
        case "+", "-":
            return 1
        case "*", "/":
            return 2
        default:
            return 0
        }
    }
    private func performOperation(_ operatorChar: String, operand1: Double, operand2: Double) -> Double {
        switch operatorChar {
        case "+":
            return operand1 + operand2
        case "-":
            return operand1 - operand2
        case "*":
            return operand1 * operand2
        case "/":
            return operand1 / operand2
        default:
            return 0
        }
    }
    
}

