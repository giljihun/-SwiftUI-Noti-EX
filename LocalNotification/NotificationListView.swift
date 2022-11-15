//
//  NotificationListView.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/14.
//

import SwiftUI

struct NotificationListView: View {
    @StateObject private var notificationManager = NotificationManager()
    //@StateObject -> 뷰안에서 안전하게 ObservedObject 인스턴스를 만들 수 있다.
    @State private var isCreatPresented = false
    var body: some View {
        List(notificationManager.notifications, id: \.identifier) { notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Cool - Time")
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined: // When First Opening App.
                //request authorization
                notificationManager.requestAuthorization()
            case .authorized:
                //get local notifications
                notificationManager.reloadLocalNotification()
            default: //don't allow
                break
            }
        }
        .toolbar {
            Button {
                isCreatPresented = true
            } label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }
        }
        .sheet(isPresented: $isCreatPresented) {
            NavigationView {
                CreatNotificationView(notificationManager: NotificationManager(), isPresented: $isCreatPresented)
            }
            .accentColor(.primary)
        }
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
