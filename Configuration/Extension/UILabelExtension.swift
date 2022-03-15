//
//  UILabelExtension.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import Foundation
import UIKit

extension UILabel{
    func countLabelLines(label: UILabel) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = label.text! as NSString

        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font as Any], context: nil)

        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
}
