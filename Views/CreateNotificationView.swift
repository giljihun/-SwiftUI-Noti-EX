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
    @State private var repeats = false
    @State var days = 1
    @State private var editingDays: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        
        List {
            Section {
                VStack(spacing: 16) {
                    GroupBox {
                        Group {
                            Text("이벤트명")
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
                            Text("레이블")
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
                    } // 레이블 & 타이틀 설정
                    
                        Section(){
                            Text("첫 알림을 받을 날")
                                
                                DatePicker("", selection: $date, in: Date()...,
                                               displayedComponents: [.date, .hourAndMinute])
                                    .datePickerStyle(.compact)
                                                .environment(\.locale, Locale.init(identifier: "ko-KR"))
                                            .labelsHidden()
                        } // 날짜
                        HStack {
                            Spacer()
                            Text("반복 설정")
                            
                            Toggle("", isOn: $repeats)
                        }
                    
                        if repeats {
                            HStack(alignment: .lastTextBaseline, spacing: 10) {
                                Text("\(days)일")
                                    .font(.system(size: 36))
                                    .fontWeight(.bold)
                                Text("마다 반복")
                                    .font(.subheadline)
                            }
                            
                            VStack {
                                HStack {
                                    Button(action: { days += 1 }) {
                                        Text("+ 1")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle())
                                    
                                    Button(action: { days += 10 }) {
                                        Text("+ 10")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle())
                                    
                                    Button(action: { days += 100 }) {
                                        Text("+ 100")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle())
                                }
                                
                                HStack {
                                    Button(action: {
                                        if days > 1 {
                                            days -= 1
                                        }
                                    }) {
                                        Text("- 1")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle2())
                                    
                                    Button(action: {
                                        if days > 10 {
                                            days -= 10
                                        }
                                    }) {
                                        Text("- 10")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle2())
                                    
                                    Button(action: {
                                        if days > 100 {
                                            days -= 100
                                        }
                                    }) {
                                        Text("- 100")
                                            .fontWeight(.bold)
                                    }
                                    .buttonStyle(StepperButtonStyle2())
                                }
                            }
                        }
                    // 알림 & 반복 설정
                    Group {
                        Button {
                            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                            guard let year = dateComponents.year,
                                  let month = dateComponents.month,
                                  let day = dateComponents.day,
                                  let hour = dateComponents.hour,
                                  let minute = dateComponents.minute
                            else { return }
                            
                            notificationManager.createLocalNotification(title: title, label: label,
                                                                        year: year, month: month, day: day,
                                                                        hour: hour, minute: minute) { error in
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
                    } // 생성 버튼
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

struct StepperButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 18.3)
            .padding(.vertical, 15)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(10)
    }
}

struct StepperButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(configuration.isPressed ? Color.gray : Color.red)
            .cornerRadius(10)
    }
}

