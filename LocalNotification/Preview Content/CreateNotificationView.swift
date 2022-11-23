//
//  CreatNotificationView.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/15.
//

import SwiftUI

struct CreateNotificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Notification Title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color(.white))
                    .cornerRadius(5)
                    
                    Button { // 'Create' 버튼
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
                        notificationManager.createLocalNotification(title: title, hour: hour, minute: minute) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(5)
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
        .navigationTitle("Create")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(notificationManager: NotificationManager(), isPresented:  .constant(false))
    }
}
