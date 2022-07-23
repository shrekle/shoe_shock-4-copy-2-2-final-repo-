//
//  API.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import Foundation

class Api {
    
    static let instance = Api()
    
    
    private let brands = [
        Brand(title: "Nike"),
        Brand(title: "Addidas"),
        Brand(title: "Xero Shoes"),
        Brand(title: "Vessi"),
        Brand(title: "Reebok"),
        Brand(title: "Merrell")
    ]
    
    private let nike = [
        Shoe(brand: "Nike", model: "Airforce One", price: "$50", imageName: "airforceone.png", isHearted: false, counter: 0),
        Shoe(brand: "Nike", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Nike", model:"AirHuarache One", price: "$100", imageName: "airhuaracheone.png", isHearted: false, counter: 0)
    ]
    
    private let addidas = [
        Shoe(brand: "Addidas", model: "Grand Court", price: "$60", imageName: "grandcourt.png", isHearted: false, counter: 0),
        Shoe(brand: "Addidas", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Addidas", model:"Airforce One", price: "$100", imageName: "airforceone.png", isHearted: false, counter: 0)
    ]
    
    private let xeroshoes = [
        Shoe(brand: "Xeroshoes", model: "Huarache", price: "$70", imageName: "airhuaracheone.png", isHearted: false, counter: 0),
        Shoe(brand: "Xeroshoes", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Xeroshoes", model:"Airforce One", price: "$100", imageName: "airforceone.png", isHearted: false, counter: 0)
    ]
    
    private let vessi = [
        Shoe(brand: "Vessi", model: "Weekender", price: "$100", imageName: "weekender.png", isHearted: false, counter: 0),
        Shoe(brand: "Vessi", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Vessi", model:"Airforce One", price: "$100", imageName: "airforceone.png", isHearted: false, counter: 0)
    ]
    
    private let reebok = [
        Shoe(brand: "Reebok", model: "Club C", price: "$50", imageName: "clubc.png", isHearted: false, counter: 0),
        Shoe(brand: "Reebok", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Reebok", model:"Airforce One", price: "$100", imageName: "airforceone.png", isHearted: false, counter: 0)
    ]
    
    private let merrell = [
        Shoe(brand: "Merrell", model: "Trail Glove", price: "$150", imageName: "streetglove.png", isHearted: false, counter: 0),
        Shoe(brand: "Merrell", model: "Airfoot one", price: "$50", imageName: "airfootone.png", isHearted: false, counter: 0),
        Shoe(brand: "Merrell", model:"Airforce One", price: "$100", imageName: "airforceone.png", isHearted: false, counter: 0)
    ]
    
    func getBrands()-> [Brand] {
        return brands
    }
    func getNike()-> [Shoe] {
        return nike
    }
    func getAddidas()-> [Shoe] {
        return addidas
    }
    func getXeroShoes()-> [Shoe] {
        return xeroshoes
    }
    func getVessi()-> [Shoe] {
        return vessi
    }
    func getReebok()-> [Shoe] {
        return reebok
    }
    func getMerrell()-> [Shoe] {
        return merrell
    }
    
    func getShoes(brand: Brand)-> [Shoe] {
        
        switch brand.title {
        case "Nike":
            return getNike()
        case "Addidas":
            return getAddidas()
        case "Xero Shoes":
            return getXeroShoes()
        case "Vessi":
            return getVessi()
        case "Reebok":
            return getReebok()
        case "Merrell":
            return getMerrell()
        default:
            return getNike()
        }
        
    }
    
    func getAllShoes()->[Shoe] {
        var allShoes = [Shoe]()
        for i in brands {
            let shoes = getShoes(brand: i)
            for i in shoes {
                allShoes.append(i)
            }
        }
        return allShoes
    }
    func brandChoosen (title: String)-> [Shoe] {
        switch title {
        case "Nike":
            return getNike()
        case "Addidas":
            return getAddidas()
        case "Xero Shoes":
            return getXeroShoes()
        case "Vessi":
            return getVessi()
        case "Reebok":
            return getReebok()
        case "Merrell":
            return getMerrell()
        default:
            return getNike()
        }
    }
}
