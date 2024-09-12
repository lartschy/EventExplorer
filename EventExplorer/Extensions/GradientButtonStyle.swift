//
//  GradientButtonStyle.swift
//  EventExplorer
//
//  Created by L S on 22/05/2024.
//

import SwiftUI

import SwiftUI

struct GradientButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.8, blue: 0.6)]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(100)
            .padding(.horizontal)
    }
}

extension View {
    func gradientButtonStyle() -> some View {
        self.modifier(GradientButtonStyle())
    }
}
