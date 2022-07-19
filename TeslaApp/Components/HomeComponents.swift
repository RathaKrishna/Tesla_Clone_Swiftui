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
            .background(Color.white.opacity(0.07))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.05)))
        
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
    }
}


struct AllSettingsItem: View {
    var icon: String
    var text: String
    var subtitle: String = ""
    var isActive: Bool = false
    var body: some View {
        
        HStack(alignment: .center, spacing: 2) {
            Image(systemName: icon)
                .imageScale(.large)
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text(text)
                    .font(.body)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: false)
                if !subtitle.isEmpty {
                    Text(subtitle.uppercased())
                        .font(.system(size: 8, weight: .medium))
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
            .foregroundColor(Color.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.white)
                .opacity(0.6)
            
            
        }
        .padding(8)
        .frame(height: 70)
        .background(isActive ? Color.selectedGridBackgroud : Color.gridBackgroud)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            // MARK: Card Border
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.white.opacity(0.2))
                .blendMode(.overlay)
        }
        .backgroundBlur(radius: 25, opaque: true)
        
        .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 1, blendMode: .overlay)
        
    }
}
