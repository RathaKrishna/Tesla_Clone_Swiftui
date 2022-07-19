//
//  ClimateView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 18/07/22.
//

import SwiftUI
import Sliders

struct ClimateView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var progress: Double = 0.1
    @State var fanProgress: Double = 0
    func resetProgress() {
        progress = 0.1
    }
    
    
    @State var value = 0.1
    
    
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
                ControlWidget(progress: $progress, title: "Ac", icon: "snowflake", isActive: true)
                ControlWidget(progress: $fanProgress, title: "Fan", icon: "wind")
                ControlWidget(progress: $fanProgress, title: "Heat", icon: "humidity.fill")
                ControlWidget(progress: $fanProgress, title: "Auto", icon: "timer")
                Spacer()
            }
            .padding()
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


struct KnobWidget: View {
    var body: some View {
        ZStack {
            Image(systemName: "capsule.fill")
                .imageScale(.large)
                .font(.system(size: 20))
                .foregroundColor(Color("Background"))
                .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
            Image(systemName: "line.3.horizontal")
                .imageScale(.small)
                .foregroundColor(Color.white.opacity(0.4))
                .rotationEffect(.degrees(90))
            
        }
    }
}



struct ProgressWidget: View {
    
    @Binding var progress: Double
    
    var body: some View {
        ZStack{
            Color.white.opacity(0.1)
                .frame(height: 12)
                .mask(Capsule())
            ValueSlider(value: $progress)
                .valueSliderStyle(HorizontalValueSliderStyle(
                    track:
                        HorizontalValueTrack(
                            view: Color.lockGradient
                        )
                        .frame(height: 12)
                        .shadow(color: Color.white.opacity(0.6), radius: 5, x: 0, y: 0),
                    thumb: KnobWidget()
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0),
                    
                    thumbSize: CGSize(width: 32, height: 32)
                    
                ))
        }
        
    }
}


struct ControlWidget: View {
    @Binding var progress: Double
    var title: String
    var icon: String
    var isActive: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(isActive ? Color.white : Color.white.opacity(0.6))
                .frame(width: 50)
            
            Button(action: {}){
                Circle()
                    .foregroundColor(Color("Background"))
                    .overlay(
                        
                        Image(systemName: icon)
                            .font(.system(size: 23))
                            .foregroundColor(isActive ? Color("lock_green_1") : Color.white.opacity(0.7))
                    )
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
            }
            
            ProgressWidget(progress: $progress)
                .allowsHitTesting(isActive)
                
        }
        .padding(.horizontal, 6)
        .foregroundColor(Color.white)
    }
}
