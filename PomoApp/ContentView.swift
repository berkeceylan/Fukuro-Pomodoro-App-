//
//  ContentView.swift
//  PomoApp
//
//  Created by Berke Ceylan on 26.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State var sessionInMinutes = 25 * 60
    @State var breakInMinutes = 5 * 60
    @State var sessionTime = 25
    @State var breakTime = 5
    @State var isSession = false
    @State var isBreak = false
    @State var isPaused = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var sessionMinutes: Int {
        return sessionInMinutes / 60
    }
    
    var sessionSeconds: Int {
        return sessionInMinutes % 60
    }
    
    var breakMinutes: Int {
        return breakInMinutes / 60
    }
    
    var breakSeconds: Int {
        return breakInMinutes % 60
    }
    
    var body: some View {
        VStack {
            
                
            VStack(alignment: .center) {
                // Display for Session Time
                Text("Session Time")
                    .font(.headline)
                Text("\(sessionMinutes):\(sessionSeconds < 10 ? "0" : "")\(sessionSeconds)")
                    .font(.system(size: 80, weight: .bold))
                    .opacity(0.80)
            }
            .padding()
            
            VStack(alignment: .center) {
                // Display for Break Time
                Text("Break Time")
                    .font(.headline)
                Text("\(breakMinutes):\(breakSeconds < 10 ? "0" : "")\(breakSeconds)")
                    .font(.system(size: 40, weight: .bold))
                    .opacity(0.80)
            }
            .padding()
                    
            
            
            Stepper(value: $sessionTime, in: 1...60, step: 1) {
                Text("Set Session Time")
            }
            .padding()
            .onChange(of: sessionTime) { sessionValue in
                sessionInMinutes = sessionValue * 60
            }
            
            Stepper(value: $breakTime, in: 1...60, step: 1) {
                Text("Set Break Time")
            }
            .padding()
            .onChange(of: breakTime) { breakValue in
                breakInMinutes = breakValue * 60
            }
            
            HStack(spacing: 30) {
                if isPaused == false && (isSession == false && isBreak == false){
                    Button("Start") {
                        isPaused = false
                        isSession = true
                    }
                }
                else if (isSession == true || isBreak == true) && isPaused == false{
                    Button(action:{ isPaused = true}){Text("Pause")}
                }
                else if isPaused == true && (isSession == true || isBreak == true ){
                    Button(action:{isPaused = false}){Text("Resume")}
                }
                
                
                Button("Reset") {
                    sessionInMinutes = sessionTime * 60
                    breakInMinutes = breakTime * 60
                    isPaused = false
                    isSession = false
                    isBreak = false
                }
                .foregroundColor(.red)
            }
        }
        .onReceive(timer) { _ in
            if isPaused == false{
                if isSession {
                    if sessionInMinutes > 0 {
                        sessionInMinutes -= 1
                    }
                    else {
                        isSession = false
                        isBreak = true
                        breakInMinutes = breakTime * 60
                        NotificationManager.shared.sendNotification(title: "Session Ended", body: " Time for a break!", delay: 1)
                    }
                }
                else if isBreak {
                    if breakInMinutes > 0 {
                        breakInMinutes -= 1
                    }
                    else {
                        isSession = true
                        isBreak = false
                        sessionInMinutes = sessionTime * 60
                        NotificationManager.shared.sendNotification(title: "Break Ended", body: "Time to get back to work!", delay: 1)
                    }
                }
            }
        }
        .onAppear {
            NotificationManager.shared.requestNotificationPermisson()
            UNUserNotificationCenter.current().delegate = NotificationManager.shared.notificationDelegate
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
