//
//  JSONParser.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import Foundation

struct JSONParser {
    
    enum CustomError: String, Error {
        case incorrectFormat = "Неправильный формат"
    }
    
    private let decoder = JSONDecoder()
    
    private let encoder = JSONEncoder()
    
    func getItems<Model: Decodable>(
        from data: Data,
        completion: (Result<Model, CustomError>) -> Void
    ) {
        do {
            let model = try JSONDecoder().decode(Model.self, from: data)
            completion(.success(model))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.incorrectFormat))
        }
    }
}
