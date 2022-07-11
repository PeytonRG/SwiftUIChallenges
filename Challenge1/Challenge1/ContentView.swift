//
//  ContentView.swift
//  Challenge1
//
//  Created by Peyton Gasink on 7/10/22.
//

import SwiftUI

enum Temperatures: String, CaseIterable {
    case celsius = "Celsius",
         fahrenheit = "Fahrenheit",
         kelvin = "Kelvin"
}

struct ContentView: View {
    @State private var inputUnit = Temperatures.celsius
    @State private var inputTemp = 0.0
    @State private var outputUnit = Temperatures.fahrenheit
    
    @FocusState private var inputTempFocused: Bool
    
    var outputTemp: Double {
        // Don't bother converting if same unit
        if inputUnit == outputUnit {
            return inputTemp
        }
        
        // Convert everything to Celsius as a starting point
        var inputTempCelsius: Double
        switch inputUnit {
            case Temperatures.celsius:
                inputTempCelsius = inputTemp
            case Temperatures.fahrenheit:
                inputTempCelsius =  (inputTemp - 32) * 5 / 9
            case Temperatures.kelvin:
                inputTempCelsius = inputTemp - 273.15
        }
        
        // Convert from Celsius to whatever
        switch outputUnit {
            case .celsius:
                return inputTempCelsius
            case .fahrenheit:
                return inputTempCelsius * 9 / 5 + 32
            case .kelvin:
                return inputTempCelsius + 273.15
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input temperature", value: $inputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputTempFocused)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(Temperatures.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            header: {
                Text("Input Temperature")
            }
                
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(Temperatures.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(outputTemp, format: .number)
                }
            header: {
                Text("Output Temperature")
            }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputTempFocused = false
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
