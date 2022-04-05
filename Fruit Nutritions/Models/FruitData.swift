//
//  FruitData.swift
//  Gas Prices
//
//  Created by Aries Lam on 4/5/22.
//

import Foundation

struct FruitData: Codable{
    let name: String
    let nutritions: Nutritions
}
struct Nutritions: Codable{
    let carbohydrates: Double
    let protein: Double
    let calories: Double
    let sugar: Double
}
