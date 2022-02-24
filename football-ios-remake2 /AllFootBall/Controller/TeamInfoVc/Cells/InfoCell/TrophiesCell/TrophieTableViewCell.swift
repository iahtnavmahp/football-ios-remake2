//
//  TrophieTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 26/07/2021.
//

import UIKit

class TrophieTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrophieCollectionViewCell", for: indexPath) as! TrophieCollectionViewCell
        cell.lblTropy?.text = lists[indexPath.row + 1].season_name
        
        return cell
    }
    func configure(with lists : [Lists]){
        self.lists = lists
        
        myCollectionView.reloadData()
    }
   
    var lists = [Lists]()
    
    @IBOutlet weak var lblCompetition: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: "TrophieCollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "TrophieCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        myCollectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 100 , height: 60)
        layout.scrollDirection = .horizontal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
