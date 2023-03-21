//
//  HomeComponents.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI



struct GeneralButton: View {
    var icon: String
    var body: some View {
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.07), in: Circle())
            .innerShadow(shape: Circle(), color: .white.opacity(0.25), lineWidth: 2, offsetX: 1, offsetY: 1, blur: 1, blendMode: .luminosity)
    }
}

struct ActionViewHeader: View {
    var title: String
    var isEdit: Bool = false
    
    var body: some View {
        HStack(alignment: .center){
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if isEdit{
                Button {
                    
                } label: {
                    Text("Edit")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }
            }
            
        }.padding(.top)
    }
}


struct ActionItem: View {
    var icon: String
    var text: String
    var body: some View {
        VStack(alignment: .center, spacing: 5){
            
            GeneralButton(icon: icon)
            Text(text)
                .frame(width: 75)
                .font(.system(size: 12, weight: .semibold, design: .default))
                .multilineTextAlignment(.center)
        }
        .modifier(ClearColor())
        // PENDO CHANGE: Adding background
    }
}


