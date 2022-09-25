//
//  Extensions.swift
//  Rino
//MARK:- This file is for extending the built in functionalities For UIComponents
//  Created by Ayman Omara on 02/09/2021.
//

import Foundation
import UIKit
import MaterialActivityIndicator
import Lottie
import AVFoundation
import SwiftUI
extension UIViewController{
    func showAlert(message:String,title:String,shouldNavigate:Bool,distaination:UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var OK:UIAlertAction!
        
        if shouldNavigate{
            OK =  UIAlertAction(title: "OK", style: .default) {[weak self] (_) -> Void in
                
                self?.navigationController?.pushViewController(distaination!, animated: true)
                
                //self?.present(distaination!, animated: true, completion: nil)
                let viewController = self?.storyboard!.instantiateViewController(withIdentifier: "TabBar") as! TabBar
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            
        }
        else{
            OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        }
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MaterialActivityIndicatorView{
    func addIndicatorToView(context:UIView){
        self.color = .gray
        self.resizeIndicator()
        self.center = context.center
        
        context.addSubview(self)
    }
    func resizeIndicator(){
        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func attachmentPicker(compilation:@escaping(AttachmentOption?)->Void){
        let alertActionSheetController: UIAlertController = UIAlertController(title: "قم باختيار مكان الصوره", message: "", preferredStyle: UIAlertController.Style.actionSheet)
//        let image = UIImage(systemName: "plus")
        let cancelAction: UIAlertAction = UIAlertAction(title: "الغاء", style: UIAlertAction.Style.cancel) { _ in
            
        }
        let photoLibrary:UIAlertAction = UIAlertAction(title: "الاستديو", style: UIAlertAction.Style.default) { _ in
            compilation(AttachmentOption.gallery)
        }
        let camera:UIAlertAction = UIAlertAction(title: "الكاميرا", style: UIAlertAction.Style.default) { _ in
            compilation(AttachmentOption.camera)
        }
        let document:UIAlertAction = UIAlertAction(title: "ملفات", style: UIAlertAction.Style.default) { _ in
            compilation(AttachmentOption.document)
        }
//        document.setValue(image, forKey: "image")
        alertActionSheetController.addAction(cancelAction)
        alertActionSheetController.addAction(photoLibrary)
        alertActionSheetController.addAction(camera)
        alertActionSheetController.addAction(document)
        self.present(alertActionSheetController, animated: true)
    }
    enum AttachmentOption{
        case camera,gallery,document
    }
}
extension UIViewController{
    func translateBackButtonTitle(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "رجوع", style: .done, target: nil, action: nil)
    }
}
extension CAShapeLayer {
func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
    fillColor = filled ? color.cgColor : UIColor.white.cgColor
    strokeColor = color.cgColor
    path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
   }
  }

   private var handle: UInt8 = 0;

extension UIBarButtonItem {
private var badgeLayer: CAShapeLayer? {
    if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
        return b as? CAShapeLayer
    } else {
        return nil
    }
}

func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
{
    badgeLayer?.removeFromSuperlayer()

    if (text == nil || text == "") {
        return
    }

    addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
}

 func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
{
    guard let view = self.value(forKey: "view") as? UIView else { return }

    var font = UIFont.systemFont(ofSize: fontSize)

    if #available(iOS 9.0, *) { font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular) }
    let badgeSize = text.size(withAttributes: [NSAttributedString.Key.font: font])

    // Initialize Badge
    let badge = CAShapeLayer()

    let height = badgeSize.height;
    var width = badgeSize.width + 2 /* padding */

    //make sure we have at least a circle
    if (width < height) {
        width = height
    }

    //x position is offset from right-hand side
    let x = view.frame.width - width + offset.x

    let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))

    badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
    view.layer.addSublayer(badge)

    // Initialiaze Badge's label
    let label = CATextLayer()
    label.string = text
    label.alignmentMode = CATextLayerAlignmentMode.center
    label.font = font
    label.fontSize = font.pointSize

    label.frame = badgeFrame
    label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
    label.backgroundColor = UIColor.clear.cgColor
    label.contentsScale = UIScreen.main.scale
    badge.addSublayer(label)

    // Save Badge as UIBarButtonItem property
    objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

private func removeBadge() {
    badgeLayer?.removeFromSuperlayer()
   }
  }

@IBDesignable
extension UIView{
    @IBInspectable var cornerRaduis:CGFloat{
        get{
            return  layer.cornerRadius
        }
        set(newvalue){
            layer.cornerRadius = newvalue
        }
    }
}
extension UIView {
func dropShadow() {
    self.layer.cornerRadius = 3
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
    self.layer.shadowOpacity = 0.45
    self.layer.shadowRadius = 1.7

  }
}
enum LottieFileForCase{
    case emptyPrivilege,noConnection
}

extension AnimationView{
    func showLottie(forCase:LottieFileForCase){
        let animationView = self
        animationView.alpha = 1
        if forCase == .noConnection{
            animationView.animation = Animation.named("noConnection")
        }else if forCase == .emptyPrivilege{
            animationView.animation = Animation.named("noHistory")
        }
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode = .loop

        animationView.animationSpeed = 0.5
        animationView.play()
        
    }
    func hideLottie(){
        self.stop()
        self.alpha = 0
    }
}
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
extension UICollectionViewCell{
    func toCard(){
        contentView.layer.cornerRadius = 2.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
}
extension UIViewController{
    func presentSettings(title:String,body:String) {
        let alertController = UIAlertController(title: title,
                                                message: body,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "إلغاء", style: .default))
        alertController.addAction(UIAlertAction(title: "الإعدادات", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        present(alertController, animated: true)
    }
    func checkCameraAccess()->Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied,.restricted:
            
            presentSettings(title: "خطأ", body: "الرجاء إتاحة الوصول إلى الكاميرا")
            return false
            
        case .authorized:
            print("Authorized, proceed")
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        }
        return true
    }
}
