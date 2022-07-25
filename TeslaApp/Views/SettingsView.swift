//
//  SettingsView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 18/07/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }){
                    GeneralButton(icon: "chevron.left")}
                Spacer()
            }
            .padding()
            
            Image("car_gray")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button(action: {}){
                SettingItem(icon: "bolt.batteryblock.fill", text: "Energy", subText: "32.8 kWh Genereated Today")
                
            }
            Button(action: {}){
            SettingItem(icon: "leaf.fill", text: "Impact", subText: "100% Self Powered Today")
            }
            Button(action: {}){
            SettingItem(icon: "gearshape.fill", text: "Settings")
            }
            Button(action: {}){
            SettingItem(icon: "wrench.fill", text: "Support")
            }
            Spacer()
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.background)
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingItem: View {
    var icon: String
    var text: String
    var subText: String = ""
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            Image( systemName: icon)
                .imageScale(.large)
                .opacity(0.5)
            VStack(alignment: .leading, spacing: 6){
               Text(text)
                    .font(.headline)
                    .fontWeight(.semibold)
                if !subText.isEmpty {
                Text(subText)
                    .font(.footnote)
                    .opacity(0.5)
                }
            }
        }
        .foregroundColor(Color.white)
        .padding(.horizontal)
        .padding(.vertical,8)
    }
}
