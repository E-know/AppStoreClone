//
//  CircularProgressView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/17/25.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: Float // 0.0 ~ 1.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 6)

            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90)) // 12시 방향부터 시작하도록 회전

            Text("\(Int(progress * 100))%")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.blue)
        }
        .frame(width: 40, height: 40)
    }
}
