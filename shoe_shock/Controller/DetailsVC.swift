//
//  detailsVCViewController.swift
//  shoe_shock
//
//  Created by adrian garcia on 7/25/22.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var brandLBl: UILabel!
    @IBOutlet weak var modelLBl: UILabel!
    @IBOutlet weak var priceLBl: UILabel!
    @IBOutlet weak var descriptionLBl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var specificShoe = Shoe(brand: "gh", model: "gh", price: "ghj", imageName: "ghj", isHearted: false, counter: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func addToCart() {
        specificShoe.isHearted.toggle()
        specificShoe.counter = 1
        Api.instance.cartList.append(specificShoe)
//        print(Api.instance.cartList)
//        var index = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model})
//        Api.instance.cartList[index ?? 0].isHearted.toggle()
//        Api.instance.cartList[index ?? 0].counter += 1
//        print(specificShoe,"||", Api.instance.cartList[index!])
    }
}

private extension DetailsVC {
    //i passed the specificShoe that is loaded with the correct data from homeVC through the prepareForSegue in the didSelectItemAt
    func updateViews() {
        brandLBl.text = specificShoe.brand
        modelLBl.text = specificShoe.model
        priceLBl.text = "$\(specificShoe.price)"
//        i put the description here for pure lazyess, since all the shoes will have the same description, beaner didnt want to bother to put it in the API
        descriptionLBl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        imageView.image = UIImage(named: specificShoe.imageName)
    }
}
