//
//  Text.swift
//  LocalNotification
//
//  Created by 길지훈 on 2023/01/03.
//

import SwiftUI

extension Text {
    func headline() -> some View {
        self
            .kerning(1)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top])
            .accessibility(addTraits: .isHeader)
    }
}
