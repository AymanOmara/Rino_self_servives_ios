//
//  LogInViewController.swift
//  Rino
//
//  Created by Ayman Omara on 26/08/2021.
//

import UIKit
import MaterialActivityIndicator
import MaterialComponents
class LogInViewController: UIViewController ,PasswordAble{
    let indicator = MaterialActivityIndicatorView()
    @IBOutlet weak private var topView: UIView!
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var userName: MDCOutlinedTextField!
    @IBOutlet weak private var password: MDCOutlinedTextField!
    private var showAndHidePass:UIButton!
    private var mainVC:TabBar!
    var logInViewModel = LogInViewModel()
    var storyBoard:UIStoryboard!
    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        indicator.addIndicatorToView(context: view)
        bindData()
        translateBackButtonTitle()
        mainVC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as? TabBar
        mainVC.modalTransitionStyle = .partialCurl
        mainVC.modalPresentationStyle = .fullScreen
        userName.delegate = self
        password.delegate = self
        password.isSecureTextEntry = true
        userName.autocorrectionType = .no
        showAndHidePass = UIButton(frame: CGRect(x: 40, y: 40, width: 40, height: password.frame.size.height))
        showAndHidePass.addTarget(self, action: #selector(showAndHide), for: .touchUpInside)
        handelView()
        setUpTextFieldHeader()
        addSeePasswordIcon()
        showAndHidePass.setImage(UIImage(named: "showPassword"), for: .normal)
    }
    @objc func showAndHide(_ sender: UIButton) {
        password.isSecureTextEntry.toggle()
        if password.isSecureTextEntry{
            showAndHidePassword(btn: showAndHidePass, img: UIImage(named: "showPassword")!)
        }else{
            showAndHidePassword(btn: showAndHidePass, img: UIImage(named: "hidePassword")!)
        }
    }
    func addSeePasswordIcon(){
        password.rightViewMode = .always
        password.rightView = showAndHidePass
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    func bindData()  {
//        logInViewModel.showLoading = {[weak self] in
//            guard let self = self else {return}
//            if self.logInViewModel.startLoding{
//                self.indicator.startAnimating()
//            }else{
//                self.indicator.stopAnimating()
//
//            }
//        }
//        logInViewModel.bindErrorToView = {[weak self] in
//            guard let self = self else{return}
//
//            self.showAlert(message: self.logInViewModel.errorMessage, title: "خطأ", shouldNavigate: false, distaination: nil)
//            if self.logInViewModel.errorMessage == MessagesToUser.invaliadLogIn.message{
//                self.userName.text = ""
//                self.password.text = ""
//            }
//        }
//        logInViewModel.bindDataToView = {[weak self] in
//            guard let self = self else{return}
//            if self.logInViewModel.isSuccessfulLogIn{
//                let viewController = self.storyBoard.instantiateViewController(withIdentifier: "TabBar") as! TabBar
//                UIApplication.shared.windows.first?.rootViewController = viewController
//                UIApplication.shared.windows.first?.makeKeyAndVisible()
//                self.navigationController?.pushViewController(self.mainVC, animated: true)
////                self.showAlert(message: MessagesToUser.logInComplete.message, title: "نجح", shouldNavigate: true, distaination: self.mainVC)
//            }
//        }
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func handelView(){
        topView.backgroundColor = UIColor(white: 1, alpha: 0.000001)
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.000001)
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(clickAction(sender:)))
        topView.addGestureRecognizer(gesture)
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {
        logInViewModel.userName = userName.text!
        logInViewModel.password = password.text!
    }
    
    @IBAction func cnceleTheRequesr(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goToMainVC(_ sender: Any) {
        let screen = UIStoryboard(name: "Screen", bundle: nil)
        let secondViewController = screen.instantiateViewController(withIdentifier: "")
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    private func setUpTextFieldHeader(){
        userName.label.text = "البريد الالكتروني"
        password.label.text = "كلمة المرور"
    }
//AF
    
    @IBAction func moveToReSetPassword(_ sender: Any) {
        
    }
}
extension LogInViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
}
protocol PasswordAble{
    func showAndHidePassword(btn:UIButton,img:UIImage)
    func showPassowrd(textField:MDCOutlinedTextField,btn:UIButton)
}
extension PasswordAble{
    func showAndHidePassword(btn:UIButton,img:UIImage){
        btn.setImage(img, for: .normal)
        btn.setImage(img, for: .focused)
        btn.setImage(img, for: .selected)
    }
    func showPassowrd(textField:MDCOutlinedTextField,btn:UIButton){
        textField.rightViewMode = .always
        textField.rightView = btn
    }
}
