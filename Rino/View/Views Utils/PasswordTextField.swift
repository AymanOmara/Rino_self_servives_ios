//
//  PasswordTextField.swift
//  Rino
//
//  Created by Ayman Omara on 17/07/2022.
//

import SwiftUI

struct PasswordTextField: View {
    @State var isScured = true
    @Binding var password:String
    let placeHolder:LocalizedStringKey
    var body: some View {
        HStack {
            Image(systemName: isScured ? "eye.slash.fill" : "eye.fill")
                .onTapGesture {
                    isScured.toggle()
                }
            if isScured{
                SecureField(placeHolder, text: $password)
            }else{
                TextField(placeHolder, text: $password)
            }
            Image(systemName: "lock")
        }
    }
}
