//
//  Constant.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import Foundation
import UIKit

struct Constant{
    //설정 언어
    static var LANGUAGE: String? = UserDefaults.standard.string(forKey: "language") ?? "eng" {
        didSet {
            guard let lang = LANGUAGE else { return }
            UserDefaults.standard.setValue(lang, forKey: "language")
        }
    }
    
    static var BASE_CORNER_RADIUS: CGFloat = 5
    static var CURRENT_MAIN_CHAPTER = 1
    static var CURRNET_SUB_CHAPTER = 1
    static var WORD_DATA: [Datas]? = nil{
        didSet{
            self.READY = true
        }
    }
    static var READY = false
    static var CHAPTER_COUNT = 20
    static var TEST_VERSION = 0
}

