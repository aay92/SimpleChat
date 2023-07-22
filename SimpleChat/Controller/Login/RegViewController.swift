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
    
    var service = Service.shared
    var delegate: LoginViewControllerDelegate!
    var checkField = CheckField.shared
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    
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
    ///Валидация ввода данных с текст филда
    @IBAction func regBtnClick(_ sender: Any) {
        if checkField.validField(viewEmail, eamilField),
           checkField.validField(passwordView, passwordField) {
            if passwordField.text == rePasswordField.text {
                service.createNewUser(LogiField(email: eamilField.text!, password: passwordField.text!)) {[weak self] code in
                    switch code.code {
                    case 0:
                        print("Ошибка регистрации")
                    case 1:
                        print("Успешная регистрация")
                        self?.service.confrimeEmail() ///проверка по email
                        let alert = UIAlertController(title: "Massege", message: "Success", preferredStyle: .alert)
                        let okBtn = UIAlertAction(title: "ok", style: .default) { _ in
                            self?.delegate?.closeVC()
                        }
                        alert.addAction(okBtn)
                        self?.present(alert, animated: true)
                    default:
                        print("Неизвестная ошибка")
                    }
                    
                }
                print("Поле корректное")
            } else {
                print("Пароли не совподают")
            }
        }
    }
}
