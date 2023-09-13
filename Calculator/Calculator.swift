//
//  ContentView.swift
//  Calculator
//
//  Created by Sriram R on 06/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var data: CalculatorData
    init(_ data: CalculatorData){
        self.data = data
    }
    var body: some View {
        CalculatorView(data)
    }
}
