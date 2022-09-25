//
//  ViewAttachment.swift
//  Rino
//
//  Created by Ayman Omara on 21/06/2022.
//

import SwiftUI

struct ViewAttachment: View {
    let attachment:UploadableFile
    @State private var scale: CGFloat = 1
    var body: some View {
        if(attachment.fileExtension == "png"){
            ZoomableScrollView {
                Image(uiImage: attachment.image)
                    .resizable()
                    .scaledToFit()
            }
        }else{
            PDFKitRepresentedView(attachment.file)
        }
        
    }
}

struct ViewAttachment_Previews: PreviewProvider {
    static var previews: some View {
        ViewAttachment(attachment: UploadableFile(fileExtension: "", fileName: "", file: Data(), image: UIImage()))
    }
}
struct ZoomableScrollView<Content: View>: UIViewRepresentable {
  private var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  func makeUIView(context: Context) -> UIScrollView {
    // set up the UIScrollView
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // for viewForZooming(in:)
    scrollView.maximumZoomScale = 20
    scrollView.minimumZoomScale = 1
    scrollView.bouncesZoom = true

    // create a UIHostingController to hold our SwiftUI content
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
    scrollView.addSubview(hostedView)

    return scrollView
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // update the hosting controller's SwiftUI content
    context.coordinator.hostingController.rootView = self.content
    assert(context.coordinator.hostingController.view.superview == uiView)
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>

    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
  }
}
