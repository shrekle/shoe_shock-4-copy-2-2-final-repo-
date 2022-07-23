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
    
    var brandIndexTracker = 0
    var brandTracker = Brand(title: "fgh")
    lazy var shoesArray = Api.instance.getShoes(brand: brandTracker)
    var brands = Api.instance.getBrands()
    
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
        
        if let cell = cell as? BrandsCollectionViewCell {
            print("BRANDS CELL", indexPath.row)
            cell.updateViews(brandIndexTracker: indexPath.row, brandTracker: brands[indexPath.row], delgate: self)
            return cell
        }
        else if let cell = cell as? ShoeCollectionViewCell {
            print("SHOECOLLECTIONCELL", indexPath.row)
            let specificcShoe = shoesArray[indexPath.row]
            print("SHOECOLLECTION", specificcShoe)
            cell.updateViews(indexPath: indexPath.row, brandIndexTracker: brandIndexTracker, specificShoe: specificcShoe, delegate: self)
            return cell
        }
        else if let cell =  cell as? SuggestionsCollectionViewCell {
            cell.updateViews(index: indexPath.row)
            return cell
        }
        return cell
    }
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    }
}

extension HomeVC: BrandsCollectionViewCellDelegate, ShoeCollectionViewCellDelegate {
    func brandTranny(brandIndex: Int, brandName: Brand) {
        print("FIRST", brandIndex, brandName)
        brandIndexTracker = brandIndex
        brandTracker = brandName
        print("BEFORE RELOAD", brandIndexTracker, brandTracker)
        shoeCollectionView.reloadData()
        print("LAST", brandIndexTracker, brandTracker)
    }
    func specificShoeX(specificShoe: Shoe) {
    
    }
}
private extension HomeVC {
    
    func getCellCount(CV: UICollectionView)-> Int {
        switch CV {
        case brandsCollectionView:
            return Api.instance.getBrands().count
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
            return "shoeCell"
        case suggestionsCollectionView:
            return "suggestionsCell"
        default:
            return "brandsCell"
        }
    }
}
