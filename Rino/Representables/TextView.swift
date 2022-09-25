//
//  TextView.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import Foundation
import SwiftUI
struct TextView: UIViewRepresentable {
    @Binding var text:String
    typealias UIViewType = UITextView
    var configuration = { (view: UIViewType) in }
    func makeCoordinator() -> TextView.Cordinator {
        return TextView.Cordinator(parent: self, text: $text)
    }
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        
        let textFiled = UIViewType()
        text = textFiled.text
        textFiled.delegate = context.coordinator
        return textFiled
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
    class Cordinator:NSObject,UITextViewDelegate{
        @Binding var text:String
        var parent:TextView
        init(parent:TextView,text:Binding<String>) {
            self.parent = parent
            _text = text
        }
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 500
        }
    }
}
