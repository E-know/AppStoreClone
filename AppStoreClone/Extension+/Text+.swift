//
//  Text+.swift
//  AppStoreClone
//
//  Created by Inho Choi on 5/5/25.
//

import SwiftUI

extension Text {
    func font(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Text {
        self.font(.system(size: size, weight: weight))
    }
}
