//
//  DocumentView.swift
//  Rino
//
//  Created by Ayman Omara on 23/06/2022.
//


import SwiftUI
import MobileCoreServices
struct DocumentsView:UIViewControllerRepresentable{
    @Binding var documents:[UploadableFile]
    func makeCoordinator() -> DocumentsView.Cordinator {
        return DocumentsView.Cordinator(parent: self, documents: $documents)
    }
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        
        if #available(iOS 14.0, *) {
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png, .pdf,.image,.rawImage])
            
            documentPicker.allowsMultipleSelection = true
            documentPicker.modalPresentationStyle = .overFullScreen
            documentPicker.delegate = context.coordinator
            return documentPicker
            
        }else{
            let  documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF),String(kUTTypePNG),String(kUTTypeJPEG),String(kUTTypeImage)], in: .open)
            documentPicker.allowsMultipleSelection = true
            documentPicker.modalPresentationStyle = .overFullScreen
            documentPicker.delegate = context.coordinator
            return documentPicker
        }
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        
    }
    class Cordinator:NSObject,UIDocumentPickerDelegate{
        @Binding var documents:[UploadableFile]
        var parent:DocumentsView
        init(parent:DocumentsView,documents:Binding<[UploadableFile]>) {
            self.parent = parent
            _documents = documents
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard controller.documentPickerMode == .open else{return}
              urls.map{it in
                let url = it
                url.startAccessingSecurityScopedResource()
                
                defer {
                    DispatchQueue.main.async {
                        url.stopAccessingSecurityScopedResource()
                    }
                }
                
                do {
                    let document = try Data(contentsOf: url.absoluteURL)
                    
                    
                    if let fileName = url.pathComponents.last{
                        documents.append(UploadableFile(fileExtension: url.pathExtension, fileName: fileName, file: document, image: UIImage.pdfThumbnail(data: document)!))
                    }else{
                        documents.append(UploadableFile(fileExtension: url.pathExtension, fileName: "file", file: document, image: UIImage.pdfThumbnail(data: document)!))
                    }
                }
                
                catch {
                }
            }
            
        }
    }
    
}
