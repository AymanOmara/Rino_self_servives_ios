//
//  ActivityViewController.swift
//  Rino
//
//  Created by Ayman Omara on 04/08/2022.
//

import SwiftUI
import UIKit
struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,context:UIViewControllerRepresentableContext<ActivityViewController>) {}
}
