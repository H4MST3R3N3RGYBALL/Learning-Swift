//
//  ContentView.swift
//  WeSplit
//
//  Created by h4mst3r on 11/30/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercent = 20
    
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numOfPeople + 2)
        let perPerson = grandTotal / peopleCount
        
        return perPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .foregroundColor((tipPercent == 0) ? .red : .blue)
                } header: {
                    Text("Total amount on bill")
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercent) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                    .foregroundColor((tipPercent == 0) ? .red : .black)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                
                Section {
                    Picker("Number of people", selection: $numOfPeople) {
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Text(grandTotal, format: currencyCode)
                } header: {
                    Text("Grand Total")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
