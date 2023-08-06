//
//  MessageListViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 04.08.2023.
//

import UIKit

class MessageListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension MessageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Alex"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController()
        vc.chatID = "firstChatId"
        vc.otherID = "4igTzH446iV3rarIhpAHlPaBv7N2"
        navigationController?.pushViewController(vc, animated: true)
    }
}
