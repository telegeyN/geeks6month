//
//  MenuCategoryModel.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import Foundation

struct Category: Decodable {
    let categories: [CategoryModel]
}

struct CategoryModel: Decodable {
    let categoryName: String
}
