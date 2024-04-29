//
//  MenuItemModel.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import Foundation

struct ProductCategory: Decodable {
    
    let products: [ProductGroup]
    
    struct ProductGroup: Decodable {
        let coffeeItems: [Product]?
        let dessertItems: [Product]?
        let breakfastItems: [Product]?
        let beverageItems: [Product]?
        let sandwichItems: [Product]?
        let additionalMenuItems: [Product]?
    }
    
    struct Product: Decodable {
        let image: String
        let name: String
        let description: String
        let price: Int
        
        enum CodingKeys: String, CodingKey {
            case image
            case name = "product_name"
            case description = "ProductType"
            case price = "Product_Price"
        }
    }
}
