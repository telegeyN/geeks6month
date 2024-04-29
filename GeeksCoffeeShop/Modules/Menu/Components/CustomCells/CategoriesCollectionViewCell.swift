//
//  CategoriesCollectionViewCell.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "categoriesCell"
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .clear
        setUp()
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews() {
        contentView.addSubview(categoryNameLabel)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                categoryNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                categoryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }
    
    func fill(with item: CategoryModel) {
        categoryNameLabel.text = item.categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
