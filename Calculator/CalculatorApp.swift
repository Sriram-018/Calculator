//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Sriram R on 06/07/23.
//

import SwiftUI

@main
struct CalculatorApp: App {
    private let data = CalculatorData()
    var body: some Scene {
        WindowGroup {
            ContentView(data)
        }
    }
}
