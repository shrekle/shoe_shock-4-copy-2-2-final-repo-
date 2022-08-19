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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Api.instance.cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "carttableviewcell", for: indexPath) as? CartTableViewCell2 {
            cell.updateViews(specificShoe: Api.instance.cartList[indexPath.row], index: indexPath.row, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension CartVC: CartTableViewCellDelegate {
    func nateHasJustinTimberlakeHairCurls() {
        updateLabel()
        table.reloadData()
        
    }
}

private extension CartVC {

    func updateLabel() {
        var total = 0
        for i in Api.instance.cartList {
            total += (i.counter * (Int(i.price)!))
            cartTotalLBL.text = "TOTAL:  $\(total)"
        }
    }
}

