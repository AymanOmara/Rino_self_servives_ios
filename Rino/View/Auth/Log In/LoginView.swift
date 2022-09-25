//
//  LoginView.swift
//  Rino
//
//  Created by Ayman Omara on 11/07/2022.
//

import SwiftUI
import Combine
struct LoginView:View{
    @ObservedObject var viewModel = LogInViewModel()
    @Binding var isShown:Bool
    @Binding var isSuccessLogIn:Bool
    @State var userName = ""
    @State var password = ""

    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Button {
                        isShown = false
                    } label: {
                        Text(LocalizedStringKey("cancel"))
                    }
                    Spacer()
                }
                Form{
                    Section{
                        HStack {
                            Image(systemName: "person")
                            TextField(LocalizedStringKey("username"), text: $userName)
                        }
                        PasswordTextField(password: $password, placeHolder: LocalizedStringKey("password"))
                    }
                }
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                NavigationLink(destination: ResetPasswordView()) {
                    Text("استعادة كلمة المرور")
                }
        
                Button {
                    viewModel.userName = userName
                    viewModel.password = password
                    if !viewModel.isEmpty() && viewModel.isValidPasswordLength(){
                        viewModel.fetchData()
                    }
                } label: {
                    Text(LocalizedStringKey("login"))
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .frame(width:UIScreen.main.bounds.width-40)
                    
                        .background(Color.orange)
                        .cornerRadius(5)
                }
                .padding(.bottom,20)
                
                Spacer()
            }
            
            .onReceive(Just(viewModel.isSuccessfulLogIn)) { value in
                if value{
                    isSuccessLogIn = true
                    isShown = false
                }
            }

            ActivityIndicator(isAnimating: $viewModel.isLoading)
                .frame(width:50,height: 50)
        }
        .frame(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height*0.7)
    }
}

