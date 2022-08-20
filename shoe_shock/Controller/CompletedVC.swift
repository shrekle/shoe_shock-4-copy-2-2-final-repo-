//
//  completedVC.swift
//  shoe_shock
//
//  Created by adrian garcia on 7/25/22.
//

import UIKit

class CompletedVC: UIViewController {

    @IBOutlet weak var imageLBL: UIImageView!
    @IBOutlet weak var completedLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLBL.image = UIImage(named: "biden")
        completedLBL.text = "LET'S GO BRANDON...DARK BRANDON"
    }
    

}
