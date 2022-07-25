//
//  ClimateView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 18/07/22.
//

import SwiftUI
import Sliders

enum Climate: String {
    case ac = "Ac"
    case fan = "Fan"
    case heat = "Heat"
    case auto = "Auto"
}

struct ClimateView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var progress: Double = 0.1
    @State var fanProgress: Double = 0
    func resetProgress() {
        progress = 0.1
    }
    
    
    @State var value = 0.1
    @State var activeId: String = ""
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        GeneralButton(icon: "chevron.left")}
                    Spacer()
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        GeneralButton(icon: "gear")
                    }
                }
                Spacer()
                CircleProgressView(progress: $progress)
                    .frame(width: 200, height: 200)
                
                Spacer()
                ScrollView {
                    VStack(spacing: 50) {
                ControlWidget(progress: $progress, title: Climate.ac.rawValue, icon: "snowflake", activeId: $activeId, isActive: $isActive)
                ControlWidget(progress: $progress, title: Climate.fan.rawValue, icon: "wind", activeId: $activeId, isActive: $isActive)
                ControlWidget(progress: $progress, title: Climate.heat.rawValue, icon: "humidity.fill", activeId: $activeId, isActive: $isActive)
                ControlWidget(progress: $progress, title: Climate.auto.rawValue, icon: "timer", activeId: $activeId, isActive: $isActive)
                    }
                }
                Spacer()
            }
            .padding()
            
            if (isActive) {
                ClimateWidget(open: $isActive, prgoress: $progress, activeId: $activeId, isActive: $isActive)
                    .zIndex(1)
                    .transition(.opacity)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
  
    
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView()
    }
}

struct CircleProgressView: View {
    @Binding var progress: Double
    var body: some View {
        ZStack {
            
            Image("progress_bg")
            
            Circle()
                .stroke(
                    Color("Background").opacity(0.5),
                    lineWidth: 20
                )
                .frame(width: 145, height: 145)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.lockGradient,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .frame(width: 165, height: 165)
                .rotationEffect(.degrees(-90))
            // 1
                .animation(.easeOut, value: progress)
            
            Text("\(Int(progress * 100))º C")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
        }
    }
}

