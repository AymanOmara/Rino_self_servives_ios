//
//  ChnagePassowrdView.swift
//  Rino
//
//  Created by Ayman Omara on 17/07/2022.
//

import SwiftUI
import SPAlert
struct ChnagePassowrdView: View {
    @ObservedObject private var viewModel = ChangePasswordViewModel()
    @State private var oldPassword = ""
    @State private var newPassword = ""
    var body: some View {
        VStack{
            List{
                PasswordTextField(password: $oldPassword, placeHolder: LocalizedStringKey("oldpassowrd"))
                PasswordTextField(password: $newPassword, placeHolder: LocalizedStringKey("newpassword"))
                if !viewModel.message.isEmpty{
                    Text(viewModel.message)
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                }
                Section {
                    Button {
                        viewModel.chnagePassowrd(old: oldPassword, new: newPassword)
                    } label: {
                        Text(LocalizedStringKey("changepassword"))
                            .padding(.vertical,5)
                            .frame(width:UIScreen.main.bounds.width-60)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
            }
        }.onDisappear{
            viewModel.message = ""
        }
        .SPAlert(isPresent: $viewModel.showAlert, alertView: SPAlertView(title: viewModel.userAlert?.body  ?? "", preset: viewModel.userAlert?.alertCase ?? .error))
        
        .environment(\.layoutDirection, .rightToLeft)
        if viewModel.isLoading{
            ActivityIndicator(isAnimating: $viewModel.isLoading)
                .frame(width:50,height: 50)
        }
    }
}

struct ChnagePassowrdView_Previews: PreviewProvider {
    static var previews: some View {
        ChnagePassowrdView()
    }
}
