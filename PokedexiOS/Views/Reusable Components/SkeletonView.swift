//
//  SkeletonView.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 13/11/25.
//

import SwiftUI

struct SkeletonView: View {
    @State private var shimmerOffset: CGFloat = -400
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(height: height)
            .overlay(
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.6), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .offset(x: shimmerOffset)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    shimmerOffset = 400
                }
            }
    }
}
