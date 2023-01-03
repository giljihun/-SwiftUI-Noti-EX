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
    @State private var label = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    
                    Group {
                        Text("이벤트명").headline()
                    HStack {
                        TextField("제목을 입력하세요...", text: $title)
                            .foregroundColor(Color.theme.accent)
                            .disableAutocorrection(true)
                            .overlay(
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x:60)
                                    .foregroundColor(Color.theme.accent)
                                    .opacity(title.isEmpty ? 0.0 : 1.0) // 값 입력에 따른 투명도 설정!
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        // extension - 입력에서 X를 누르면 키보드 입력창이 닫아지도록 함!
                                        title = "" // X를 누르면 초기화되게 만들어주기!
                                    }
                                    , alignment: .trailing
                        )
                        
                        Spacer()
                        
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.theme.background)
                    .cornerRadius(5)
                    .foregroundColor(
                        title.isEmpty ?
                        Color.theme.secondaryText : Color.theme.accent)
                    } // 타이틀
                    
                    Group {
                        Text("레이블").headline()
                        HStack {
                            TextField("전달 받을 내용을 입력하세요...", text: $label)
                                .foregroundColor(Color.theme.accent)
                                .disableAutocorrection(true)
                                .overlay(
                                    Image(systemName: "xmark.circle.fill")
                                        .padding()
                                        .offset(x:60)
                                        .foregroundColor(Color.theme.accent)
                                        .opacity(title.isEmpty ? 0.0 : 1.0) // 값 입력에 따른 투명도 설정!
                                        .onTapGesture {
                                            UIApplication.shared.endEditing()
                                            // extension - 입력에서 X를 누르면 키보드 입력창이 닫아지도록 함!
                                            label = "" // X를 누르면 초기화되게 만들어주기!
                                        }
                                        , alignment: .trailing
                            )
                            
                            Spacer()
                            
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.theme.background)
                        .cornerRadius(5)
                        .foregroundColor(
                            title.isEmpty ?
                            Color.theme.secondaryText : Color.theme.accent)
                    } // 레이블
                    
                    Group {
                        Text("날짜").headline()
                
                            DatePicker("", selection: $date, in: Date()...,
                                       displayedComponents: [.date, .hourAndMinute])
                                        .datePickerStyle(.compact)
                                        .environment(\.locale, Locale.init(identifier: "ko-KR"))
                                        
                    } // 날짜
                    
                    
                    
                    
                    
                    
                    
                    
                    
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
                    }
                    label: {
                        Text("생성하기")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            
                    }
                    .disabled(title.isEmpty)
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
        .navigationTitle("새 이벤트")
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
            .preferredColorScheme(.dark)
    }
}
