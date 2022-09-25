//
//  DropMenu.swift
//  Rino
//
//  Created by Ayman Omara on 24/07/2022.
//

import Foundation
import iOSDropDown
import SwiftUI
struct DropMenu:UIViewRepresentable{
    @Binding var options:[String]
    @Binding var selectedItem:String
    let placeHolrder:String
    func makeUIView(context: UIViewRepresentableContext<Self>) -> DropDown{
    let dropDown = DropDown()
        dropDown.placeholder = placeHolrder
        dropDown.isSearchEnable = false
        dropDown.optionArray = options
        dropDown.selectedRowColor = .orange
        dropDown.didSelect { selectedText, index, id in
            selectedItem = selectedText
        }
        return dropDown
    }
    func updateUIView(_ uiView: DropDown, context: Context) {
        
    }
}
