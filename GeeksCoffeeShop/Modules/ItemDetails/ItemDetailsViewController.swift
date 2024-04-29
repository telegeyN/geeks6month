//
//  ItemDetailsViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    var selectedItemImage: UIImage?
    var selectedItemName: String?
    var selectedItemDescription: String?
    var selectedItemPrice: String?
    
    private let itemDetailsView: ItemDetailsView = {
        let view = ItemDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailsView.delegate = self
        setUp()
        itemDetailsView.setItemDetails(image: selectedItemImage, name: selectedItemName, description: selectedItemDescription, price: selectedItemPrice)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setUp() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews() {
        view.addSubview(itemDetailsView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                itemDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                itemDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                itemDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                itemDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
}

extension ItemDetailsViewController: ItemDetailsViewDelegate {
    
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
