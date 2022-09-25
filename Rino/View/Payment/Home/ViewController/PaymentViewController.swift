//
//  PaymentViewController.swift
//  Rino
//
//  Created by Ayman Omara on 30/08/2021.
//

import UIKit
import iOSDropDown
import MaterialActivityIndicator
import SwiftUI

class PaymentViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var lefTittle: UIBarButtonItem!
    @IBOutlet weak private var notification: UIBarButtonItem!
    var isFromME = true
    @IBOutlet weak var dropList: DropDown!
    @IBOutlet weak private var segmentControl: UISegmentedControl!
    @IBOutlet weak private var tableView: UITableView!
    var indicator = MaterialActivityIndicatorView()
    
    private var paymentViewModel = PaymentViewModel()
    var data:PaymentProcessResponse? = PaymentProcessResponse()
    var storyBoard:UIStoryboard!

    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        indicator.addIndicatorToView(context: view)
        
        
        translateBackButtonTitle()
        
        bindData()
        
        //MARK:- Change it to a regulaer button
        lefTittle.isEnabled = false
        indicator.startAnimating()
//        paymentViewModel.performTheApiCallIFConnected()
        dropConfiguration()
        tableConfiguration()
        
    }
    
    func bindData(){
    }
    func tableConfiguration(){
        tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        indicator.startAnimating()
//        paymentViewModel.performTheApiCallIFConnected()
        
    }
    
    @IBAction func goToSearchView(_ sender: Any) {
        //        resetTimer()
//        guard  let searchVC = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else{
//            return
//        }
//        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func notifications(_ sender: Any) {
//        let notificationVC = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
//        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
//    func onSuccess(){
//        
//        refreshControl.endRefreshing()
//        errorLabel.alpha = 0
//        indicator.stopAnimating()
//        data = nil
////        data = paymentViewModel.data
//        if data!.data!.isEmpty{
//            errorLabel.alpha = 1
//            errorLabel.text = "لا يوجد طلبات خلال هذه الفترة الزمنية"
//        }else{
//            errorLabel.alpha = 0
//        }
//        tableView.reloadData()
//        if !data!.data!.isEmpty{
//            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//        
//    }
    func onFail(){
        
        data = nil
        tableView.reloadData()
        refreshControl.endRefreshing()
        indicator.stopAnimating()
//        errorLabel.text = paymentViewModel.errorMessage
        errorLabel.alpha = 1
        
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        indicator.startAnimating()
//        if segmentControl.selectedSegmentIndex == 0 {
//            paymentViewModel.destination = "me"
//        }
//        else{
//            paymentViewModel.destination = "others"
//        }
        isFromME.toggle()
//        paymentViewModel.performTheApiCallIFConnected()
        
    }
    
    func dropConfiguration() {
        dropList.layer.cornerRadius = 5
        dropList.layer.borderWidth = 1
        dropList.layer.borderColor = #colorLiteral(red: 1, green: 0.6077111959, blue: 0.2406056225, alpha: 1)
        dropList.optionArray = ["الكل","الاسبوع الحالي","الاسبوع السابق","الشهر الحالي ","الشهر السابق","السنه الحالية","السنه السابقة","منذ عامين"]
        dropList.selectedIndex = 0
        dropList.listHeight = 240
        dropList.text = "الكل"
        dropList.isSearchEnable = false
        dropList.rowBackgroundColor = .white
        dropList.selectedRowColor = .white
        dropList.checkMarkEnabled = false
        
//        dropList.didSelect{ [weak self](selectedText , index ,id)  in
//            guard let self = self else{return}
//            self.indicator.startAnimating()
//            switch(index){
//            case 0:
//                self.paymentViewModel.duration = "all"
//            case 1:
//                self.paymentViewModel.duration = "week"
//            case 2:
//                self.paymentViewModel.duration = "lastweek"
//            case 3:
//                self.paymentViewModel.duration = "month"
//            case 4:
//                self.paymentViewModel.duration = "lastmonth"
//            case 5:
//                self.paymentViewModel.duration = "year"
//            case 6:
//                self.paymentViewModel.duration = "lastyear"
//            case 7:
//                self.paymentViewModel.duration = "twoyearsago"
//
//            default:
//                break
//            }
//            self.paymentViewModel.performTheApiCallIFConnected()
//
//        }
    }
    
    @IBAction func goToProfile(_ sender: Any) {
//        let settingsVC = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//        self.navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    @objc func refresh(_ sender: AnyObject) {
//        paymentViewModel.performTheApiCallIFConnected()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}
//extension PaymentViewController:UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data?.data?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell") as! PaymentTableViewCell
//
//        cell.counter = indexPath.row
//
//        if isFromME{
//
//            cell.color = .orange
//            cell.isFromOthres = 0
//
//        }else{
//            cell.color = .gray
//            cell.isFromOthres = 1
//
//        }
//
//        let data = data!.data![indexPath.row]
//
//        cell.selectionStyle = .none
//        cell.width = tableView.frame.width
//        cell.data = self.data
//
//
////        cell.ordersNumber.text = "("+String(data.count ?? 0).toArabicNumber()+"طلب)"
////
////        cell.year.text = data.title
////        cell.startDate = data.start
////        cell.endDate = data.end
////
//        cell.onClickClouser = { [weak self] start,end  in
//
//            self?.moveToSeeAllVC(strat: start, end: end)
//        }
//        cell.detailsClosure = { [weak self] id in
//            guard let self = self else{return}
//            let vc = UIHostingController(rootView: PPDetailsView(id:id, isForwordToMe: self.isFromME))
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        }
//        return cell
//    }
//
//    func moveToSeeAllVC(strat:String,end:String){
//        let vc = UIHostingController(rootView: PPSeeAllView(startDate: strat, endDate: end, isForwordToMe: isFromME))
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 310
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
