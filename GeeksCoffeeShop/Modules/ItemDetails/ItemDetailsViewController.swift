//
//  ItemDetailsViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import UIKit

class ItemDetailsViewController: BaseViewController {
    
    private let parser = JSONParser()
    
    var selectedItemImage: UIImage?
    var selectedItemName: String?
    var selectedItemDescription: String?
    var selectedItemPrice: Int?
    
    private let itemDetailsView: ItemDetailsView = {
        let view = ItemDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailsView.delegate = self
        setUp()
        getAdditionalProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func setUp() {
        super.setUp()
        itemDetailsView.setItemDetails(image: selectedItemImage, name: selectedItemName, description: selectedItemDescription, price: selectedItemPrice ?? 0)
    }
    
    override func setUpSubviews() {
        super.setUpSubviews()
        view.addSubview(itemDetailsView)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                itemDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                itemDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                itemDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                itemDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    private func getAdditionalProducts() {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json"),
              case let url = URL(fileURLWithPath: path),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        JSONParser().getItems(from: data) { (result: Result<ProductCategory, JSONParser.CustomError>) in
            switch result {
            case .success(let productCategory):
                itemDetailsView.fill(with: productCategory.products[5].additionalMenuItems ?? [])
            case .failure(let error):
                showAlert(with: "Ошибка", message: error.rawValue)
            }
        }

    }
}

extension ItemDetailsViewController: ItemDetailsViewDelegate {
    
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
