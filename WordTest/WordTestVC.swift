//
//  WordTestVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/12.
//

import UIKit

class WordTestVC: BaseVC {
    var is_Eng = true
    var count = 0
    var wordIndex = Array<Int>(0 ... (Constant.CHAPTER_COUNT - 1)).shuffled()
    var wordCount = 0
    var answer = Int.random(in: 0 ... 3)
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet var selectLabel: [SelectLabel]!
    @IBOutlet weak var selectStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wordCount = wordIndex[0]
        self.setTest(wordIndex[0])
        var temp_count = 0
        for i in selectLabel{
            i.tag = temp_count
            temp_count += 1
            i.isUserInteractionEnabled = true
            i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchLabel)))
        }
    }
    
    func setTest(_ num: Int){
        if num > Constant.CHAPTER_COUNT{
            return
        }
        if Constant.TEST_VERSION == 0{
            is_Eng = false
        }
        if Constant.TEST_VERSION == 2{
            is_Eng = !is_Eng
        }
        
        wordLabel.text = self.getWord(wordCount, is_Eng: is_Eng)
        for i in selectLabel{
            i.text = self.getRandomExample(Int.random(in: 0 ... (Constant.CHAPTER_COUNT - 1)), is_Eng: !is_Eng)
        }
        selectLabel[answer].text = self.getWord(wordCount, is_Eng: !is_Eng)
        
    }
    @IBAction func onNextPressed(_ sender: BaseButton) {
        self.count += 1
        if count >= Constant.CHAPTER_COUNT{
            return
        }
        self.wordCount = wordIndex[count]
        self.answer = Int.random(in: 0...3)
        self.setTest(wordCount)
        for i in selectLabel{
            i.backgroundColor = .white
        }
    }
    
   @objc func touchLabel(sender: UITapGestureRecognizer) {
       if sender.view!.tag == self.answer{
           self.selectLabel[sender.view!.tag].backgroundColor = .green
       }else{
           self.selectLabel[sender.view!.tag].backgroundColor = .red
           self.selectLabel[answer].backgroundColor = .green
       }
   }
    
    func getWord(_ num: Int, is_Eng: Bool) -> String{

        if is_Eng{
            return Constant.WORD_DATA![Constant.CURRNET_SUB_CHAPTER].Words[num].engWord
        }else{
            return Constant.WORD_DATA![Constant.CURRNET_SUB_CHAPTER].Words[num].korWord
        }
    }
    
    func getRandomExample(_ num: Int, is_Eng: Bool) -> String{
        while 1 > 0 {
            let ranInteger = Int.random(in: 0 ... (Constant.CHAPTER_COUNT - 1))
            if ranInteger != Constant.CURRNET_SUB_CHAPTER{
                if is_Eng{
                    return Constant.WORD_DATA![ranInteger].Words[num].engWord
                }else{
                    return Constant.WORD_DATA![ranInteger].Words[num].korWord
                }
            }
        }
    }
}
