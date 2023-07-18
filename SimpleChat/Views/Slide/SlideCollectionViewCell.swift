//
//  SlideCollectionViewCell.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 14.07.2023.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    static let reuceId = "SlideCollectionViewCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var slideImg: UIImageView!
    
    @IBOutlet weak var btnAuth: UIButton!
    @IBOutlet weak var btnReg: UIButton!
    
    var delegate: LoginViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func regBtn(_ sender: Any) {
        delegate?.openRegVC()
    }
    @IBAction func authBtn(_ sender: Any) {
        delegate?.openAuthVC()
    }
    
    func config(slide: Slide){
        descriptionLabel.text = slide.text
        slideImg.image = slide.img
        
        if slide.id == 3 {
            btnAuth.isHidden = false
            btnReg.isHidden = false
        }
    }
    
    
}
