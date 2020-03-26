//
//  SleepAmount.swift
//  NapMonitor
//
//  Created by Arwin Krishnan on 04/03/2020.
//  Copyright © 2020 Arwin Krishnan. All rights reserved.
//

import SwiftUI

struct SleepAmount: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
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
                Image("SleepWoman1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .padding()
                Spacer()
                Spacer()
                
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                    
                }
            }
            
            NavigationLink(destination: Drinks()) {
                Text("Next")
                    
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                    .padding()
            }
        }
    }
}

struct SleepAmount_Previews: PreviewProvider {
    static var previews: some View {
        SleepAmount()
    }
}

