//
//  ViewController.swift
//  MYgraine
//
//  Created by Anthony Crawley on 7/7/20.
//  Copyright © 2020 Anthony Crawley. All rights reserved.
//

import UIKit
import FirebaseAuth

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        validateAuth()

    }

    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

