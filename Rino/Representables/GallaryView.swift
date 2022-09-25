//
//  GallaryView.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import Foundation
import SwiftUI
import PhotosUI
@available(iOS 14, *)
struct GallaryView:UIViewControllerRepresentable{
    
    
    @Binding var documents:[UploadableFile]
    
    func makeUIViewController(context: Context) -> PHPickerViewController{
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .images
        // configuration.filter = .any([.videos,livePhotos]) // Multiple types of media
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker

    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> GallaryView.Cordinator {
        return GallaryView.Cordinator(parent: self, documents: $documents)
    }
    class Cordinator:NSObject,PHPickerViewControllerDelegate{
        @Binding var documents:[UploadableFile]
        var parent:GallaryView
        init(parent:GallaryView,documents:Binding<[UploadableFile]>) {
            self.parent = parent
            _documents = documents
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            

            results.map { it in
                let imageItem = it.itemProvider
                
                if imageItem.canLoadObject(ofClass: UIImage.self) {
                    imageItem.loadObject(ofClass: UIImage.self) { [weak self]  image, error in
                        if let secondImage = image as? UIImage,  let self = self {
                            DispatchQueue.global().async {
                                if let data = secondImage.pngData(){
                                    
                                    if let fileName = imageItem.suggestedName{
                                        self.documents.append(UploadableFile(fileExtension: "png", fileName: fileName, file: data, image: UIImage(data: data)!))
                                    }
                                    else{
                            
                                        self.documents.append(UploadableFile(fileExtension: "png", fileName: "IMG-\(getTimeStamp())", file: data,image: UIImage(data: data)!))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        }
        
        
    }

