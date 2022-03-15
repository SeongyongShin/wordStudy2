//
//  MainVC.swift
//  wordstudy
//
//  Created by 신성용 on 2022/01/07.
//

import UIKit

class MainVC: BaseVC{
    @IBOutlet weak var changeLangBtn: BaseButton!
    @IBOutlet weak var chapterCV: UICollectionView!
    var chapterIndex = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        convertLanguage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTexts()
        setCV()
    }
    @IBAction func changeLang(_ sender: Any) {
        if Constant.LANGUAGE! == "eng"{
            Constant.LANGUAGE = "kor"
        }else{
            Constant.LANGUAGE = "eng"
        }
        self.convertLanguage()
    }
    @IBAction func onTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            self.chapterIndex = 0
            self.chapterCV.collectionViewLayout = createCompositionalLayout(groupCount: 1)
        case 1:
            self.chapterIndex = 1
            self.chapterCV.collectionViewLayout = createCompositionalLayout(groupCount: 3)
        default:
            break
        }
        
        for i in self.chapterCV.visibleCells {
            let cell = i as! ChapterCell?
            cell?.smallMode(self.chapterIndex)
        }

        self.chapterCV.contentOffset.y = 0
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var extraChapter = 0

        if !Constant.READY{
            Thread.sleep(forTimeInterval: 2)
        }
        if (Constant.WORD_DATA!.count % 10) > 0{
            extraChapter = 1
        }
        return (Constant.WORD_DATA!.count / 10) + extraChapter
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath) as! ChapterCell
        cell.convertLanguages()
        var count = 1
        if indexPath.item != 0{
            count = (indexPath.item * 10) + 1
        }
        var counts = (indexPath.item + 1) * 10
        if indexPath.item == Constant.WORD_DATA!.count / 10{
            counts = Constant.WORD_DATA!.count
        }
        if Constant.LANGUAGE == "eng"{
            cell.chapterLabel.text = "\(cell.chapterLabel.text!) \(count) ~ \(counts)"
            cell.smallText.text = "CH. \(count) ~ \(counts)"
        }else{
            cell.chapterLabel.text = "\(count) ~ \(counts) \(cell.chapterLabel.text!)"
            cell.smallText.text = "\(count) ~ \(counts) 장"
        }
        cell.tag = indexPath.item
        cell.smallMode(self.chapterIndex)
        return cell
    }

    
    //챕터 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        Constant.CURRENT_MAIN_CHAPTER = collectionView.cellForItem(at: indexPath)!.tag
        self.performSegue(withIdentifier: "goToChapterList", sender: self)
    }
}


extension MainVC: ConvertLanguages{
    func convertLanguage() {
        self.changeLangBtn.changeLanguage()
        self.chapterCV.reloadData()
    }
    
    func setTexts() {
        self.changeLangBtn.setLanguage(text: "changeLang")
    }
    
}

extension MainVC{
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
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
    }
}
