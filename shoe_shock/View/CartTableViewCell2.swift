//
//  CartTableViewCell2.swift
//  shoe_shock
//
//  Created by adrian garcia on 8/5/22.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func nateHasJustinTimberlakeHairCurls()
}

class CartTableViewCell2: UITableViewCell {

//    identifier?
    
    weak var delegate: CartTableViewCellDelegate?
    
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var imageLBL: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    
    var specificShoe = Shoe(brand: "hj", model: "", price: "", imageName: "", isHearted: false, counter: 0)
    lazy var index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model})
    
    func updateViews(specificShoe: Shoe, index: Int, delegate: CartTableViewCellDelegate) {
        self.delegate = delegate
        self.specificShoe = specificShoe
        stepper.value = Double(Api.instance.cartList[index].counter)
        priceLBL.text = cellTotal()
        quantityLBL.text = String(Api.instance.cartList[index].counter)
        imageLBL.image = UIImage(named: Api.instance.cartList[index].imageName)
    }
//    its cofusing the index and assigning weird crap to a diff shoe because something moves or some crap
    @IBAction func stepperJenk(_ sender: UIStepper) {
        let index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model})
        Api.instance.cartList[index ?? 0].counter = Int(sender.value)
        shouldRemove(sender: sender.value)
        print(Api.instance.cartList)
        delegate?.nateHasJustinTimberlakeHairCurls()
    }
}

private extension CartTableViewCell2 {
    
    func shouldRemove(sender: Double) {
        if sender == 0.0 {
            Api.instance.cartList.remove(at: index ?? 0)
        }
    }
    
    func cellTotal()-> String {
        let result = String(Api.instance.cartList[index ?? 0].counter * (Int(Api.instance.cartList[index ?? 0].price) ?? 0))
        return  "$  \(result)"
    }
}
//will have to use a delegate to pass in the whole model with the counter chnages and bool changes to the cartVC and do the math the for the cartTotalLBl so i can reload()
//maybe have all the math done here that pertain to the cell and then pass the final info
//IM making a copy of specific shoe in order to to put it in the stepperJenk...maybe pass that and replace it in the array like nate did
    

