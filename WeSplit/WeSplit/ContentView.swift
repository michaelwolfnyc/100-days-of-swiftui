//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Wolf on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    let minNumberOfPeople = 2
    let maxNumberOfPeople = 20
    
    var localCurrency : FloatingPointFormatStyle<Double>.Currency {
        let myCurrency = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency( code: myCurrency )
    }
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeopleIndex = 2
    @State private var tipPercentage = 20
    
    // @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 18, 20, 25]
    
    var totalPeople: Int {
        minNumberOfPeople + numberOfPeopleIndex
    }
    
    var totalPerPerson: Double {
        checkAmount * (1.0 + Double(tipPercentage)/100.0) / Double(totalPeople)
    }
    var body: some View {
        NavigationView {
            Form {
                Section("Amount of bill?") {
                    TextField("", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        //.focused($amountIsFocused)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Number of People?") {
                    Picker("", selection: $numberOfPeopleIndex) {
                        ForEach(minNumberOfPeople ..< maxNumberOfPeople) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                        .foregroundColor(Color.red)
                } header: {
                    Text("Each person contributes")
                } footer: {
                    Text("which includes the tip.")
                }
            }
                .navigationTitle("WeSplit")
                //.toolbar {
                //    ToolbarItemGroup(placement: .keyboard) {
                //        HStack {
                //            Spacer()
                //            Button("Done With Keyboard") {
                //                amountIsFocused = false
                //            }
                //       }
                //    }
                //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
