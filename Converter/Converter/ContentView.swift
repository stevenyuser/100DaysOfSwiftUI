//
//  ContentView.swift
//  Converter
//
//  Created by Steven Yu on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var inputNumber = ""
    
    var outputNumber: Double {
        let temperature = Double(inputNumber) ?? 0
        
        switch units[inputUnit] {
        case "Celsius":
            switch units[outputUnit] {
            case "Farenheit":
                return (temperature * 9/5) + 32
            case "Kelvin":
                return temperature + 273.15
            default:
                return temperature
            }
        case "Farenheit":
            switch units[outputUnit] {
            case "Celsius":
                return (temperature - 32) * 5/9
            case "Kelvin":
                return (temperature - 32) * 5/9 + 273.15
            default:
                return temperature
            }
        case "Kelvin":
            switch units[outputUnit] {
            case "Celsius":
                return temperature - 273.15
            case "Farenheit":
                return (temperature - 273.15) * 9/5 + 32
            default:
                return temperature
            }
        default:
            return 0
        }
    }
    
    let units = ["Celsius", "Farenheit", "Kelvin"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", text: $inputNumber)
                        .keyboardType(.decimalPad)
                    
                    Picker("Original Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted Temperature")) {
                    Text("\(outputNumber, specifier: "%.1f")")
                    Picker("Original Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Convert Temperature")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
