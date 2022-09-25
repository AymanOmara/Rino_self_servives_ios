//
//  ViewController.swift
//  Rino
//
//  Created by Ayman Omara on 26/08/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        translateBackButtonTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func loginBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        loginVC.modalPresentationStyle = .formSheet

        self.present(loginVC, animated: true, completion: nil)
        
    }
    
}

