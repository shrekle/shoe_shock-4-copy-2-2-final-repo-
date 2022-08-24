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
    @IBAction func stepperJenk(_ sender: UIStepper) {
        if let index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model}) {
        Api.instance.cartList[index].counter = Int(sender.value)
        shouldRemove(sender: sender.value)
        delegate?.nateHasJustinTimberlakeHairCurls()
         }
    }
}

private extension CartTableViewCell2 {
    
    func shouldRemove(sender: Double) {
        if sender == 0.0, let index = index {
//            Api.instance.cartList[index].isHearted.toggle()
            Api.instance.cartList.remove(at: index)
        }
    }
    
    func cellTotal()-> String {
        if let index = index {
            let result = String(Api.instance.cartList[index].counter * (Int(Api.instance.cartList[index].price) ?? 0))
            return  "$  \(result)"
        } else {
            return "0"
        }
    }
}

