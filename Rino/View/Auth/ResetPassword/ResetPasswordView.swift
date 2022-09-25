//
//  ResetPasswordView.swift
//  Rino
//
//  Created by Ayman Omara on 18/07/2022.
//

import SwiftUI
import Combine
struct ResetPasswordView: View {
    @State var email = ""
    @ObservedObject private var viewModel = ResetPasswordViewModel()
    var body: some View {
        ScrollView{
            Form{
                Section{
                    TextField("من فضلك ادخل الايميل لاستعادة كلمة المرور", text: $email)
                }
            }.frame(height:90)
            HStack{
                Button {
                    if viewModel.isValidEmail(email: email){
                        viewModel.fetchData(email: email)
                    }else{
                        print("error")
                    }
                } label: {
                    Text("تاكيد")
                }
            }
            
            ActivityIndicator(isAnimating: $viewModel.isLoading)
                .frame(width:50,height: 50)
            
            NavigationLink(destination: ConfirmResetPasswordView(email: email), isActive: $viewModel.isSuccess) {
                EmptyView()
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
