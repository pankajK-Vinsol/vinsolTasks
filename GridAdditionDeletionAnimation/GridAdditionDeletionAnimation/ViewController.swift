//
//  ViewController.swift
//  GridAdditionDeletionAnimation
//
//  Created by Pankaj kumar on 23/04/19.
//  Copyright © 2019 Pankaj kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var itemsList = ["a", "b", "c", "d","e", "f", "g", "h","i", "j", "k", "l","m", "n", "o", "p","q", "r", "s", "t","u", "v", "w", "x","y","z"]
    
    var interItemSpace: CGFloat = 5
    var cellWidth: CGFloat = 50
    var cellHeight: CGFloat = 50
    var lineSpace: CGFloat = 5
    var animationSpeed: Double = 3.0
    var itemsWidth = CGFloat()
    
    @IBOutlet weak var alphabetCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsWidth = cellWidth
    }
    
    @IBAction func configureScreen(_ sender: UIButton) {
        let nextVC: ConfigureViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConfigureViewController") as! ConfigureViewController
        nextVC.animationSpeed = animationSpeed
        nextVC.cellHeight = cellHeight
        nextVC.cellWidth = cellWidth
        nextVC.interItemSpace = interItemSpace
        nextVC.lineSpace = lineSpace
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func insertThreeEnd(_ sender: UIButton) {
        for _ in 0 ... 2 {
            itemsList.append("@")
            updateGrid(indexPath: IndexPath(item: itemsList.count - 1, section: 0), buttonTag: 1)
        }
    }
    
    @IBAction func deleteThreeEnd(_ sender: UIButton) {
        if itemsList.count > 2 {
            for _ in 0 ... 2 {
                itemsList.removeLast()
                updateGrid(indexPath: IndexPath(item: itemsList.count, section: 0), buttonTag: 2)
            }
        }
    }
    
    @IBAction func updateIndexTwo(_ sender: UIButton) {
        if itemsList.count > 2 {
            itemsList[2] = "2"
            updateGrid(indexPath: IndexPath(item: 2, section: 0), buttonTag: 3)
        }
    }
    
    @IBAction func moveItemE(_ sender: UIButton) {
        guard let eIndex = itemsList.firstIndex(where: { $0 == "e" }) else {
            return
        }
        itemsList.remove(at: eIndex)
        itemsList.append("e")
        updateGrid(indexPath: IndexPath(item: eIndex, section: 0), buttonTag: 4)
    }
    
    @IBAction func deleteThenInsert(_ sender: UIButton) {
        if itemsList.count > 2 {
            for _ in 0 ... 2 {
                itemsList.removeFirst()
                updateGrid(indexPath: IndexPath( item: 0, section: 0), buttonTag: 2)
                itemsList.append("&")
                updateGrid(indexPath: IndexPath(item: self.itemsList.count - 1 , section: 0), buttonTag: 1)
            }
        }
    }
    
    @IBAction func insertThenDelete(_ sender: UIButton) {
        if itemsList.count > 2 {
            for _ in 0 ... 2 {
                itemsList.append("#")
                updateGrid(indexPath: IndexPath(item: self.itemsList.count - 1 , section: 0), buttonTag: 1)
                itemsList.removeFirst()
                updateGrid(indexPath: IndexPath(item: 0, section: 0), buttonTag: 2)
            }
        }
    }
    
    func updateGrid(indexPath: IndexPath, buttonTag: Int) {
        let cell = alphabetCollection.cellForItem(at: indexPath)
        if buttonTag == 1 {
            UIView.animate(withDuration: animationSpeed, delay: 0.0, options: .transitionCrossDissolve, animations: {
                self.alphabetCollection.insertItems(at: [indexPath]) }, completion: nil)
        }
        if buttonTag == 2 {
            UIView.transition(with: cell!, duration: animationSpeed, options: .transitionFlipFromRight, animations: { self.alphabetCollection.deleteItems(at: [indexPath] )}, completion: nil)
        }
        if buttonTag == 3 {
            UIView.transition(with: cell!, duration: animationSpeed, options: .transitionCurlUp, animations: {         self.alphabetCollection.reloadItems(at: [indexPath]) }, completion: nil)
        }
        if buttonTag == 4 {
            UIView.transition(with: cell!, duration: animationSpeed, options: .transitionFlipFromRight, animations: { self.alphabetCollection.moveItem(at: indexPath, to: IndexPath(item: self.itemsList.count - 1, section: 0)) }, completion: nil)
        }
//        if buttonTag == 5 {
//            self.alphabetCollection.performBatchUpdates({ UIView.animate(withDuration: animationSpeed, delay: 0.0, options: .transitionFlipFromRight, animations: {
//                self.alphabetCollection.deleteItems(at: [IndexPath(item: 0, section: 0)])
//                self.alphabetCollection.insertItems(at: [indexPath]) } , completion: nil) }, completion: nil)
//        }
//        if buttonTag == 6 {
//            self.alphabetCollection.performBatchUpdates({ UIView.animate(withDuration: animationSpeed, delay: 0.0, options: .transitionFlipFromRight, animations: {
//                self.alphabetCollection.insertItems(at: [indexPath])
//                self.alphabetCollection.deleteItems(at: [IndexPath(item: 0, section: 0)]) } , completion: nil) }, completion: nil)
//        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = alphabetCollection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! alphabetCell
        cell.alphaLabel.text = itemsList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.alphabetCollection.cellForItem(at: IndexPath(item: indexPath.item, section: 0))
        itemsList.remove(at: indexPath.item)
        UIView.transition(with: cell!, duration: animationSpeed, options: .transitionFlipFromRight , animations: { self.alphabetCollection.deleteItems(at: [IndexPath(item: indexPath.item, section: 0)]) }, completion: nil)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let screenWidth = UIScreen.main.bounds.width
        while itemsWidth <= screenWidth {
            itemsWidth += cellWidth + interItemSpace
        }
        itemsWidth -= cellWidth + interItemSpace
        let spaceLeft = screenWidth - itemsWidth
        let leftEdgeSpace = spaceLeft / 2.0
        let rightEdgeSpace = spaceLeft / 2.0
        return UIEdgeInsets(top: 5, left: leftEdgeSpace, bottom: 5, right: rightEdgeSpace)
    }

}

extension ViewController: configureViewDelegate {
    
    func setValues(animate: Double, width: CGFloat, height: CGFloat, itemSpace: CGFloat, lineSpacing: CGFloat) {
        animationSpeed = animate
        cellWidth = width
        cellHeight = height
        interItemSpace = itemSpace
        lineSpace = lineSpacing
        itemsWidth = cellWidth
        alphabetCollection.reloadData()
    }
}
