//
//  CartVC.swift
//  shoe_shock
//
//  Created by adrian garcia on 7/25/22.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var table: UITableView! {
        didSet {
            table.delegate = self
            table.dataSource = self
        }
    }
        
    @IBOutlet weak var cartTotalLBL: UILabel!

    var specificShoeArray = Api.instance.cartList
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateLabel()

    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        specificShoeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "carttableviewcell", for: indexPath) as? CartTableViewCell {
//            let specificShoe = specificShoeArray[indexPath.row]
            cell.updateViews(specificShoe: specificShoeArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

private extension CartVC {
    func updateLabel() {
        var total = prices(cartList: specificShoeArray)
        cartTotalLBL.text = "TOTAL:  $\(total)"
    }
    func prices(cartList: [Shoe])->String {
        var total = 0
        for i in cartList {
            total += i.counter * (Int(i.price)!)
            print(total)
        }
        return String(total)
    }
}
