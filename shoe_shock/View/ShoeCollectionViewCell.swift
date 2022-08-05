//
//  ShoeCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

protocol ShoeCollectionViewCellDelegate: AnyObject {
    func specificShoeTranny(specificShoe: Shoe)
}

class ShoeCollectionViewCell: UICollectionViewCell {
    
    static let cellReuseId = "shoeCell"
    weak var shoeDelegate: ShoeCollectionViewCellDelegate?
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var shoeModelLbl: UILabel!
    @IBOutlet weak var shoeImg: UIImageView!
    @IBOutlet weak var heartButtonLabel: UIButton!
    
    var specificShoe = Shoe(brand: "as", model: "hj", price: "bnm", imageName: "vb", isHearted: false, counter: 0)
    
    func updateViews(specificShoe: Shoe, delegate: ShoeCollectionViewCellDelegate) {
        self.specificShoe = specificShoe
        brandLbl.text = specificShoe.brand
        shoeModelLbl.text = specificShoe.model
        shoeImg.image = UIImage(named: specificShoe.imageName)
        let imageName = specificShoe.isHearted ? "heart.fill" : "heart"
        heartButtonLabel.setImage(UIImage(systemName: imageName), for: .normal)
        shoeDelegate = delegate
    }
    
    @IBAction func heartButton(_ sender: UIButton) {
        shoeDelegate?.specificShoeTranny(specificShoe: specificShoe)
    }
}
