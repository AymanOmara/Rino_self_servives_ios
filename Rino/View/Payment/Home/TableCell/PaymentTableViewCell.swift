//
//  PaymentTableViewCell.swift
//  Rino
//
//  Created by Ayman Omara on 31/08/2021.
//

import UIKit
typealias SeeAllClosuer = ((_ startDate:String,_ endDate:String)->Void)?
class PaymentTableViewCell: UITableViewCell {
    var width:CGFloat!{
        didSet{
            if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                flowLayout.estimatedItemSize = CGSize(width: width-5, height: flowLayout.itemSize.height-5)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumInteritemSpacing = 5
                flowLayout.minimumLineSpacing = 5
            }
        }
    }

    var isFromOthres:CGFloat = 0
    var counter = 0

    var color:UIColor = .orange
    var startDate,endDate:String!
    var onClickClouser:SeeAllClosuer?
    var detailsClosure:((_ id:Int)->Void)?
    var onScrollClouser:(()->Void)?
    
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var seeAll: UIButton!
    @IBOutlet weak var ordersNumber: UILabel!
    
    var data:PaymentProcessResponse!{
        didSet{
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.semanticContentAttribute = .forceRightToLeft
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.layer.cornerRadius = 10
        collectionView.contentOffset = .zero
    }


    
    @IBAction private func seeAllbtn(_ sender: Any) {
//        print(startDate)
//        print(endDate)
        onClickClouser!!(startDate,endDate)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
//        collectionView.contentOffset = .zero
        collectionView.reloadData()
    }
}
extension PaymentTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if data.data![counter].items!.count < 5{
//            return data.data![counter].items!.count
//        }else{
            return 5
//        }
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
         1
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentCollectionViewCell.identifire, for:indexPath) as! PaymentCollectionViewCell
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        cell.forwordContentContainer.layer.cornerRadius = 10
        
//        let items = data.data![counter].items![indexPath.row]
//        cell.configure(item: items, isFromMe: isFromOthres, color: color)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let items = data.data![counter].items![indexPath.row]
//
//        detailsClosure!(items.requestID!)
    }
    
    
}
