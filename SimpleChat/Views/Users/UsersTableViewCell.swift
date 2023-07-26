//
//  UsersTableViewCell.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 26.07.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    static let identifier = "UsersTableViewCell"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingCell()
    }
    
    func configure(label: String, image: String){
        labelCell.text = label
        imageCell.image = UIImage(systemName: image)
    }
    
    private func settingCell(){
        mainView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
