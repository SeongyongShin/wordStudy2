//
//  ChapterCell.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/07.
//

import UIKit

class ChapterCell: UICollectionViewCell {

    @IBOutlet weak var chapterLabel: BaseLabel!
    @IBOutlet weak var backgroundV: UIView!
    @IBOutlet weak var smallText: BaseLabel!
    @IBOutlet weak var chapterIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.chapterLabel.setLanguage(text: "chapter")
        self.chapterLabel.sizeToFit()
//        self.smallText.sizeToFit()
        self.backgroundV.layer.cornerRadius = Constant.BASE_CORNER_RADIUS + 10
        self.layer.shadowColor = UIColor.black.cgColor // 색깔
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        self.layer.shadowRadius = 2 // 반경
        self.layer.shadowOpacity = 0.5 // alpha값
        self.chapterLabel.setFontSize(size: 25, weight: 1)
    }
    
    func convertLanguages(){
        self.chapterLabel.changeLanguage()
    }
    
    func smallMode(_ check: Int){
        if check == 1{
            self.smallText.isHidden = false
            self.chapterLabel.isHidden = true
            self.chapterIV.isHidden = true
        }else{
            self.smallText.isHidden = true
            self.chapterLabel.isHidden = false
            self.chapterIV.isHidden = false
        }
    }
    
}
