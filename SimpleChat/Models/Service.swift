//
//  Service.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 19.07.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class Service {
    static let shared = Service()
    init(){}
    
    func createNewUser(_ data: LogiField, completion: @escaping (ResponceCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) {[weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String : Any] = ["email" : email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    completion(ResponceCode(code: 1))
                }
            } else {
                completion(ResponceCode(code: 0))
            }
        }
    }
    ///проверка по email
    func confrimeEmail(){
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if error == nil {
                print(error?.localizedDescription)
            }
        })
    }
    func authInApp(data: LogiField, completion: @escaping (AuthResponse)->()){
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                completion(.error)
            }
            if let result {

                if result.user.isEmailVerified { // если email подтвердил то вход
                    completion(.success)
                } else {
                    self.confrimeEmail()
                    completion(.noVerify)
                }
            }
        }
    }
}
