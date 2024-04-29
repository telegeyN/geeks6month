//
//  ProductsJson.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import Foundation

let json = """
    {
         "categories": [
             {
                 "categoryName": "Кофе"
             },
             {
                 "categoryName": "Десерты"
             },
             {
                 "categoryName": "Завтраки"
             },
             {
                 "categoryName": "Напитки"
             },
             {
                 "categoryName": "Сэндвичи"
             }
         ]
    }
"""

let jsonData = json.data(using: .utf8)!
