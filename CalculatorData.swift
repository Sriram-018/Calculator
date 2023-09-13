//
//  AppData.swift
//  Calculator
//
//  Created by Sriram R on 06/07/23.
//

import Foundation

class CalculatorData: ObservableObject {
    @Published private var modal = CalculatorStorage()
    func displayView() -> String{modal.displayView}
    func addOperand(_ value: Double) {modal.addOperand(value)}
    func addOperator(_ value: String) {modal.addOperator(value)}
    func clearAll() {modal.clearAll()}
    func calculate() {modal.calculate()}
}
