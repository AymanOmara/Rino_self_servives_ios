//
//  ErrorView.swift
//  Rino
//
//  Created by Ayman Omara on 28/06/2022.
//

import SwiftUI

struct ErrorView: View {
    var action:(()->())?
    @State var errorcase:NetworkErrorCase = .none
    var body: some View {
        VStack(alignment:.center){
            if errorcase != .none{
                LottieAnimationView(fileName: errorcase == .emptyData ? "emptdata" : errorcase == .timeOut ? "timeout" : errorcase == .serverError ? "servererror" : errorcase == .noConntection ? "noconnection" : "")
                Text(errorcase.rawValue)
                
                Button {
                    if let action = action {
                        action()
                    }
                    
                } label: {
                    Text("إعادة المحاولة")
                        .padding(10)
                        .cornerRadius(4)
                        .border(Color.orange)
                }
                Spacer()
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorcase: .noConntection)
    }
}
