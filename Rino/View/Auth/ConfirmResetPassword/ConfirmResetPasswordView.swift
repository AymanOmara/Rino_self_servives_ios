//
//  ConfirmResetPasswordView.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI
import SPAlert
struct ConfirmResetPasswordView: View {
    @ObservedObject private var viewModel = ConfirmResetPasswordVM()
    var email:String
    @State private var otp = ""
    @State private var password = ""
    @State private var confrimPassword = ""
    var body: some View {
        ZStack {
            Form{
                Section {
                    TextField("ادخل رمز تحقيق الامان", text: $otp)
                } footer: {
                    if !viewModel.otpmessage.isEmpty{
                        Text(viewModel.otpmessage)
                            .foregroundColor(.red)
                    }
                }

                Section {
                    PasswordTextField(password: $password, placeHolder: "كلمة المرور")
                } footer: {
                    if !viewModel.passowrdmessage.isNumeric{
                        Text(viewModel.passowrdmessage)
                            .foregroundColor(.red)
                    }
                }

                Section {
                    PasswordTextField(password: $confrimPassword.onChange({ value in
                        if !viewModel.isValidPassword(testStr: value){
                            viewModel.confrimPasswordMessage = "من فضلك ادخل كلمة مرور صالحة"
                        }else if viewModel.isValidPassword(testStr: value) && password != confrimPassword{
                            viewModel.confrimPasswordMessage = "تأكيد كلمه المرور غير مطابق لكلمه المرور"
                        }
                        else{
                            viewModel.confrimPasswordMessage = ""
                        }
                    }), placeHolder: "تاكيد كلمة المرور")
                } footer: {
                    if !viewModel.confrimPasswordMessage.isEmpty{
                        Text(viewModel.passowrdmessage)
                            .foregroundColor(.red)
                    }
                }
                if !viewModel.message.isEmpty{
                    Text(viewModel.message)
                        .foregroundColor(.red)
                }
                Section {
                    Button {
                        viewModel.submit(otp: otp, password: password,confrimPassword: confrimPassword)
                    } label: {
                        Text("تاكيد")
                            .padding(.horizontal,30)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
                

            }
            .onAppear{
                viewModel.email = email
        }
            .SPAlert(isPresent: $viewModel.successState, alertView: SPAlertView(title: "تم تغيير كلمة المرور بنجاح", preset: .done))
            
            ActivityIndicator(isAnimating: $viewModel.isLoading)
                .frame(width:50,height: 50)
        }
        .environment(\.layoutDirection, .rightToLeft)
    
    }
}

struct ConfirmResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmResetPasswordView(email: "")
    }
}
