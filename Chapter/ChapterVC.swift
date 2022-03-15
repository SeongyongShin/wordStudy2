//
//  ChapterVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/10.
//

import UIKit

class ChapterVC: BaseVC {

    @IBOutlet weak var changeLangBtn: BaseButton!
    @IBOutlet weak var contentCV: UICollectionView!
    let contentList_EN = ["KO-EN Test", "EN-KO Test", "Random Test", "Word List"]
    let contentList_KO = ["한-영 테스트", "영-한 테스트", "무작위 테스트", "단어장"]
    let contentList_ICON = ["list.bullet.rectangle", "list.bullet.rectangle.fill", "questionmark.circle.fill", "newspaper"]
    override func viewWillAppear(_ animated: Bool) {
        convertLanguage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTexts()
        self.setCV()
    }
    
    @IBAction func changeLang(_ sender: Any) {
        if Constant.LANGUAGE! == "eng"{
            Constant.LANGUAGE = "kor"
        }else{
            Constant.LANGUAGE = "eng"
        }
        self.convertLanguage()
    }
}

extension ChapterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList_EN.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as! ContentCell
//        cell.convertLanguages()
        cell.contentIV.image = UIImage(systemName: "\(contentList_ICON[indexPath.item])")
        if Constant.LANGUAGE == "eng"{
            cell.contentLabel.text = "\(self.contentList_EN[indexPath.item])"
        }else{
            cell.contentLabel.text = "\(self.contentList_KO[indexPath.item])"
        }
//        cell.chapterLabel.text = "\((Constant.CURRENT_MAIN_CHAPTER * 10) + indexPath.item + 1)"
        cell.tag = indexPath.item
        return cell
    }

    //챕터 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Constant.TEST_VERSION = collectionView.cellForItem(at: indexPath)!.tag
        
        if Constant.TEST_VERSION != 3{
            self.performSegue(withIdentifier: "goToWordTest", sender: self)
        }else{
            self.performSegue(withIdentifier: "goToWordList", sender: self)
        }
    }
    
}

extension ChapterVC{
    func setCV(){
        let nib = UINib(nibName: "ContentCell", bundle: nil)
        self.contentCV.register(nib, forCellWithReuseIdentifier: "ContentCell")
        self.contentCV.dataSource = self
        self.contentCV.delegate = self
        self.contentCV.collectionViewLayout = createCompositionalLayout(groupCount: 2)
    }
    
    func createCompositionalLayout(groupCount: Int) -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) ->
            NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/5))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize , subitem: item, count: groupCount)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            return section
        }
        
        return layout
    }
}
extension ChapterVC: ConvertLanguages{
    func convertLanguage() {
        self.changeLangBtn.changeLanguage()
        self.contentCV.reloadData()
    }
    
    func setTexts() {
        self.changeLangBtn.setLanguage(text: "changeLang")
    }
    @IBAction func unwindToTest(_ sender: UIStoryboardSegue) {
    }
}
