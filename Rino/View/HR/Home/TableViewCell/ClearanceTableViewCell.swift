//
//  ClearanceTableViewCell.swift
//  Rino
//
//  Created by Ayman Omara on 23/09/2021.
//

import UIKit

class ClearanceTableViewCell: UITableViewCell {
    var width:CGFloat!{
        didSet{
            if let flowLayout = collectionViewClearance.collectionViewLayout as? UICollectionViewFlowLayout{
                flowLayout.estimatedItemSize = CGSize(width: width-5, height: 300)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumInteritemSpacing = 5
                flowLayout.minimumLineSpacing = 5
                
            }
        }
    }

    var counter:Int!
    var isFromMe:Bool!
    var entity:String!
    var startDate,endDate:String!
    var onClickClouser:SeeAllClosuer?
    var detailsClosure:((_ id:Int,_ entity:Int)->Void)?
    var seeAllClosure:((_ startDate:String,_ endDate:String,_ entity:String)->Void)?
//    var data:Clearance!{
//        didSet{
//            collectionViewClearance.reloadData()
//        }
//    }
    @IBOutlet weak var yearClearance: UILabel!
    @IBOutlet weak var orderNumberClearance: UILabel!
    @IBOutlet weak var collectionViewClearance: DynamicHeightCollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionViewClearance.delegate = self
//        collectionViewClearance.dataSource = self
        collectionViewClearance.clipsToBounds = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func seeAll(_ sender: Any) {
        seeAllClosure!(startDate,endDate,entity)

    }
}
//extension ClearanceTableViewCell : UICollectionViewDelegate ,UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if data.data![counter].items!.count <= 5{
//            return data.data![counter].items!.count
//        }else{
//            return 5
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionViewClearance.dequeueReusableCell(withReuseIdentifier: "ClearanceCollectionViewCell", for: indexPath) as! ClearanceCollectionViewCell
//        
//        if isFromMe == false && data.data![counter].items![indexPath.row].start != nil  {
//
//            cell.vacationView.alpha = 1
//            
//        }else{
//            cell.vacationView.alpha = 0
//            
//        }
//        
//        cell.startVacation.text = data.data![counter].items![indexPath.row].start?.components(separatedBy: "T")[0]
//        cell.endVacation.text = data.data![counter].items![indexPath.row].end?.components(separatedBy: "T")[0]
//        cell.forwardContainer.layer.cornerRadius = 10
//        cell.procedureContainer.layer.cornerRadius = 10
//        cell.clearanceNumber.text = String(data.data![counter].items![indexPath.row].requestID ?? 0).toArabicNumber()
//        cell.employeeName.text = data.data![counter].items![indexPath.row].employee
//        cell.employeeNumber.text = (data.data![counter].items![indexPath.row].code ?? "").toArabicNumber()
//        cell.forwardToContentClearance.text =  data.data![counter].items![indexPath.row].current?.users![0]
//        cell.office.text = data.data![counter].items![indexPath.row].department
//        cell.orderKind.text = data.data![counter].items![indexPath.row].type
//        cell.clearanceOrderDate.text = (data.data![counter].items![indexPath.row].date?.components(separatedBy: "T")[0] ?? "").toArabicDate()
//        cell.procedure.text = data.data![counter].items![indexPath.row].status
//        entity = String(data.data![counter].items![indexPath.row].entity!)
//        cell.layer.borderWidth = 2
//        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        cell.layer.cornerRadius  = 10
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let items =  data.data![counter].items![indexPath.row]
//        
//        
//        detailsClosure!(items.requestID!, items.entity!)
//    }
//    
//    
//}
