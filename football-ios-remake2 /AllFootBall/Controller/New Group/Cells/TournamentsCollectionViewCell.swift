//
//  TournamentsCollectionViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/08/2021.
//

import UIKit

class TournamentsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblNameTour: UILabel!
    @IBOutlet weak var tourView: UIView!
    func configure() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
