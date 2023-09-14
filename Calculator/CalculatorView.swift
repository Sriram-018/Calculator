//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by Sriram R on 06/07/23.
//

import SwiftUI

struct CalculatorView: View {
    
    @ObservedObject private var data: CalculatorData
    init(_ data: CalculatorData) {
        self.data = data
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.height, geometry.size.width) * 0.2
            VStack(spacing: 5){
                HStack {
                    Spacer()
                    // ** is present to make the text bold.
                    Text("**\(data.displayView())**")
                }
                .padding()
                .frame(width: size * 4 + 20, height: size)
                .background(.white)
                .foregroundColor(.orange)
                .font(.system(size: size * 0.5))
                .cornerRadius(10)
                .contrast(0.85)
                
                HStack(spacing: 5){
                    OperandButton(1, size)
                    OperandButton(2, size)
                    OperandButton(3, size)
                    OperatorButton("AC", size)
                }
                HStack(spacing: 5){
                    OperandButton(4, size)
                    OperandButton(5, size)
                    OperandButton(6, size)
                    OperatorButton("/", size)
                }
                HStack(spacing: 5){
                    OperandButton(7, size)
                    OperandButton(8, size)
                    OperandButton(9, size)
                    OperatorButton("*", size)
                }
                HStack(spacing: 5){
                    OperandButton(0, size)
                    OperatorButton("+", size)
                    OperatorButton("-", size)
                    OperatorButton("=", size)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func OperandButton(_ value: Double, _ size: CGFloat) -> some View{
        Button("\(Int(value))"){
            data.addOperand(value)
        }
            .font(.system(size: size * 0.3))
            .frame(width: size, height: size)
            .background(.orange)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    
    func OperatorButton(_ value: String, _ size: CGFloat) -> some View{
        Button(value){
            if value == "AC"{
                data.clearAll()
            } else if value == "="{
                data.calculate()
            } else{
                data.addOperator(value)
            }
        }
            .font(.system(size: size * 0.3))
            .frame(width: size, height: size)
            .background(.orange)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
    
}
