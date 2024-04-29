//
//  MenuItemsCollectionViewCell.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import UIKit

class MenuItemsCollectionViewCell: UICollectionViewCell {
    
    static var reuseId = "menuItemsCell"
    
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(hex: "#FF8B5B")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let counterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .init(hex: "#EDEDED")
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .init(hex: "#FF8B5B")
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var counter = CounterModel(number: 0)
    
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
        contentView.addSubview(itemImage)
        
        contentView.addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(nameLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(priceLabel)
        
        contentView.addSubview(counterStackView)
        counterStackView.addArrangedSubview(decreaseButton)
        decreaseButton.addTarget(self, action: #selector(decreaseTap), for: .touchUpInside)
        counterStackView.addArrangedSubview(quantityLabel)
        counterStackView.addArrangedSubview(increaseButton)
        increaseButton.addTarget(self, action: #selector(increaseTap), for: .touchUpInside)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                itemImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                itemImage.heightAnchor.constraint(equalToConstant: 90),
                itemImage.widthAnchor.constraint(equalToConstant: 90),
                
                descriptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                descriptionStackView.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 16),
                descriptionStackView.widthAnchor.constraint(equalToConstant: 120),
                descriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                counterStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                counterStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
                counterStackView.widthAnchor.constraint(equalToConstant: 99),
                counterStackView.heightAnchor.constraint(equalToConstant: 28)
            ]
        )
    }
    
    func fill(with item: MenuItem) {
        itemImage.image = item.logo
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = item.price
    }
    
    @objc
    private func decreaseTap() {
        counter.number -= 1
        quantityLabel.text = "\(counter.number)"
    }
    
    @objc
    private func increaseTap() {
        counter.number += 1
        quantityLabel.text = "\(counter.number)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
