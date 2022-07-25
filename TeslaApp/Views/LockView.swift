//
//  LockView.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 18/07/22.
//

import SwiftUI

struct LockView: View {
    
    @Environment(\.presentationMode) var presentation
    @State private var isLocked = true
    
    var body: some View {
        ZStack{
            VStack( spacing: 20){
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }){
                        if isLocked {
                        GeneralButton(icon: "chevron.left")
                            
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Text(isLocked ? "Hi" : "")
                    .font(.title)
                    .opacity(0.7)
                    .transition(.move(edge: .trailing))
               

                Text(isLocked ? "Welcome back" : "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .transition(.move(edge: .trailing))
                   
                    
                Image(isLocked ? "lock_bg" : "unlock_bg")
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .transition(.move(edge: .bottom))
                   
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isLocked = !isLocked
                    }
                    
                }){
                HStack(spacing: 40) {
                    Text(isLocked ? "Lock" : "Unlock")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    RadialGradient(gradient: Gradient(colors: [ Color("lock_green_1"),Color("lock_green_2"), Color.white]), center: .topLeading, startRadius: 30 , endRadius: 40)
                        .frame(width: 44, height: 44)
                        .mask {
                            
                            GeneralButton(icon: isLocked ? "lock.open.fill" : "lock.fill")
                        }
                    
                        
                }
                .padding()
                .frame(height: 60)
                .background(Color.gridBackgroud)
                .clipShape(Capsule())
                .overlay {
                    // MARK: Card Border
                    Capsule()
                        .strokeBorder(.white.opacity(0.2))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: Capsule(), color: .white.opacity(0.25), lineWidth: 1, offsetX: 1, offsetY: 1, blur: 1, blendMode: .overlay)
                }
                .animation(.interactiveSpring(), value: isLocked)
                .padding()
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(isLocked ? Color("Background") : Color.black)
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}

struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView()
    }
}
