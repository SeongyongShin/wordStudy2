//
//  SubVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/09.
//

import UIKit

class SubVC: BaseVC {
    @IBOutlet weak var changeLangBtn: BaseButton!
    override func viewWillAppear(_ animated: Bool) {
        convertLanguage()
    }
    @IBOutlet weak var chapterCV: UICollectionView!
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

extension SubVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if Constant.CURRENT_MAIN_CHAPTER == (Constant.WORD_DATA!.count / 10){
            return Constant.WORD_DATA!.count % 10
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath) as! ChapterCell
        cell.convertLanguages()
        if Constant.LANGUAGE == "eng"{
            cell.chapterLabel.text = "\(cell.chapterLabel.text!) \((Constant.CURRENT_MAIN_CHAPTER * 10) + indexPath.item + 1)"
        }else{
            cell.chapterLabel.text = "\((Constant.CURRENT_MAIN_CHAPTER * 10) + indexPath.item + 1) \(cell.chapterLabel.text!)"
        }
        
        cell.tag = (Constant.CURRENT_MAIN_CHAPTER * 10) + indexPath.item
        
        cell.smallMode(0)
        return cell
    }

    //챕터 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToChapter", sender: self)
        Constant.CURRNET_SUB_CHAPTER = collectionView.cellForItem(at: indexPath)!.tag
    }
}
extension SubVC{
    func setCV(){
        let nib = UINib(nibName: "ChapterCell", bundle: nil)
        self.chapterCV.register(nib, forCellWithReuseIdentifier: "ChapterCell")
        self.chapterCV.dataSource = self
        self.chapterCV.delegate = self
        self.chapterCV.collectionViewLayout = createCompositionalLayout(groupCount: 1)
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
    
    @IBAction func unwindToSub(_ sender: UIStoryboardSegue) {
    }
}
extension SubVC: ConvertLanguages{
    func convertLanguage() {
        self.changeLangBtn.changeLanguage()
        self.chapterCV.reloadData()
    }
    
    func setTexts() {
        self.changeLangBtn.setLanguage(text: "changeLang")
    }
    
}
