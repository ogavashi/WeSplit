//
//  ContentView.swift
//  WeSplit
//
//  Created by Oleg Gavashi on 11.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var totalCheck = 0.0
    @State private var amountOfPeople = 0
    @State private var tipPercent = 10
    
    @FocusState private var amountIsFocused: Bool
    
    
    var totalWithTip: Double {
        totalCheck + totalCheck * Double(tipPercent) / 100
    }
    
    var totalPerPerson: Double {
         totalWithTip / Double(amountOfPeople + 2)
    }
    
    let tipsOptions = [0, 10, 15, 20, 25]
    let currencyCode  = Locale.current.currency?.identifier ?? "UAH"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $totalCheck, format:
                            .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Amount of people", selection: $amountOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(tipsOptions, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalWithTip, format:
                            .currency(code: currencyCode))
                } header: {
                    Text("Total amount with tip included")
                }
                Section {
                    Text(totalPerPerson, format:
                            .currency(code: currencyCode))
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
