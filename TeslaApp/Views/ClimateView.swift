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
                self.activeId = title
                self.isActive = true
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
                            prgoress = 0.0
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
            .background(Color.background)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .innerShadow(shape: RoundedRectangle(cornerRadius: 20), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 1, blendMode: .overlay)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
