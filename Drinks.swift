//
//  Drinks.swift
//  NapMonitor
//
//  Created by Arwin Krishnan on 04/03/2020.
//  Copyright © 2020 Arwin Krishnan. All rights reserved.
//

import SwiftUI

struct Drinks: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    @EnvironmentObject var appState: AppState
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ??
            Date()
        
        
    }
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                Image("Coffee")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .padding()
                
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Daily coffee intake")
                    .font(.headline)
                
                Stepper (value: $coffeeAmount, in: 0...20) {
                    if coffeeAmount == 1 {
                        Text("1 cup")
                    } else {
                        Text("\(coffeeAmount) cups")
                        
                    }
                }
                .padding()
                .frame(maxWidth: 400)
                
            }
            Button(action: {
                self.appState.moveToDashboard = true
            }) {
                Text("Dismiss")
                    
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .padding()
                
            }
                
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
                    
                }
                
            )
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                
            }
            .padding(.vertical, 8)
            
            
        }
        
    }
    
    
    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            
        }
        
        showingAlert = true
        
    }
    
}

struct Drinks_Previews: PreviewProvider {
    static var previews: some View {
        Drinks()
        
    }
}

