//
//  IntroVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/06.
//

import UIKit

class IntroVC: BaseVC {

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var introLabel: BaseLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introLabel.adjustSizeAnimation(scale: 0.99, before: 1.0, duration: 0.3)
        introLabel.text = "Let's study word!\n단어공부를 해보자!"
        startLabel.text = "Touch to start!\n터치하여 시작하기!"
        DispatchQueue.global().async {
            self.makeChapter()
        }
    }

    @IBAction func startClicked(_ sender: Any) {
        if Constant.READY{
            self.makeRootVC("Main", "Main")
        }
    }
}

extension IntroVC{
    func makeChapter(){
        let filePath = Bundle.main.path(forResource: "data", ofType: "json")
        let content = try! String(contentsOfFile: filePath!)
        let data: Data! = content.data(using: .utf8)
        let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
        var count = 1
        var chapter = 1
        var dataList: [Datas] = []
        var temp: Datas = Datas(chapter: 1, Words: [])
        
        for i in 0 ... (json!.count - 1){
            let tempData = json!["\(i)"] as! [String: String]
            if count > Constant.CHAPTER_COUNT{
                count = 1
                chapter += 1
                dataList.append(temp)
                temp.chapter = chapter
                temp.Words.removeAll()
            }
            if i == (json!.count - 1){
//                dataList.append(temp)
                temp.Words.append(Word(engWord: tempData["word"]!, korWord: tempData["mean"]!))
                temp.chapter = chapter
                dataList.append(temp)
                temp.Words.removeAll()
                continue
            }
            temp.Words.append(Word(engWord: tempData["word"]!, korWord: tempData["mean"]!))
            count += 1
        }
        Constant.WORD_DATA = dataList
    }
}
