//
//  UsersViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users = [CurrentUser]()
    let service = Service.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: UsersTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        getUsers()
    }
    
    func getUsers(){
        service.getAllUsers { usersArray in
            self.users = usersArray
            self.tableView.reloadData()
        }
    }
}


extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
       return 80
    }
    
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as! UsersTableViewCell
        let cellName = users[indexPath.row]
        cell.configure(label: cellName.email, image: "person")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userId = users[indexPath.row].id
        let vc = ChatViewController()
        vc.otherID = userId // Выбираем пользователя по по нажатию(индексу)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
