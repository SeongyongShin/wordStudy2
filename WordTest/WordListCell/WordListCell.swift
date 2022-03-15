//
//  WordListCell.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/17.
//

import UIKit

class WordListCell: UICollectionViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var iKnowBtn: BaseButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentLabel.setLanguage(text: "chapter")
        self.firstLabel.sizeToFit()
        self.secondLabel.sizeToFit()
//        self.smallText.sizeToFit()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = Constant.BASE_CORNER_RADIUS + 10
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        self.layer.shadowRadius = 2 // 반경
        self.layer.shadowOpacity = 0.5 // alpha값
//        self.firstLabel.setFontSize(size: 20, weight: 1)
//        self.secondLabel.setFontSize(size: 20, weight: 1)
        self.iKnowBtn.setLanguage(text: "iknow")
        self.iKnowBtn.setFontSize(size: 10, weight: 1)
    }
    func convertLanguages(){
        self.iKnowBtn.changeLanguage()
    }
}
