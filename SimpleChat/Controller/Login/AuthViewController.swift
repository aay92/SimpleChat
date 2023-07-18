//
//  AuthViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class AuthViewController: UIViewController {

    var delegate: LoginViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  

    @IBAction func closeVCBtn(_ sender: Any) {
        delegate?.closeVC()
    }
}
