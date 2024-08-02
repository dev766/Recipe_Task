//
//  String_extension.swift
//  RecipeApp
//
//  Created by Mac on 01/08/24.
//

import Foundation
import UIKit

class String_extension {
    
    static let shared = String_extension()
    
    //function to create viewmore lable text
    func createViewMoreString(fullText: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        let viewMoreText = "View More"
        let viewMoreTextColor = UIColor.blue
        
        if let viewMoreRange = fullText.range(of: viewMoreText) {
            let nsViewMoreRange = NSRange(viewMoreRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: viewMoreTextColor, range: nsViewMoreRange)
        }
        return attributedString
    }

    
}

