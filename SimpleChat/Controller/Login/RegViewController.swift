//
//  RegViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeVCBtn(_ sender: Any) {
        delegate?.closeVC()
    }
}
