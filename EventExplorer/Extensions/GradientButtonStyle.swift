//
//  GradientButtonStyle.swift
//  EventExplorer
//
//  Created by L S on 22/05/2024.
//

import SwiftUI

// Custom button style 
struct GradientButtonStyle: ButtonStyle {
    // Gradient background, white text, and rounded corners
    var colors: [Color] = [
        Color(red: 1.0, green: 0.6, blue: 0.8),
        Color(red: 1.0, green: 0.8, blue: 0.6)
    ]
    var cornerRadius: CGFloat = 100
    var fontSize: Font = .title3
    var horizontalPadding: CGFloat = 16

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(fontSize)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottomLeading, endPoint: .topTrailing)
            )
            .cornerRadius(cornerRadius)
            .padding(.horizontal, horizontalPadding)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Adds a subtle scaling effect when pressed
    }
}
