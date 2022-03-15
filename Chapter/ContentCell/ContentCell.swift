//
//  ContentCell.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/10.
//

import UIKit

class ContentCell: UICollectionViewCell {

    @IBOutlet weak var contentIV: UIImageView!
    @IBOutlet weak var contentLabel: BaseLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentLabel.setLanguage(text: "chapter")
        self.contentLabel.sizeToFit()
//        self.smallText.sizeToFit()
        self.layer.cornerRadius = Constant.BASE_CORNER_RADIUS + 10
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        self.layer.shadowRadius = 2 // 반경
        self.layer.shadowOpacity = 0.5 // alpha값
        self.contentLabel.setFontSize(size: 20, weight: 1)
    }
    func convertLanguages(){
        self.contentLabel.changeLanguage()
    }
    
}
