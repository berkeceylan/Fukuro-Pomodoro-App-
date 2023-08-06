//
//  SplashScreenView.swift
//  PomoApp
//
//  Created by Berke Ceylan on 6.08.2023.
//


    import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        }
        else{
            ZStack{
                Color("green").edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(alignment: .center){
                        Image("owl1")
                            .font(.system(size: 80))
                        Text("OWL")
                            .font(.system(size: 80, weight:.bold, design: .rounded))
                            //.foregroundColor(Color("orange").opacity(0.80))
                            .foregroundColor(.black.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            print("Switching to ContentView")
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
