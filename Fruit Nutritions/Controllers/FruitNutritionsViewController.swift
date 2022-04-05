//
//  ViewController.swift
//  Gas Prices
//
//  Created by Aries Lam on 4/4/22.
//

import UIKit

class FruitNutritionsViewController: UIViewController {

    @IBOutlet weak var fruitName: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var carbohydrates: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var sugar: UILabel!
    
    var fruitNutritionManager = FruitNutritionsManager()
    
    override func viewDidLoad() {
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        super.viewDidLoad()
        searchBar.delegate = self
        fruitNutritionManager.delegate = self
    }

    
}

//MARK: - UISearchBarDelegate
extension FruitNutritionsViewController: UISearchBarDelegate{
    
    @IBAction func searchButtonPressed(_ sender: UIButton){
        searchBarTextDidEndEditing(searchBar)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let fruit = searchBar.text{
            let fruitWithoutSpace = fruit.replacingOccurrences(of: " ", with: "+")
            fruitNutritionManager.fetchFruit(fruitWithoutSpace)
        }
        
        searchBar.text = ""
    }
    
    //using return key to enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarTextDidEndEditing(searchBar)
  
    }
    
}

//MARK: - FruitManagerDelegate
extension FruitNutritionsViewController: FruitManagerDelegate{
    func didGetFruit(fruit: FruitNutritions) {
        DispatchQueue.main.async {
            self.fruitName.text = fruit.fruitName
            self.carbohydrates.text = String(fruit.carbohydrates)
            self.protein.text = String(fruit.protein)
            self.calories.text = String(fruit.calories)
            self.sugar.text = String(fruit.sugar)
        }
        
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

