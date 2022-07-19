//
//  ControlsView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI

struct ControlsView: View {
    @Environment(\.presentationMode) var presentation
    @State private var status = false
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,  spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        GeneralButton(icon: "chevron.left")}
                    Spacer()
                }
                Text("Car Controls")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                IconButton(icon: "lock.fill", text: "Unlock Car")
                
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
                CarControlsActionView()
                Divider()
                    .background(Color.white)
                    .opacity(0.4)
            }.padding()
            
            Toggle(isOn: $status){
                Text("Valet Mode")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
            
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.background)
        .backgroundBlur(radius: 10, opaque: true)
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
        
        
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}


struct CarControlsActionView: View {
    var body: some View {
        VStack(spacing: 15){
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                ActionItem(icon: "flashlight.on.fill", text: "Flash")
                ActionItem(icon: "speaker.wave.2.fill", text: "Hank")
                ActionItem(icon: "key.fill", text: "Start")
                Spacer()
            }
            .padding()
            
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                ActionItem(icon: "arrow.up.bin", text: "Front Trunk")
                ActionItem(icon: "arrow.up.square", text: "Trunk")
                
                Spacer()
            }
            .padding()
        }
    }
}
