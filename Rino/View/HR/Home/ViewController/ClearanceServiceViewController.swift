//
//  ClearanceServiceViewController.swift
//  Rino
//
//  Created by Ayman Omara on 23/09/2021.
//

import UIKit
import iOSDropDown
import MaterialActivityIndicator
import SwiftUI
class ClearanceServiceViewController: UIViewController, BaseViewController {
    var indicator = MaterialActivityIndicatorView()
    private  let refreshControl = UIRefreshControl()
    @IBOutlet weak private var errorLabel: UILabel!

    var isFromMe = true
    var destination = "me"
    @IBOutlet weak private var segmentControler: UISegmentedControl!
    var clearanceViewModel = ClearanceViewModel()
//    var data:Clearance?
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var dropMenu: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.addIndicatorToView(context: view)
//        clearanceViewModel.showLoading = {[weak self] in
//            guard let self = self else{return}
//            if self.clearanceViewModel.isLoading == true{
//                self.indicator.startAnimating()
//            }else if self.clearanceViewModel.isLoading == false{
//                self.indicator.stopAnimating()
//
//            }
//        }
        tableConfiguration()
        bindData()


        
        dropConfiguration()
    }
    func bindData() {

    }
    func tableConfiguration(){
        tableView.tableFooterView = UIView()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)

    }
    @objc func refresh(_ sender: AnyObject) {
//        refreshControl.beginRefreshing()
        clearanceViewModel.fetchData()
    }
    @IBAction func segmentAction(_ sender: Any) {
        isFromMe.toggle()
        if segmentControler.selectedSegmentIndex == 0{
            destination = "me"
            clearanceViewModel.destination = destination

//            high = 410
        }
        else if segmentControler.selectedSegmentIndex == 1 {
            clearanceViewModel.destination = "others"
            destination = "others"
//            high = 450
        }
//        clearanceViewModel.performTheApiCallIFConnected()
    }
    func dropConfiguration() {
        dropMenu.optionArray = ["الكل","الاسبوع الحالي","الاسبوع السابق","الشهر الحالي ","الشهر السابق","السنه الحاليه","السنه السابقه","منذ عامين"]
        dropMenu.selectedIndex = 0
        dropMenu.listHeight = 240
        dropMenu.text = "الكل"
        dropMenu.isSearchEnable = false
        dropMenu.rowBackgroundColor = .white
        dropMenu.selectedRowColor = .white
        dropMenu.checkMarkEnabled = false
        applyfiltration()
        
    }
    func applyfiltration(){
        dropMenu.didSelect{[weak self] (selectedText , index ,id) in
            guard let self = self else {return}
            self.indicator.startAnimating()
            switch(index){
            case 0:
                self.clearanceViewModel.duration = "all"
            case 1:
                self.clearanceViewModel.duration = "week"
            case 2:
                self.clearanceViewModel.duration = "lastweek"
            case 3:
                self.clearanceViewModel.duration = "month"
            case 4:
                self.clearanceViewModel.duration = "lastmonth"
            case 5:
                self.clearanceViewModel.duration = "year"
            case 6:
                self.clearanceViewModel.duration = "lastyear"
            case 7:
                self.clearanceViewModel.duration = "twoyearsago"
                
            default:
                break
//                print("")
            }
//            self.clearanceViewModel.performTheApiCallIFConnected()
            
        }
    }
    @IBAction func goToSearch(_ sender: UIBarButtonItem) {
        let vc = UIHostingController(rootView: HRSearchView())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
//    func moveToSeeAllVC(strat:String,end:String,entity:String) {
//        let vc = UIHostingController(rootView: HRSeeAll(start: strat, end: end, isFromME: isFromMe))
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
//extension ClearanceServiceViewController: UITableViewDelegate , UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data?.data?.count ?? 0
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ClearanceTableViewCell") as! ClearanceTableViewCell
////        cell.startDate = data?.data![indexPath.row].start
////        cell.endDate = data?.data![indexPath.row].end
//        
//        cell.counter = indexPath.row
//        cell.width = tableView.frame.width
//        cell.seeAllClosure = { [weak self] start,end,entity in
//            guard let self = self else{return}
//            self.moveToSeeAllVC(strat: start, end: end, entity: entity)
//            
//        }
//        cell.orderNumberClearance.text = "("+String(data!.data![indexPath.row].count ?? 0).toArabicNumber()+"طلب)"
//        cell.yearClearance.text = data!.data![indexPath.row].title
//        cell.data = data
//        cell.isFromMe = isFromMe
//        cell.detailsClosure = {[weak self] id,entity in
//            guard let self = self else{return}
//            self.moveToClearanceDetails(id: id,entity: entity)
//        }
//        
//        return cell
//    }
//    func moveToClearanceDetails(id:Int,entity:Int){
//        let vc = UIHostingController(rootView: HRDetailsView(id: id, isForwordToMe: self.isFromMe, entity: entity))
//        self.navigationController?.pushViewController(vc, animated: true)
////        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ClearanceDetailsViewController") as! ClearanceDetailsViewController
//////        detailsVC.clearnaceViewModel.id = String(id)
////        detailsVC.clearnaceViewModel.entity = String(entity)
////
////        detailsVC.isFromMe = isFromMe
////        self.navigationController?.pushViewController(detailsVC, animated: true)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }
//    
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }
//}
