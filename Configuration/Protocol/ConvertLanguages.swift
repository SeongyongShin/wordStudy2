//
//  ConvertLanguages.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/07.
//

import Foundation

protocol ConvertLanguages{
    // 언어 변경 부분
    func convertLanguage() -> Void
    // 초기 라벨과 버튼 등의 텍스트 설정.
    func setTexts() -> Void
}
