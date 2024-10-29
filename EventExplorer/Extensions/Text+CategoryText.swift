//
//  Text+CategoryText.swift
//  EventExplorer
//
//  Created by L S on 12/05/2024.
//

import Foundation
import SwiftUI

// Extension to style Text as a category header with a background image and gradient overlay
extension Text {
    // Styles the Text as a category header with a background image, gradient overlay, and customizable properties
    func categoryText(imageName: String) -> some View {
        self
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.6, blue: 0.8),
                            Color(red: 1.0, green: 0.8, blue: 0.6)
                        ]), startPoint: .bottomLeading, endPoint: .topTrailing)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(40)
                    )
            )
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}
