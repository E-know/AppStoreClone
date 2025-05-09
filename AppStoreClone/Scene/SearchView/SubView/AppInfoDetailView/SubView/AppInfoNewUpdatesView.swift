//
//  AppInfoNewUpdatesView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

struct AppInfoNewUpdatesView: View {
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {print("새로운 소식")}) {
                HStack {
                    Text("새로운 소식")
                        .font(19, .bold)
                        .foregroundStyle(Color.black)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.subGray)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 12)
            
            HStack {
                Text("버전 2.47.1")
                    .font(12)
                
                Spacer()
                
                Text("2주 전")
                    .font(12)
            }
            .foregroundStyle(Color.subGray)
            .padding(.bottom, 14)
            
            HStack {
                Text("""
                     '주택담보대출 비교하기' 서비스를 추가했어요(4월 오픈 예정).
                     - 카카오뱅크와 제휴사의 대출 상품 금리와 한도를 한번에 비교할 수 있어요.
                     """)
                .font(12)
                .lineSpacing(8)
                
                VStack {
                    Spacer()
                    Button(action: { print("더보기") }) {
                        Text("더 보기")
                            .font(12)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
