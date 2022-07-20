//
//  Extensions.swift
//  TeslaApp
//
//  Created by Rathakrishnan Ramasamy on 16/07/22.
//

import Foundation

import SwiftUI

extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self
            .background(
                Blur(radius: radius, opaque: opaque)
            )
    }
}

extension Color {
    static let background = LinearGradient(gradient: Gradient(colors: [Color("Background"), Color("Background_1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let gridBackgroud = LinearGradient(gradient: Gradient(colors: [Color("Background 1").opacity(1), Color("Background 1").opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let selectedGridBackgroud = LinearGradient(gradient: Gradient(colors: [Color("Blue").opacity(1), Color("LightBlue").opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let mapBackground = LinearGradient(gradient: Gradient(colors: [Color("Background 1"), Color("Background 1").opacity(0.2), Color.clear, Color.clear]), startPoint: .top, endPoint: .bottom)
    
    static let lockGradient = LinearGradient(gradient: Gradient(colors: [.purple, Color("lock_green_1").opacity(0.6),Color("lock_green_2").opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View {
        return self
            .overlay {
                shape
                    .stroke(color, lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blur)
                    .mask(shape)
                    .opacity(opacity)
            }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(raidus: radius, corners: corners))
    }
}

// source: https://swiftuirecipes.com/blog/getting-size-of-a-view-in-swiftui

extension View {
  func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
    self.modifier(MeasureSizeModifier())
      .onPreferenceChange(SizePreferenceKey.self, perform: action)
  }
}

struct ViewStroke: ViewModifier {
    // created a variable cornerRadius to be able to pass the value of it in the modifier as Dynamic value: type CGFloat
    var cornerRadius: CGFloat
    // adopting to the darkMode
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            )
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.1 : 0.3 ),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1 )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .blendMode(.overlay)
        )
    }
}

extension View {
    // the function is receiving a cornerRaduis type CGFloat and its value is 30 so it will be the Defaul value.
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(ViewStroke(cornerRadius: cornerRadius))
    }
}
