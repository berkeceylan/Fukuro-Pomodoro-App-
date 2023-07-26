//
//  ContentView.swift
//  PomoApp
//
//  Created by Berke Ceylan on 26.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State var countDownInMinutes = 25 * 60
    @State var userInput = 25
    @State var timerRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var minutes: Int{
        return countDownInMinutes/60
    }
    
    var seconds: Int {
        return countDownInMinutes%60
    }
    
    var body: some View {
        VStack{
            Text("\(minutes):\(seconds < 10 ? "0" : "")\(seconds)")
                .onReceive(timer){ _ in
                    if countDownInMinutes > 0 && timerRunning == true{
                        countDownInMinutes -= 1
                    }
                    else{
                        timerRunning = false
                    }
                }
                .font(.system(size: 80, weight: .bold))
                .opacity(0.80)
            
            Stepper(value: $userInput, in: 1...60, step: 1){
                Text("Set Countdown")
            }
            .padding()
            .onChange(of: userInput){
                munitesValue in
                countDownInMinutes = munitesValue * 60
                
            }
            
            HStack(spacing: 30){
                Button("Start"){
                    timerRunning = true
                }
                
                Button("Reset"){
                    countDownInMinutes = 25 * 60
                    userInput = 25
                    timerRunning = false
                }.foregroundColor(.red)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
