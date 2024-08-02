//
//  RecipeItemCell.swift
//  RecipeApp
//
//  Created by Mac on 02/08/24.
//

import UIKit

class RecipeItemCell: UITableViewCell {

    @IBOutlet weak var backgroundview: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemMesurment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI(){
        backgroundview.layer.cornerRadius = 20
        self.backgroundview.layer.shadowColor = UIColor.gray.cgColor
        self.backgroundview.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backgroundview.layer.shadowOpacity = 1
    }
    
}
