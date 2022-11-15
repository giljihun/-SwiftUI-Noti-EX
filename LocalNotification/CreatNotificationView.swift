//
//  CreatNotificationView.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/15.
//

import SwiftUI

struct CreatNotificationView: View {
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
                    Button {
                        //
                    } label: {
                        Text("Creat")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
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

struct CreatNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreatNotificationView(notificationManager: NotificationManager(), isPresented:  .constant(false))
    }
}
