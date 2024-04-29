//
//  MenuViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let menuView: MenuView = {
        let view = MenuView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        menuView.delegate = self
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
        setupNavItem()
    }
    
    func setUpSubviews() {
        view.addSubview(menuView)
    }
    
    func setUpConstraints() {
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
    
    @objc func bellButtonTapped() { }
}

extension MenuViewController: MenuViewDelegate {
    func itemDetailsTapped(item: MenuItem) {
        let vc = ItemDetailsViewController()
        vc.selectedItemImage = item.logo
        vc.selectedItemName = item.name
        vc.selectedItemDescription = item.description
        vc.selectedItemPrice = item.price
        navigationController?.pushViewController(vc, animated: true)
    }
}
