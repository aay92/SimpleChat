//
//  LoginViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 14.07.2023.
//

import UIKit

class LoginViewController: UIViewController {

    var collectionView: UICollectionView!
    var slides: [Slide] = []
    var sliderClass = SliderSlide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        slides = sliderClass.getSlider()
    }
    

    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // Отступы между коллескиями
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true // Страницы будут перекючаться по одному
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideCollectionViewCell.reuceId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reuceId)
    }

}

extension LoginViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuceId, for: indexPath) as! SlideCollectionViewCell
        let slider = slides[indexPath.row]
        cell.config(slide: slider)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}
