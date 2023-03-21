//
//  ControlsComponents.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import SwiftUI

struct IconButton: View {
    var icon: String
    var text: String
    var body: some View {
        Button(action: {}){
            //PENDO CHANGE: The labels should be inside Button to make them all clickable
            Label(text, systemImage: icon)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.white.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
    }
}
