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
        }
    }
    
    var shoesArray = Api.instance.getShoes(brand: .nike)
    var brands = Api.instance.getBrands()
    var heartedShoes = [String: Bool]()
    var specificShoe: Shoe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoeCollectionView.reloadData()
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
        
        if let i = shoesArray.firstIndex(where: {$0.model == specificShoe.model && $0.brand == specificShoe.brand}) {
            shoesArray[i].isHearted.toggle()
            var shoe = shoesArray[i]
            heartedShoes[shoe.brand + shoe.model] = shoe.isHearted
            if shoe.isHearted == true {
                shoe.counter += 1
                Api.instance.cartList.append(shoe)
                shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
                
            } else if shoe.isHearted == false {
                if let newIndex = Api.instance.cartList.firstIndex(where: {$0.model == specificShoe.model && $0.brand == specificShoe.brand}) {
                    Api.instance.cartList[newIndex].counter = 0
                    Api.instance.cartList.remove(at: newIndex)
                    shoe.isHearted.toggle()
                    shoesArray[i].isHearted.toggle()
                    shoeCollectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
                }
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
