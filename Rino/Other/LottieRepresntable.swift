//
//  LottieRepresntable.swift
//  Rino
//
//  Created by Ayman Omara on 22/06/2022.
//


import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable{
    var fileName:String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) ->  UIView {
        let view = UIView()
        let animationView = AnimationView(name: fileName)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
    
}
