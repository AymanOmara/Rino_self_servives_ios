//
//  PaymentCollectionViewCell.swift
//  Rino
//
//  Created by Ayman Omara on 31/08/2021.
//

import UIKit

class PaymentCollectionViewCell: UICollectionViewCell {
    static let identifire = "PaymentCollectionViewCell"
    @IBOutlet weak var forwordContentContainer: UIView!
    @IBOutlet weak var forwordTo: UILabel!
    @IBOutlet weak var forwordToContent: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    
    @IBOutlet weak var orderStateContainer: UIView!
    @IBOutlet weak var orderSate: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    
    @IBOutlet weak var issuer: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }
    func configure(item:Item,isFromMe:CGFloat,color:UIColor){
        forwordTo?.alpha = isFromMe
        forwordToContent?.alpha = isFromMe
        forwordContentContainer?.alpha = isFromMe
        
        orderNumber?.text = String(item.requestID ?? 0).toArabicNumber()
        orderDate?.text = (item.date?.components(separatedBy: "T")[0] ?? "").toArabicDate()
        amount?.text = String(item.amount ?? 0).toArabicNumber()+"ر.س"
        orderStateContainer?.layer.cornerRadius = 10
        orderStateContainer?.backgroundColor = color
        orderSate?.text = item.status
        paymentMethod?.text = "كاش"
        issuer?.text = item.department!
        forwordToContent?.text = item.current?.users![0]
    }
}
