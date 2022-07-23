//
//  ShoeCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

protocol ShoeCollectionViewCellDelegate: AnyObject {
    func specificShoeX(specificShoe: Shoe)
}

class ShoeCollectionViewCell: UICollectionViewCell {
    
    weak var shoeDelegate: ShoeCollectionViewCellDelegate?
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var shoeModelLbl: UILabel!
    @IBOutlet weak var shoeImg: UIImageView!
    @IBOutlet weak var heartButtonLabel: UIButton!
    
    var brandIndexTracker = 0
    var specificShoe = Shoe(brand: "as", model: "hj", price: "bnm", imageName: "vb", isHearted: false, counter: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews(indexPath: Int, brandIndexTracker: Int, specificShoe: Shoe, delegate: ShoeCollectionViewCellDelegate) {
        self.brandIndexTracker = brandIndexTracker
        self.specificShoe = specificShoe
        var imageName = specificShoe.isHearted ? "heart.fill" : "heart"
        brandLbl.text = specificShoe.brand
        shoeModelLbl.text = specificShoe.model
        shoeImg.image = UIImage(named: specificShoe.imageName)
        heartButtonLabel.setImage(UIImage(systemName: imageName), for: .normal)
        shoeDelegate = delegate
    }
    
//    i need to isolate the brand and model that in the cell that the heart was clicked
//    how do i tap into the specific Shoe to tap into the bool property?
//    separate funcs, one that scans the brand and shoe title, .map, and one that adds the brand and title to the array
//    with a toggle on add to the array and toggle of run the remove func that scans with .map
    
//    func addToCartArray() {
//        guard let specificShoe = specificShoe else {return}
//        if specificShoe.isHearted == true {
//            cartArray.append(specificShoe.model)
//
//        }
//    }
    func heartState(sender: UIButton) {
        shoeDelegate?.specificShoeX(specificShoe: specificShoe)
    }
//    func heartState(sender: UIButton) {
//        if isShoeHearted == false {
//            isShoeHearted = true
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            sender.titleLabel?.text = shoesForCell[shoeIndex].model
//        } else if isShoeHearted == true {
//            isShoeHearted = false
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
    @IBAction func heartButton(_ sender: UIButton) {
        heartState(sender: sender)
//        shoeDelegate?.getSpecificShoe(shoe: specificShoe)
    }
}
