//
//  SuggestionsCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

class SuggestionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shoeModelLbl: UILabel!
    @IBOutlet weak var shoeImgLbl: UIImageView!

    var allShoes = Api.instance.getAllShoes()
    
    func updateViews(index: Int) {
        shoeModelLbl.text = allShoes[index].model
        shoeImgLbl.image = UIImage(named: allShoes[index].imageName)
    }
    
    
}
