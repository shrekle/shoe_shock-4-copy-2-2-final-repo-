//
//  Product.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import Foundation

struct Shoe {
    
    private(set) var brand: String
    private(set) var model: String
    private(set) var price: String
    private(set) var imageName: String
    var isHearted: Bool
    var counter: Int
    
    init(brand: String, model: String, price: String, imageName: String, isHearted: Bool, counter: Int) {
        self.brand = brand
        self.model = model
        self.price = price
        self.imageName = imageName
        self.isHearted = isHearted
        self.counter = counter
    }
    
    
}
