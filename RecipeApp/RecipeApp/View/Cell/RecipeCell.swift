//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by Mac on 01/08/24.
//

import UIKit
import SDWebImage

protocol SendData: AnyObject {
    func SendDataToRecipeController(tag:Int)
}

class RecipeCell: UITableViewCell {

    @IBOutlet weak var dishBackgroundView: UIView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitle: UILabel!
    @IBOutlet weak var dishDiscription: UILabel!
    @IBOutlet weak var ingrediantCollectionView: UICollectionView!
    let viewMoreButton = UIButton(type: .system)
    weak var delegate : SendData?
    var mealArray : [Meal]? = []
    var ingredientsArray: [String] = []
    var CVindex = Int()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()

    }
    
    func setupUI(){
        ingrediantCollectionView.delegate = self
        ingrediantCollectionView.dataSource = self
        dishBackgroundView.layer.cornerRadius = 10
        dishImageView.layer.cornerRadius = 10
        self.dishBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        self.dishBackgroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.dishBackgroundView.layer.shadowOpacity = 1
        ingrediantCollectionView.register(UINib(nibName: "IngredientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IngredientCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //set value to lable , imageview
    func setData (object:Meal?,index:Int) {
        mealArray?.append(object!)
        self.dishTitle.text = object?.strMeal ?? ""
        dishImageView.sd_setImage(with: URL(string: object?.strMealThumb ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        dishDiscription.tag = index
        if let fullString = object?.strInstructions {
            let truncatedString = String(fullString.prefix(65))
            let fulltext = "\(truncatedString) View More"
            let attrString = String_extension.shared.createViewMoreString(fullText: fulltext)
            dishDiscription.attributedText = attrString
            dishDiscription.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
            dishDiscription.addGestureRecognizer(tapGesture)
        } else {
            dishDiscription.text = "No description available"
        }
        
        ingredientsArray = object?.ingredient ?? []
        loadCollectioview()
    }
    
    //load collection view
    func loadCollectioview(){
        DispatchQueue.main.async {
            self.ingrediantCollectionView.reloadData()
        }
    }

    //view more button click
    @objc func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        print("test")
        delegate?.SendDataToRecipeController(tag: dishDiscription.tag)
    }

}

extension RecipeCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
        cell.ingredientName.text = ingredientsArray[indexPath.row]
        cell.ingredientImageview.sd_setImage(with: URL(string: "https://www.themealdb.com/images/ingredients/" + "\(ingredientsArray[indexPath.row])" + ".png" ), placeholderImage: UIImage(named: "placeholder.png"))
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
     IndexPath) -> CGSize {
            let cellHeight: CGFloat = 50
            return CGSize(width: collectionView.frame.width / 4, height: cellHeight)
        }
    
    
}
