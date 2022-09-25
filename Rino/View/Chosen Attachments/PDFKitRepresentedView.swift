//
//  PDFViewer.swift
//  Rino
//
//  Created by Ayman Omara on 21/06/2022.
//

import PDFKit
import SwiftUI

struct PDFKitRepresentedView: UIViewRepresentable {
    let data: Data
    let singlePage: Bool

    init(_ data: Data, singlePage: Bool = false) {
        self.data = data
        self.singlePage = singlePage
    }

    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFView {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {
        pdfView.document = PDFDocument(data: data)
    }
}
