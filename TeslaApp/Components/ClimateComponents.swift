//
//  ClimateComponents.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 2022/7/25.
//

import SwiftUI
import Sliders


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
    @Binding var activeId: String
    @Binding var isActive: Bool
    
    @State var localProgress: Double = 0.0
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(self.activeId == title ? Color.white : Color.white.opacity(0.6))
                .frame(width: 50)
            
            Button(action: {
                withAnimation {
                    self.activeId = title
                    self.isActive = true
                }
                
            }){
                Circle()
                    .foregroundColor(Color("Background"))
                    .overlay(
                        
                        Image(systemName: icon)
                            .font(.system(size: 23))
                            .foregroundColor(activeId == title ? Color("lock_green_1") : Color.white.opacity(0.7))
                    )
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 0)
            }
            if activeId == title {
                ProgressWidget(progress: $progress)
                    
            }
            else {
            ProgressWidget(progress: $localProgress)
                .allowsHitTesting(false)
            }
        }
        .padding(.horizontal, 6)
        .foregroundColor(Color.white)
    }
}


struct ClimateWidget: View {
    @Binding var open: Bool
    @Binding var prgoress: Double
    @Binding var activeId: String
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment:.leading, spacing: 20){
                HStack(alignment: .center, spacing: 15) {
                    Button(action: {
                        withAnimation {
                            prgoress = 0.1
                            open = false
                            activeId = ""
                            isActive = false
                        }
                    }){
                    Image(systemName: "power")
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    Spacer()
                    Image(systemName: "chevron.backward")
                    Text("\(Int(prgoress * 100))°")
                        .font(.system(size: 22))
                    Image(systemName: "chevron.forward")
                    Spacer()
                    Image(systemName: "dot.radiowaves.up.forward")
                }
                .imageScale(.large)
                .font(.system(size: 20, weight: .bold, design: .default))
                
                
                //MARK: -
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
                
                HStack {
                    Text("On")
                    Spacer()
                    Text("Vent")
                        .opacity(0.6)
                }
                .padding(.vertical)
               
                    
            }
            .padding(20)
            .foregroundColor(Color.white)
            .background(Color.lockGradient)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .innerShadow(shape: RoundedRectangle(cornerRadius: 20), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 1, blendMode: .overlay)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
