//
//  HomeVC2ViewController.swift
//  shoe_shock
//
//  Created by adrian garcia on 6/14/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var brandsCollectionView: UICollectionView! {
        didSet {
            brandsCollectionView.delegate = self
            brandsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var shoeCollectionView: UICollectionView! {
        didSet {
            shoeCollectionView.delegate = self
            shoeCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var suggestionsCollectionView: UICollectionView! {
        didSet {
            suggestionsCollectionView.delegate = self
            suggestionsCollectionView.dataSource = self
        }
    }
    
    var selectedBrand: BrandOption = .nike {
        didSet {
            shoesArray = Api.instance.getShoes(brand: selectedBrand)
            shoeCollectionView.reloadData()
        }
    }
    
    var shoesArray = Api.instance.getShoes(brand: .nike)
    var brands = Api.instance.getBrands()
    var heartedShoes = [String: Bool]()
    var specificShoe: Shoe!
    //    lazy var shoeHome = Shoe(brand: "", model: "", price: "", imageName: "", isHearted: false, counter: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
} 

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getCellCount(CV: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = getId(for: collectionView)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? BrandsCollectionViewCell, let brand = BrandOption(rawValue: indexPath.row) {
            cell.updateViews(title: brand.title)
            return cell
        }
        else if let cell = cell as? ShoeCollectionViewCell {
            var specificShoe = shoesArray[indexPath.row]
            //            specificShoe.isHearted = shoeHome.isHearted
            specificShoe.isHearted = heartedShoes[specificShoe.brand + specificShoe.model] ?? false
            print("LIST SHOES IN CELL", Api.instance.cartList)
            cell.updateViews(specificShoe: specificShoe, delegate: self)
            return cell
        }
        else if let cell =  cell as? SuggestionsCollectionViewCell {
            cell.updateViews(index: indexPath.row)
            return cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case brandsCollectionView:
            //               enums rawValues are optionals?
            if let brand = BrandOption(rawValue: indexPath.row) {
                selectedBrand = brand
            }
        case shoeCollectionView:
            specificShoe = shoesArray[indexPath.row]
            performSegue(withIdentifier: "todetailsVC", sender: self)
            break //WHY IS THIS BREAK HERE???
        case suggestionsCollectionView:
            specificShoe = shoesArray[indexPath.row]
            performSegue(withIdentifier: "todetailsVC", sender: self)
        default: break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetailsVC" {
            let destinationVC = segue.destination as? DetailsVC
            destinationVC?.specificShoe = specificShoe
        }
        if segue.identifier == "todetailsVC" {
            let destinationVC = segue.destination as? DetailsVC
            destinationVC?.specificShoe = specificShoe
        }
    }
}

extension HomeVC: ShoeCollectionViewCellDelegate {
    func specificShoeTranny(specificShoe: Shoe) {
        
        guard let i = shoesArray.firstIndex(where: {$0.model == specificShoe.model && $0.brand == specificShoe.brand}) else {return}
        var shoe = shoesArray[i]
        shoe.counter += 1
        shoe.isHearted.toggle()
        shoesArray[i].isHearted = shoe.isHearted
        heartedShoes[shoe.brand + shoe.model] = shoe.isHearted 
//        shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])

//        if shoe.isHearted == true {
//            shoe.counter += 1
            Api.instance.cartList.append(shoe)
            print("TRUE LIST SHOES IN DELEGATE", Api.instance.cartList)
            shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
//        } else
            if shoe.isHearted == false { //use specificShoe!!!!!!!
            if let newIndex = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model && $0.brand == specificShoe.brand}) {
                Api.instance.cartList.remove(at: newIndex)
                print("FALSE LIST SHOES IN DELEGATE", Api.instance.cartList)
                shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
            } 
        }
    }
}

//if let i = shoesArray.firstIndex(where: {$0.model == specificShoe.model}) {
//    shoesArray[i].isHearted.toggle()
//    let shoe = shoesArray[i]
//    heartedShoes[shoe.brand + shoe.model] = shoe.isHearted //the key is the brand plus model combination and it changes the value to what shoe.hearted is
//    shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
//    print(heartedShoes)
//    if shoe.isHearted {
//        Api.instance.cartList.append(shoe)
//        if let newIndex = Api.instance.cartList.firstIndex(where: {$0 == shoe}) {
//            Api.instance.cartList[newIndex].counter += 1
//            shoesArray[i].isHearted.toggle()
//        }
//    } else {
//        // remove from cart
//    }
//}
//}
//}
private extension HomeVC {
    
    func getCellCount(CV: UICollectionView)-> Int {
        
        switch CV {
        case brandsCollectionView:
            return BrandOption.allCases.count
        case shoeCollectionView:
            return Api.instance.getNike().count
        case suggestionsCollectionView:
            return Api.instance.getAllShoes().count
        default:
            return 0
        }
    }
    func getId(for collectionView: UICollectionView)-> String {
        
        switch collectionView {
        case brandsCollectionView:
            return BrandsCollectionViewCell.cellReuseID
        case shoeCollectionView:
            return ShoeCollectionViewCell.cellReuseId
        case suggestionsCollectionView:
            return SuggestionsCollectionViewCell.cellReuseId
        default:
            return BrandsCollectionViewCell.cellReuseID
        }
    }
}
