//
//  ContentView.swift
//  NapMonitor
//
//  Created by Arwin Krishnan on 03/03/2020.
//  Copyright © 2020 Arwin Krishnan. All rights reserved.
//

import SwiftUI


struct ContentView: View {   
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @EnvironmentObject var appState: AppState
    @State var isSleepAmountActive: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ??
            Date()
    }
    
    var body: some View {
        
        ZStack {
            
            Color.blue
            
            NavigationView {
                
                VStack {
                    GeometryReader { geo in
                        Image("AlarmClock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width)
                    }
                    
                    VStack{
                        VStack(alignment: .leading, spacing: 0){
                            Text("When do you want to wake up?")
                                .font(.headline)
                                .padding()
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                            
                        }
                            
                        .padding(.trailing)
                        
                    }
                    
                    NavigationLink(destination: SleepAmount(), isActive: $isSleepAmountActive) {
                        Text("Next")
                            
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .padding()
                    }
                    .isDetailLink(false)
                }
                .onReceive(self.appState.$moveToDashboard) { moveToDashboard in
                    if moveToDashboard {
                        self.isSleepAmountActive = false
                        self.appState.moveToDashboard = false
                    }
                    
                }
                    
                .navigationBarTitle("Nap Estimation")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
        
    }
}
