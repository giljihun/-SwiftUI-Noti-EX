//
//  SearchBarView.swift
//  LocalNotification
//
//  Created by 길지훈 on 2022/11/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by title or content...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0) // 값 입력에 따른 투명도 설정!
                        .onTapGesture {
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
            SearchBarView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            SearchBarView()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
            
    }
}
