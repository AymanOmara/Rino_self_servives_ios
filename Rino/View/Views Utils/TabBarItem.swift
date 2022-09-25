//
//  TabBarItem.swift
//  Rino
//
//  Created by Ayman Omara on 02/08/2022.
//

import SwiftUI
struct TabBarItem: View {
    let imageName:String
    let buttonName:LocalizedStringKey
    var color:Color
    let edgeSet:Edge.Set
    var body: some View {
        VStack{
            Image(systemName: imageName)
                .padding(.bottom,4)
            Text(buttonName)
                .font(.system(size: 14))
        }
        .foregroundColor(color)
        .padding(edgeSet,50)
    }
}
