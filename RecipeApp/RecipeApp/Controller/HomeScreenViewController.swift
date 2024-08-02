//
//  HomeScreenViewController.swift
//  RecipeApp
//
//  Created by Mac on 01/08/24.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var recipeTableview: UITableView!
    
    var mealArray : [Meal]? = []
    
    var recipeModelObject:RecipeViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeModelObject = RecipeViewModel()
        setupUI()
        fetchData()
    }
    
    func setupUI(){
        recipeTableview.dataSource = self
        recipeTableview.delegate = self
        recipeTableview.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    //Api call
    func fetchData(){
        recipeModelObject?.fetchMealData(completion: { (isdata, mealData) in
            if isdata {
                self.mealArray = mealData
                DispatchQueue.main.async {
                    self.recipeTableview.reloadData()
                }
            }
        })
    }

}

extension HomeScreenViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as! RecipeCell
        cell.setData(object: mealArray?[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}

extension HomeScreenViewController:SendData{
    //send data to next view controller
    func SendDataToRecipeController(tag: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        destinationVC.mealArray = mealArray
        destinationVC.index = tag
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}
