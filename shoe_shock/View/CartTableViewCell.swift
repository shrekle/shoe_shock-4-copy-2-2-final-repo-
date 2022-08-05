//
//  CartTableViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 7/26/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {

//    identifier?
    
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var imageLBL: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    
    var specificShoe = Shoe(brand: "hj", model: "", price: "", imageName: "", isHearted: false, counter: 0)
        
    func updateViews(specificShoe: Shoe) {
        self.specificShoe = specificShoe
        stepper.value = Double(specificShoe.counter)
        priceLBL.text = "$\(specificShoe.price)"
        quantityLBL.text = String(specificShoe.counter)
        imageLBL.image = UIImage(named: specificShoe.imageName)
    }
    
    lazy var index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model})
    
    @IBAction func stepperJenk(_ sender: UIStepper) {
        var index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model})
        Api.instance.cartList[index ?? 0].counter = Int(sender.value)
        quantityLBL.text = String(Api.instance.cartList[index ?? 0].counter)
    }
}

private extension CartTableViewCell {
    
}
//will have to use a delegate to pass in the whole model with the counter chnages and bool changes to the cartVC and do the math the for the cartTotalLBl so i can reload()
//maybe have all the math done here that pertain to the cell and then pass the final info
//IM making a copy of specific shoe in order to to put it in the stepperJenk...maybe pass that and replace it in the array like nate did
    

