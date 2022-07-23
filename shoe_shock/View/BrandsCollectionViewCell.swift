//
//  BrandsCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

protocol BrandsCollectionViewCellDelegate: AnyObject {
    func brandTranny(brandIndex: Int, brandName: Brand)
}

class BrandsCollectionViewCell: UICollectionViewCell {
 
    static let cellReuseID = "brandscell"
    weak var brandsDelegate: BrandsCollectionViewCellDelegate?

    var brandIndexTracker = 0
    var brandTracker = Brand(title: "fg")
    
    @IBOutlet weak var brandButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateViews(brandIndexTracker: Int, brandTracker: Brand, delgate: BrandsCollectionViewCellDelegate) {
        self.brandIndexTracker = brandIndexTracker
        self.brandTracker = brandTracker
        brandButton.setTitle(Api.instance.getBrands()[brandIndexTracker].title, for: .normal)
        brandsDelegate = delgate
    }
    
    @IBAction func BrandbuttonPressed(_ sender: UIButton) {
        brandsDelegate?.brandTranny(brandIndex: brandIndexTracker, brandName: brandTracker)
    }
    
}
 
