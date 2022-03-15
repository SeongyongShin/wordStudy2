//
//  WordModel.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/09.
//

import Foundation
struct Datas: Codable{
    var chapter: Int
    var Words: [Word]
}
struct Word: Codable{
    var engWord: String
    var korWord: String
}
