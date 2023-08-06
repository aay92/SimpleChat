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
    
    func getAllUsers(completion: @escaping ([String])->()){
        //addSnapshotListener - активный слушатель изменений
        //getDocuments - просто получает данные и все
        Firestore.firestore().collection("users").getDocuments { querySnapshot, error in
            if error == nil {
                var emailList = [String]()
                if let docs = querySnapshot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let email = data["email"] as! String
                        emailList.append(email)
                    }
                }
                completion(emailList)
            }
        }
        
    }
    
    
    //MARK: - Messanger
    func sendMessage(otherID: String?, convID: String?,text: String, message: Message, completion: @escaping (Bool)->()){
        if convID == nil {
            ///создаем новую переписку
        } else {
            let msg: [String: Any] = [
                "date": Data(),
                "sender": message.sender.senderId,
                "text": text
            ]
            Firestore.firestore().collection("conversation").document(convID!).collection("messages").addDocument(data: msg) { err in
                if err == nil {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
        }
    }
    
    func updateConv(){
        
    }
    
    func getConvId(){
        
    }
    
    func getAllMessages(){
        
    }
    
    func getOneMessages(){
        
    }
}
