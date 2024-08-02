//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Mac on 01/08/24.
//

import Foundation


protocol RecipeProtocol {
    func fetchMealData (completion: @escaping (Bool, [Meal]) -> ())

}

//api call to ferch data
class RecipeViewModel:RecipeProtocol {
    func fetchMealData(completion: @escaping (Bool, [Meal]) -> ()) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/1/randomselection.php") else {
            completion(false, [])
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, [])
                return
            }
            do {
                let mealResponse = try JSONDecoder().decode(Meals.self, from: data)
                let meals = mealResponse.meals
                completion(true, meals)
            } catch {
                completion(false, [])
                print("Error decoding data: \(error)")
            }
        }.resume()
    }}
