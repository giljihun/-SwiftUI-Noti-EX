//
//  SearchBarView.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @State var editText : Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent)
            
            TextField("제목 검색 또는 내용 입력", text: self.$searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0) // 값 입력에 따른 투명도 설정!
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            // extension - 입력에서 X를 누르면 키보드 입력창이 닫아지도록 함!
                            searchText = "" // X를 누르면 초기화되게 만들어주기!
                        }
                        , alignment: .trailing
            )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.3),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
       
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
