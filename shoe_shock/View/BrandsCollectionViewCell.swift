//
//  BrandsCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
 
    static let cellReuseID = "brandscell"
    
    @IBOutlet weak var brandLBL: UILabel!
    
    func updateViews(title: String) {
        brandLBL.text = title
    }
    
}
 
