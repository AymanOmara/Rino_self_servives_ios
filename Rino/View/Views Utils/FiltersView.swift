//
//  FiltersView.swift
//  Rino
//
//  Created by Ayman Omara on 03/08/2022.
//

import SwiftUI
struct FiltersView:View{
    var englishFilters,arabicFilters:[String]
    @Binding var selectedFilter:String
    @Binding var selectedArabicFilter:String
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                ForEach(Array(arabicFilters.enumerated()), id: \.offset) { index , value in
                    Text(value)
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                        .padding(.horizontal,6)
                        .padding(.vertical,3)
                        .foregroundColor(selectedArabicFilter == value ? Color.white : Color.black)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color( selectedArabicFilter == value ? UIColor.orange : UIColor.systemBackground)))
                        .onTapGesture {
                            selectedArabicFilter = value
                            selectedFilter = englishFilters[index]
                        }
                }
                    
                .shadow(color: Color.gray.opacity(0.5), radius: 3, x: 0, y: 0)
                    .padding(.vertical,2)
            }
            .padding(.horizontal,15)
        }
        .padding(.top,5)
        
        .flipsForRightToLeftLayoutDirection(true)
        .environment(\.layoutDirection, .rightToLeft)
        

    }
}
