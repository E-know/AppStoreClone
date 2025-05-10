//
//  PrivacyInfoView.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/10/25.
//

import SwiftUI

struct PrivacyInfoView: View {
    private let testDescription = "Kakao Corp. 개발자가 아래 설명된 데이터 처리방식이 앱의 개인정보처리방침에 포함되어 있을 수 있다고 표시했습니다. 자세한 내용은 개발자의 개인처리정보 처리방침을 참조하십시오."
    
    var body: some View {
        VStack() {
            HStack {
                Text("앱이 수집하는 개인 정보")
                    .font(19, .bold)
                
                Image(systemName: "chevron.right")
                    .frame(height: 14)
                
                Spacer()
            }
            .padding(.bottom, 12)
            
            Text(testDescription)
                .font(12)
                .foregroundStyle(Color.subGray)
                .lineSpacing(12 * 0.3)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PrivacyInfoView()
}
