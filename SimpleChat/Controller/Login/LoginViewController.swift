//
//  LoginViewController.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 14.07.2023.
//

import UIKit


protocol LoginViewControllerDelegate {
    func openRegVC()
    func openAuthVC()
    func closeVC()
    func startVC()
}

class LoginViewController: UIViewController {
    var authVC: AuthViewController!
    var regVC: RegViewController!
    
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
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}

//MARK: - LoginViewControllerDelegate
extension LoginViewController: LoginViewControllerDelegate {
   
    func openAuthVC() {
        authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController
        authVC.delegate = self
        self.view.insertSubview(authVC.view, at: 1)
    }
    
    func openRegVC() {
        regVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegViewController") as? RegViewController
        regVC.delegate = self
        self.view.insertSubview(regVC.view, at: 1)
    }
    
    func closeVC() {
        if self.authVC != nil {
            self.authVC.view.removeFromSuperview()
            self.authVC = nil
        }
        if self.regVC != nil {
            self.regVC.view.removeFromSuperview()
            self.regVC = nil
        }
    }
    
    func startVC(){
        let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController")
        self.view.insertSubview(startVC.view, at: 2) // Вывожу startVC поверх открытого вью, а при следующем входе пользователь сразу попадет TabBarController
    }
}
