//
//  AuthViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    var delegate: LoginViewControllerDelegate!
    var service = Service.shared
    var checkField = CheckField.shared
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeEditing))
        mainView.addGestureRecognizer(tapGestureRecognizer!)

    }
    
    @objc func closeEditing(){
        self.view.endEditing(true)
    }

    @IBAction func closeVCBtn(_ sender: Any) {
        delegate?.closeVC()
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        if checkField.validField(emailView, emailField),
           checkField.validField(passwordView, passwordField) {
            
            service.authInApp(data: LogiField(email: emailField.text!, password: passwordField.text!)) {[weak self] responce in
                switch responce {
                case .success:
                    self?.userDefaults.set(true, forKey: "isLogin") //Пользователь вошел и в следующий заход не будет авторизововаться
                    self!.delegate.openAuthVC()
                    self!.delegate.closeVC()

                case .error:
                    let alert = self?.alertAction("Error Email or password", "Email или пароль не подошли")
                    let okBtn = UIAlertAction(title: "Ok", style: .cancel)
                    alert?.addAction(okBtn)
                    self?.present(alert!, animated: true)

                case .noVerify:
                    let alert = self?.alertAction("Error not auth", "Вы не авторизовались, на вашу почту отправлено подтверждение ")
                    let okBtn = UIAlertAction(title: "Ok", style: .cancel)
                    self!.service.confrimeEmail() ///проверка по email
                    alert?.addAction(okBtn)
                    self?.present(alert!, animated: true)
                }
            }
        }
        let alert = alertAction("Успешно", "Вы успешно авторизовались )")
        let okBtn = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okBtn)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate.startVC()
        }
    }
    
    func alertAction(_ header: String?,_ message: String?)-> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
}
