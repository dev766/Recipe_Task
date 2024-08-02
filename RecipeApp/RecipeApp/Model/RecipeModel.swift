//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Mac on 01/08/24.
//

import Foundation
import UIKit

struct Meals: Codable {
    let meals: [Meal]
}
//
//struct Meal: Codable {
//    let idMeal: String
//    let strMeal: String
//    let strCategory: String
//    let strArea: String
//    let strInstructions: String
//    let strMealThumb: String
//}



struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String?
    let strSource: String?
    
    // Ingredients and measures for up to 20 items
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    

    //create array for ingredenet and mesuments
    var ingredient: [String] {
          var ingredientArray: [String] = []
          
          let mirror = Mirror(reflecting: self)
          
          for i in 1...20 {
              if let ingredient = mirror.descendant("strIngredient\(i)") as? String, !ingredient.isEmpty {
                ingredientArray.append(ingredient)
              }
          }
          
          return ingredientArray
      }
    
    var measures: [String] {
          var measuresArray: [String] = []
          
          let mirror = Mirror(reflecting: self)
          
          for i in 1...20 {
              if let measure = mirror.descendant("strMeasure\(i)") as? String, !measure.isEmpty {
                  measuresArray.append(measure)
              }
          }
          
          return measuresArray
      }

}
