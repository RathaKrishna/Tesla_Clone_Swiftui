//
//  Utils.swift
//  TeslaApp
//  source : https://swiftuirecipes.com/blog/getting-size-of-a-view-in-swiftui
//  Created by Rathakrishnan Ramasamy on 19/07/22.
//

import SwiftUI


struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: SizePreferenceKey.self,
                             value: geometry.size)
    })
  }
}
