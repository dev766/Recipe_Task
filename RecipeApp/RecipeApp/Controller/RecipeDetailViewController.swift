//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Mac on 02/08/24.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var backgroundimage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var itemListTableview: UITableView!
    @IBOutlet weak var youtubeBTNOutlet: UIButton!
    @IBOutlet weak var backgrondview: UIView!
    @IBOutlet weak var backBTNOutlet: UIButton!
    @IBOutlet weak var HeartBTNBTNOutlet: UIButton!
    let scrollView = UIScrollView()
    @IBOutlet weak var detailsLableBackView: UIView!
    

    
    var itemList : [String] = []
    var mesurmentArray : [String] = []
    var mealArray : [Meal]? = []
    var index = Int()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addscrollView()
    }
    
    func setupUI(){
        let meal = mealArray?[index]
        itemListTableview.dataSource = self
        itemListTableview.delegate = self
        itemListTableview.register(UINib(nibName: "RecipeItemCell", bundle: nil), forCellReuseIdentifier: "RecipeItemCell")
        titleLBL.text = meal?.strMeal
        time.text = "15 Min"
        backgroundimage.sd_setImage(with: URL(string:  meal?.strMealThumb ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        youtubeBTNOutlet.layer.cornerRadius = 10
        backgrondview.layer.cornerRadius = 30
        backBTNOutlet.layer.cornerRadius = 10
        HeartBTNBTNOutlet.layer.cornerRadius = 10
        mesurmentArray = mealArray?[index].measures ?? []
        itemList = mealArray?[index].ingredient ?? []
        itemCount.text = "\( itemList.count)"
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    // add scroll view to lable so we can see the full discription of recipe
    func addscrollView(){
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = mealArray?[index].strInstructions
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(label)
        
        detailsLableBackView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: detailsLableBackView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: detailsLableBackView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: detailsLableBackView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: detailsLableBackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            label.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.contentSize = label.bounds.size
    }
    
    
    @IBAction func youtubeButtonClick(_ sender: UIButton) {
        let url = mealArray?[index].strYoutube
        guard let linkURL = URL(string: url ?? "https://google.com") else {
            print("Invalid URL")
            return
        }
        
        if UIApplication.shared.canOpenURL(linkURL) {
            UIApplication.shared.open(linkURL, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL")
        }

    }
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension RecipeDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemListTableview.dequeueReusableCell(withIdentifier: "RecipeItemCell") as! RecipeItemCell
        cell.itemName.text = itemList[indexPath.row]
        cell.itemMesurment.text = mesurmentArray[indexPath.row]
        cell.itemImageView.sd_setImage(with: URL(string: "https://www.themealdb.com/images/ingredients/" + "\(itemList[indexPath.row])" + ".png" ), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    
}
