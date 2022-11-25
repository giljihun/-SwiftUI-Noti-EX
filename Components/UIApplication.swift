//
//  UIApplication.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
