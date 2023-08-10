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
    
    func getAllUsers(completion: @escaping ([CurrentUser])->()){
        //addSnapshotListener - активный слушатель изменений
        //getDocuments - просто получает данные и все
        guard let email = Auth.auth().currentUser?.email else { return }//свой email
        
        var currentUsers = [CurrentUser]()
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email) //убирамем свой email
            .getDocuments { querySnapshot, error in
            if error == nil {
                if let docs = querySnapshot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let docID = doc.documentID //id
                        let email = data["email"] as! String
                        currentUsers.append(CurrentUser(id: docID, email: email))
                    }
                }
                completion(currentUsers)
            }
        }
        
    }
    
    
    //MARK: - Messanger
    func sendMessage(otherID: String?, convId: String?,text: String, completion: @escaping (String)->()){
        let ref = Firestore.firestore()
        if let uId = Auth.auth().currentUser?.uid { //сущесвует ли пользователь
            
            if convId == nil {
                ///создаем новую переписку
                let convId = UUID().uuidString
                
                let selfDate: [ String: Any ] = [
                    "date": Data(),
                    "otherId": otherID!
                ]
                
                let otherDate: [ String: Any ] = [
                    "date": Data(),
                    "otherId": uId
                ]
                
                //переписка с человеком Х у нас есть
                ref.collection("users")
                    .document(uId)
                    .collection("conversation")
                    .document(convId)
                    .setData(selfDate)
                
                
                //переписка с нами у человека Х
                ref.collection("users")
                    .document(otherID!)
                    .collection("conversation")
                    .document(convId)
                    .setData(otherDate)
                
                let msg: [String: Any] = [
                    "date": Data(),
                    "sender": uId,
                    "text": text
                ]
                
                let convInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uId,
                    "otherSender": otherID
                ]
                
                ref.collection("conversation")
                    .document(convId)
                    .setData(convInfo) { err in
                        if let err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        ref.collection("conversation")
                            .document(convId)
                            .collection("messages")
                            .addDocument(data: msg) { err in
                                if err == nil {
                                    completion(convId)
                                }
                            }
                    }
                
            } else {
                let msg: [String: Any] = [
                    "date": Data(),
                    "sender": uId,
                    "text": text
                ]
                Firestore.firestore().collection("conversation").document(convId!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(convId!)
                    }
                    
                }
            }
        }
        
    }
    
    func updateConv(){
        
    }
    
    func getConvId(otherID: String, completion: @escaping (String)->()){
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users")
                .document(uid)
                .collection("conversation")
                .whereField("otherId", isEqualTo: otherID)
                .getDocuments { snap, err in
                    if let err {
                        return
                    }
                    
                    if let snap, !snap.documents.isEmpty {
                        let doc = snap.documents.first
                        if let convID = doc?.documentID {
                            completion(convID)
                        }
                    }
                }
        }
    }
    
    func getAllMessages(chatId: String, completion: @escaping ([Message])->()) {
        if let uid = Auth.auth().currentUser?.uid {

            let ref = Firestore.firestore()
            ref.collection("conversation")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false) ///sorted per date
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
//                    Message(sender: selfSender, messageId: "124", sentDate: Date(), kind: .text(text))
                    if let snap, !snap.documents.isEmpty {
                        var msg = [Message]()
                        var sender = Sender(senderId: uid, displayName: "Me")
                        for doc in snap.documents {
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            let messageId = doc.documentID
                            
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                            
                            msg.append(Message(sender: sender, messageId: messageId, sentDate: sentDate, kind: .text(text)))
                        }
                        completion(msg)
                    }
                }
        }
    }
    
    func getOneMessages(){
        
    }
}
