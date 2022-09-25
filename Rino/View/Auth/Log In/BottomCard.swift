//
//  LoginView.swift
//  Rino
//
//  Created by Ayman Omara on 11/07/2022.
//

import SwiftUI

struct BottomCard<Content:View>: View {
    let content:Content
    @Binding var isShown:Bool
    @Binding var cancel:Bool
    var body: some View {
        ZStack{
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.1))
            .opacity(isShown ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                isShown.toggle()
            }
            VStack{
                Spacer()
                VStack{
                    content
                }
                .background(Color(UIColor.systemBackground))
                .offset(y: isShown ? 0 : 300)
                .animation(Animation.default.delay(0.2))
            }

        }
        .edgesIgnoringSafeArea(.all)
        .environment(\.layoutDirection, .rightToLeft)
    }
    init(@ViewBuilder content:() -> Content,isShown:Binding<Bool>,cancel:Binding<Bool>) {
        self.content = content()
        _isShown = isShown
        _cancel = cancel
    }
}
