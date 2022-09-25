//
//  SwfitExtensions.swift
//  Rino
//MARK:- This file is for extending the built in functionalities For Swift
//  Created by Ayman Omara on 09/09/2021.
//

import Foundation
import UIKit
import PDFKit
extension String{
    func toArabicNumber()->String{
        let st = self.replacingOccurrences(of: "1", with: "١").replacingOccurrences(of: "2", with: "٢").replacingOccurrences(of: "3", with: "٣").replacingOccurrences(of: "4", with: "٤").replacingOccurrences(of: "5", with: "٥").replacingOccurrences(of: "6", with: "٦").replacingOccurrences(of: "7", with: "٧").replacingOccurrences(of: "8", with: "٨").replacingOccurrences(of: "9", with: "٩").replacingOccurrences(of: "0", with: "٠")
        return st
    }
    func toArabicDate()->String{
        let dateComponents = self.replacingOccurrences(of: "-", with: "/").components(separatedBy: "/")
        let arabicDate = dateComponents.joined(separator: "/")
        return arabicDate.toArabicNumber()
    }
    func toEnglishNumber()->String{
        let st = self.replacingOccurrences(of: "١", with: "1").replacingOccurrences(of: "٢", with: "2").replacingOccurrences(of: "٣", with: "3").replacingOccurrences(of: "٤", with: "4").replacingOccurrences(of: "٥", with: "5").replacingOccurrences(of: "٦", with: "6").replacingOccurrences(of: "٧", with: "7").replacingOccurrences(of: "٨", with: "8").replacingOccurrences(of: "٩", with: "9").replacingOccurrences(of: "٠", with: "0")
        return st
    }
    static func convertArabicNumberIntoEnglish(text : String)-> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "٤", "5" : "٥", "6" : "٦", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = text

        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of:  value, with: key)
        }

        return str
    }
    

    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
extension FloatingPoint {
    var whole: Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
extension UIImage {
  static  func pdfThumbnail(data: Data, width: CGFloat = 240) -> UIImage? {
     guard let page = PDFDocument(data: data)?.page(at: 0) else {
        return nil
      }

      let pageSize = page.bounds(for: .mediaBox)
      let pdfScale = width / pageSize.width

      // Apply if you're displaying the thumbnail on screen
      let scale = UIScreen.main.scale * pdfScale
      let screenSize = CGSize(width: pageSize.width * scale,
                              height: pageSize.height * scale)

      return page.thumbnail(of: screenSize, for: .mediaBox)
    }
}
