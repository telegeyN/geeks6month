//
//  MenuViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

class MenuViewController: BaseViewController {
    
    private let menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let parser = JSONParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        menuView.delegate = self
        getCategories()
        getProducts()
    }
    
    override func setUp() {
        super.setUp()
        setupNavItem()
    }
    
    override func setUpSubviews() {
        super.setUpSubviews()
        view.addSubview(menuView)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    private func setupNavItem() {
        navigationItem.title = "Меню"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let bellBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(bellButtonTapped))
        bellBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = bellBarButtonItem
        navigationItem.hidesBackButton = true
    }
    
    private func getCategories() {
        parser.getItems(from: jsonData) { [weak self] (result: Result<Category, JSONParser.CustomError>) in
            guard let self else { return }
            switch result {
            case .success(let model):
                menuView.fill(with: model.categories)
            case.failure(let error):
                showAlert(with: "Ошибка", message: error.rawValue)
            }
        }
    }
    
    private func getProducts() {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json"),
              case let url = URL(fileURLWithPath: path),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        JSONParser().getItems(from: data) { (result: Result<ProductCategory, JSONParser.CustomError>) in
            switch result {
            case .success(let productCategory):
                menuView.fill(
                    with: productCategory.products[0].coffeeItems ?? [],
                    dessertItems: productCategory.products[1].dessertItems ?? [],
                    breakfastItems: productCategory.products[2].breakfastItems ?? [],
                    beverageItems: productCategory.products[3].beverageItems ?? [],
                    sandwichItems: productCategory.products[4].sandwichItems ?? []
                )
            case .failure(let error):
                showAlert(with: "Ошибка", message: error.rawValue)
            }
        }
    }
    
    @objc func bellButtonTapped() { }
}

extension MenuViewController: MenuViewDelegate {
    func itemDetailsTapped(item: ProductCategory.Product) {
        let vc = ItemDetailsViewController()
        vc.selectedItemImage = UIImage(named: item.image)
        vc.selectedItemName = item.name
        vc.selectedItemDescription = item.description
        vc.selectedItemPrice = item.price
        navigationController?.pushViewController(vc, animated: true)
    }
}
