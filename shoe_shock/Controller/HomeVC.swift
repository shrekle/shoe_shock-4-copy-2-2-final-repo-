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
            //this brandsCollectionView is literally the outlet var established above
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
            specificShoe.isHearted = heartedShoes[specificShoe.brand + specificShoe.model] ?? false
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
//                                               the first index where this closure statement is true, itll throw or return the int where the statement was true in
        if let i = shoesArray.firstIndex(where: {$0.model == specificShoe.model}) {
            shoesArray[i].isHearted.toggle()
            let shoe = shoesArray[i]
            heartedShoes[shoe.brand + shoe.model] = shoe.isHearted //the key is the brand and model combination and it chnges the value to what shoe.hearted is
            shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
            print(heartedShoes)
            if shoe.isHearted {
                // add to cart
            } else {
                // remove from cart
            }
        }
    }
}

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
