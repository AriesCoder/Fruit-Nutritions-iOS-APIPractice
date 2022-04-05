//
//  FruitNutritionsManager.swift
//  Gas Prices
//
//  Created by Aries Lam on 4/5/22.
//

import Foundation

protocol FruitManagerDelegate{
    func didGetFruit(fruit: FruitNutritions)
    func didFailWithError(_ error: Error)
}

struct FruitNutritionsManager{
    let fruitURL = "https://www.fruityvice.com/api/fruit"
    
    var delegate: FruitManagerDelegate?
    
    func fetchFruit(_ fruitName: String){
        let urlString = "\(fruitURL)/\(fruitName)"
        print("urlString", urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        if error != nil{
            delegate?.didFailWithError(error!)
        }
        if let safeData = data{
            if let fruit = parseJSON(fruitData: safeData){
                delegate?.didGetFruit(fruit: fruit)
            }
        }
    }
                
    func parseJSON(fruitData: Data)-> FruitNutritions?{
        do{
            let decodedData = try JSONDecoder().decode(FruitData.self, from: fruitData)
            let name = decodedData.name
            let carbohydrates = decodedData.nutritions.carbohydrates
            let protein = decodedData.nutritions.protein
            let calories = decodedData.nutritions.calories
            let sugar = decodedData.nutritions.sugar
            
            let fruit = FruitNutritions(fruitName: name, carbohydrates: carbohydrates, protein: protein, calories: calories, sugar: sugar)
            return fruit
            }catch{
                delegate?.didFailWithError(error)
            }
            return nil
        }
}


