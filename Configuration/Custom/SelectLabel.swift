//
//  SelectLabel.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import UIKit

class SelectLabel: UILabel {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = Constant.BASE_CORNER_RADIUS
        self.layer.borderWidth = 2


    }
    
}
