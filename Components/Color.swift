//
//  Color.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/24.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedCOlor")
    let secondaryText = Color("SecondaryTextColor")
}
