//
//  ActionComponents.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI

struct ActionNotification: View {
    @Binding var open: Bool
    var icon: String
    var text: String
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: icon)
                    .imageScale(.large)
                Text(text)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    withAnimation {
                        open = false
                    }
                }){
                    Text("Cancel")
                        .foregroundColor(Color.white.opacity(0.7))
                }
                
            }
            .padding(20)
            .foregroundColor(Color.white)
            .background(Color.lockGradient)
            .backgroundBlur(radius: 10, opaque: true)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding()
        
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct VoiceWidget: View {
    
    @Binding var open: Bool
    var text: String = "Go to time square"
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing:0) {
                
                Image("voice_bg")
                    .aspectRatio(contentMode: .fill)
                HStack(alignment: .center) {
                    Image(systemName: "mic.fill")
                        .imageScale(.large)
                        .font(.system(size: 24))
                    Text(text)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            open = false
                        }
                    }){
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 64))
                        .padding(.bottom,6)
                    }
                }
                .foregroundColor(Color.black)
                .padding()
                .background(Color("Green"))
                
                
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct MediaPlayerWidget: View {
    @State private var value: Double = 0.4
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20){
                //MARK: - Information
                HStack(alignment: .center){
                   
                    Image(systemName: "square.fill")
                        .font(.system(size: 64))
                        .frame(width: 64, height: 64)
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Don’t take the Money")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text("Bleachers – Gone Now")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .opacity(0.6)
                    }
                    Spacer()
                }
                //MARK: - Play time
                VStack{
                    HStack{
                        Text("1.05")
                        Spacer()
                        Text("-3.03")
                            
                    }
                    .font(.system(size: 14, weight: .medium, design: .default))
                    .opacity(0.6
                    )
                    Slider(value: $value)
                        .tint(Color("Green"))
                        .padding(.top, -10)
                }
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
                
                //MARK: - Controls
                HStack(alignment: .center){
                    HStack(spacing: 10){
                        Button(action: {}){
                        Image(systemName: "backward.fill")
                                .font(.system(size: 20))
                            .opacity(0.7)
                        }
                        Button(action: {}){
                        Image(systemName: "playpause.fill")
                                .font(.system(size: 20))
                        }
                        Button(action: {}){
                        Image(systemName: "forward.fill")
                                .font(.system(size: 20))
                            .opacity(0.7)
                        }
                    }
                    Spacer()
                    HStack(spacing: 10){
                        Button(action: {}){
                        Image(systemName: "minus")
                                .font(.system(size: 20))
                            .opacity(0.7)
                        }
                        
                        RadialGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.2)]), center: .leading, startRadius: 30, endRadius: 32)
                                .frame(width: 44, height: 44)
                                .mask {
                                    Button(action: {}){
                                        Image(systemName: "speaker.wave.3.fill")
                                                .font(.system(size: 20))
                                        }
                                }
                        
                        Button(action: {}){
                        Image(systemName: "plus")
                                .font(.system(size: 20))
                            .opacity(0.7)
                        }
                    }
                }
                .padding(.vertical)
            }
            .padding(20)
            .foregroundColor(Color.white)
            .background(Color.lockGradient)
            .backgroundBlur(radius: 12, opaque: true)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ChargingWidget: View {
    @Binding var open: Bool

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment:.leading, spacing: 20){
                //MARK: - Information
                VStack(alignment: .leading){
                   Label("237 miles", systemImage: "bolt.fill")
                        .foregroundColor(Color("Green"))
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                    Text("3h 55m remain – 32/3A – 30 mi/hour")
                        .font(.subheadline)
                        .fontWeight(.medium)
                  
                }
                //MARK: - Play time
                VStack(alignment: .leading, spacing: 5){
                    
                   Text("Charge Limit: 315 miles")
                        .font(.footnote)
                        .opacity(0.6)
                    ZStack(alignment: .leading){
                        Color.white.opacity(0.25)
                            .frame(height: 6)
                        Color("Green")
                            .frame(maxWidth: 240)
                            .frame(height: 6)
                            .clipShape(Capsule())
                        Color.white
                            .frame(width: 16, height: 16)
                            .clipShape(Circle())
                            .offset(x: 265)
                    }
                }
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
                
                //MARK: - Controls
                Button(action: {
                    withAnimation {
                        open = false
                    }
                }){
                    Text("Stop Chargin")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .padding(.vertical,8)
                        .padding(.horizontal, 20)
                        .background(Color("DarkRed"))
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                    
            }
            .padding(20)
            .foregroundColor(Color.white)
            .background(Color.lockGradient)
            .backgroundBlur(radius: 2, opaque: true)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
