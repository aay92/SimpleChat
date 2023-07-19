//
//  RegViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class RegViewController: UIViewController {
    
    @IBOutlet weak var eamilField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var rePasswordField: UITextField!
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var rePasswordView: UIView!
    
    
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var tapGestureRecognizer = UITapGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeEditing))
        mainView.addGestureRecognizer(tapGestureRecognizer)

    }
    
    @objc func closeEditing(){
        self.view.endEditing(true)
    }
    
    @IBAction func closeVCBtn(_ sender: Any) {
        delegate?.closeVC()
    }
}
