//
//  LottieAnimationView.swift
//  Rino
//
//  Created by Ayman Omara on 22/06/2022.
//

import SwiftUI
struct LottieAnimationView:View{
    
    var fileName:String
    var body: some View{
        VStack{
            LottieView(fileName: fileName)
                .frame(width: 360, height: 360, alignment: .center)
        }
    }
}
