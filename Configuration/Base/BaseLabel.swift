//
//  BaseLabel.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import UIKit

class BaseLabel: UILabel {
    
    var textState: String?
    
    func adjustSizeAnimation(scale: CGFloat, before: CGFloat, duration: CGFloat){
        self.sizeToFit()
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: {
            finished in
            self.adjustSizeAnimation(scale: before, before: scale, duration: duration)
        })
    }
    
    func setLanguage(text: String){
        
        if Constant.LANGUAGE! == "eng"{
            self.text = Texts.eng[text]!
        }else{
            self.text = Texts.kor[text]!
        }
        self.textState = text
    }
    
    func changeLanguage(){
        if let texts = textState{
            self.setLanguage(text: texts)
        }
    }
    
    func setFontSize(size: CGFloat, weight: Int){
        if weight == 0{
            self.font = UIFont.systemFont(ofSize: size, weight: .medium)
        }else if weight == 1{
            self.font = UIFont.systemFont(ofSize: size, weight: .bold)
        }else{
            self.font = UIFont.systemFont(ofSize: size, weight: .heavy)
        }
    }

}
