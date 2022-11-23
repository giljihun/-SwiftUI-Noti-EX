//
//  NotificationManager.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/14.
//

import Foundation
import UserNotifications


final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    /* private(set) -> 기존 private은 외부(구조체, 클래스 밖)에서 읽기, 쓰기가 불가능하다.
      하지만 private(set)은 외부에서 읽기는 가능하다. */
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    /* '?'(Optional) -> 옵셔널은 값이 있을 수도 있고 없을 수도 있는 변수를 정의할 때 사용된다.
      값이 없다면 'nil' 반환 */
    
    func reloadLocalNotifications() {
        print("reloadLocalNotifications")
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                // async - 작업을 수행하자마자 현재의 queue에 컨트롤을 넘겨주고 작업이 끝나기 전까지 기다릴 필요가 없습니다.
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
     
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    
    func createLocalNotification(title: String, hour: Int, minute: Int, completion:
        @escaping (Error?) -> Void){
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    
    }
    
    func deleteLocalNotifications(identifiers: [String]) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
}
