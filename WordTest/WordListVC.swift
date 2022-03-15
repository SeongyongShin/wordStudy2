//
//  WordListVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/16.
//

import UIKit

class WordListVC: BaseVC {

    @IBOutlet weak var contentCV: UICollectionView!

    @IBOutlet weak var changeLangBtn: BaseButton!
    @IBOutlet weak var hideBtn: BaseButton!
    
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
        self.contentCV.reloadData()
    }
    @IBAction func hideMeaning(_ sender: Any) {
    }
}

extension WordListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.CHAPTER_COUNT
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordListCell", for: indexPath) as! WordListCell
        
        var first = Constant.WORD_DATA![Constant.CURRNET_SUB_CHAPTER].Words[indexPath.item].engWord
        var second = Constant.WORD_DATA![Constant.CURRNET_SUB_CHAPTER].Words[indexPath.item].korWord
        if Constant.LANGUAGE == "kor"{
            swap(&first, &second)
        }
        
        cell.firstLabel.text = first
        cell.secondLabel.text = second
        
        cell.convertLanguages()
        cell.tag = indexPath.item
        return cell
    }

    //챕터 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}


extension WordListVC{
    func setCV(){
        let nib = UINib(nibName: "WordListCell", bundle: nil)
        self.contentCV.register(nib, forCellWithReuseIdentifier: "WordListCell")
        self.contentCV.dataSource = self
        self.contentCV.delegate = self
        self.contentCV.collectionViewLayout = createCompositionalLayout(groupCount: 1)
    }
    
    func createCompositionalLayout(groupCount: Int) -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) ->
            NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize , subitem: item, count: groupCount)
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            return section
        }
        
        return layout
    }
}

extension WordListVC: ConvertLanguages{
    func convertLanguage() {
        self.changeLangBtn.changeLanguage()
        self.hideBtn.changeLanguage()
//        self.contentCV.reloadData()
    }
    
    func setTexts() {
        self.changeLangBtn.setLanguage(text: "changeLang")
        self.hideBtn.setLanguage(text: "hide")
    }
}
