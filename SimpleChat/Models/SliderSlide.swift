//
//  SliderSlide.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 15.07.2023.
//

import UIKit

class SliderSlide {
    
    func getSlider()-> [Slide]{
        var slides = [Slide]()
        let slide1 = Slide(id: 1, text: "Slide1", img: UIImage(named: "pic1")!)
        let slide2 = Slide(id: 2, text: "Slide2", img: UIImage(named: "pic2")!)
        let slide3 = Slide(id: 3, text: "Slide3", img: UIImage(named: "pic3")!)
        
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        
        return slides
    }
}
