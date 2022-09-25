//
//  MaterialIndicatorView.swift
//  Rino
//
//  Created by Ayman Omara on 12/07/2022.
//

import SwiftUI
import MaterialActivityIndicator

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) ->  MaterialActivityIndicatorView {
        let indicator = MaterialActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.color = .gray
        return indicator
    }

    func updateUIView(_ uiView: MaterialActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
