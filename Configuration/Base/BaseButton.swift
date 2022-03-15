//
//  BaseButton.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import UIKit

class BaseButton: UIButton {

    var textState: String?
    
    func setLanguage(text: String){
        
        if Constant.LANGUAGE! == "eng"{
            self.setTitle(Texts.eng[text]!, for: .normal)
        }else{
            self.setTitle(Texts.kor[text]!, for: .normal)
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
            self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .medium)
        }else if weight == 1{
            self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .bold)
        }else{
            self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .heavy)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = Constant.BASE_CORNER_RADIUS
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        self.layer.shadowRadius = 2 // 반경
        self.layer.shadowOpacity = 0.5 // alpha값
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.backgroundColor = .white
    }
}
