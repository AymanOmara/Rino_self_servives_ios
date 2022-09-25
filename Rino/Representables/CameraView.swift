//
//  CameraView.swift
//  Rino
//
//  Created by Ayman Omara on 26/06/2022.
//

import Foundation
import SwiftUI
import PhotosUI
struct CameraView:UIViewControllerRepresentable{
    
    
    @Binding var documents:[UploadableFile]
    func makeCoordinator() -> CameraView.Cordinator {
        return CameraView.Cordinator(parent: self, documents: $documents)
    }
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes  = ["public.image"]
        return imagePicker

    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    class Cordinator:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        @Binding var documents:[UploadableFile]
        var parent:CameraView
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            DispatchQueue.global(qos: .userInteractive).sync {
                guard let myImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
                    return
                }
                if let data = myImage.pngData(){
                    if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                        let assetResources = PHAssetResource.assetResources(for: asset)
                        documents.append(UploadableFile(fileExtension: "png", fileName: assetResources.first!.originalFilename, file: data, image: UIImage(data: data)!))
                        
                    }else{
                        print("IMG\(getTimeStamp())")
                        documents.append(UploadableFile(fileExtension: "png", fileName: "IMG-\(getTimeStamp())", file: data, image: UIImage(data: data)!))
                    }
                }

            }
            
            picker.dismiss(animated: true, completion: nil)
            
        }
        
        
        init(parent:CameraView,documents:Binding<[UploadableFile]>) {
            self.parent = parent
            _documents = documents
        }
        func getTimeStamp()->String{
            let now = Date()

            let formatter = DateFormatter()

            formatter.timeZone = TimeZone.current

            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            return formatter.string(from: now)
        }
    }
}
func getTimeStamp()->String{
    let now = Date()

    let formatter = DateFormatter()

    formatter.timeZone = TimeZone.current

    formatter.dateFormat = "yyyy-MM-dd HH:mm"

    return formatter.string(from: now)
}
