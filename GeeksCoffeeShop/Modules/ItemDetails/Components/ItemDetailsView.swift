//
//  ItemDetailsView.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 29/04/24.
//

import UIKit

protocol ItemDetailsViewDelegate: AnyObject {
    func backButtonTapped()
}

class ItemDetailsView: BaseView {
    
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let whiteView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
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
    
    private let additionalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.text = "Приятное дополнение"
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let menuItemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 90)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private let menuItems = [
        MenuItem(logo: UIImage(named: "redvelvet"), name: "Красный бархат", description: "", price: "329 c"),
        MenuItem(logo: UIImage(named: "latte"), name: "Латте", description: "Кофейный напиток", price: "209 c"),
        MenuItem(logo: UIImage(named: "matcha"), name: "Матча капучино", description: "Кофейный напиток", price: "339 c")
    ]
    
    private var counter = CounterModel(number: 0)
    
    weak var delegate: ItemDetailsViewDelegate?
    
    override func setUp() {
        super.setUp()
        backgroundColor = .white
        menuItemsCollectionView.dataSource = self
        menuItemsCollectionView.register(
            AdditionalMenuCollectionViewCell.self,
            forCellWithReuseIdentifier: AdditionalMenuCollectionViewCell.reuseId
        )
    }
    
    override func setUpSubviews() {
        super.setUpSubviews()
        addSubview(itemImage)
        addSubview(backButton)
        addSubview(whiteView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(descriptionLabel)
        whiteView.addSubview(priceLabel)
        whiteView.addSubview(counterStackView)
        counterStackView.addArrangedSubview(decreaseButton)
        counterStackView.addArrangedSubview(quantityLabel)
        counterStackView.addArrangedSubview(increaseButton)
        whiteView.addSubview(additionalLabel)
        whiteView.addSubview(menuItemsCollectionView)
        decreaseButton.addTarget(self, action: #selector(decreaseTap), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(increaseTap), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                itemImage.topAnchor.constraint(equalTo: topAnchor),
                itemImage.leadingAnchor.constraint(equalTo: leadingAnchor),
                itemImage.trailingAnchor.constraint(equalTo: trailingAnchor),
                itemImage.heightAnchor.constraint(equalToConstant: 300),
                
                backButton.topAnchor.constraint(equalTo: itemImage.topAnchor, constant: 25),
                backButton.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor, constant: 16),
                backButton.heightAnchor.constraint(equalToConstant: 26),
                backButton.widthAnchor.constraint(equalToConstant: 26),
                
                whiteView.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: -18),
                whiteView.leadingAnchor.constraint(equalTo: leadingAnchor),
                whiteView.trailingAnchor.constraint(equalTo: trailingAnchor),
                whiteView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                nameLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 15),
                nameLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,constant: 16),
                nameLabel.widthAnchor.constraint(equalToConstant: 200),
                
                priceLabel.centerYAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 15),
                priceLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor,constant: -16),
                
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 9),
                descriptionLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor,constant: -16),
                
                counterStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
                counterStackView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -16),
                counterStackView.widthAnchor.constraint(equalToConstant: 99),
                counterStackView.heightAnchor.constraint(equalToConstant: 28),
                
                additionalLabel.topAnchor.constraint(equalTo: counterStackView.bottomAnchor, constant: 15),
                additionalLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,constant: 16),
                
                menuItemsCollectionView.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 8),
                menuItemsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                menuItemsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                menuItemsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
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
    
    @objc
    private func backTapped() {
        delegate?.backButtonTapped()
    }
    
    func setItemDetails(image: UIImage?, name: String?, description: String?, price: String?) {
        itemImage.image = image
        nameLabel.text = name
        descriptionLabel.text = description
        priceLabel.text = price
    }
}

extension ItemDetailsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdditionalMenuCollectionViewCell.reuseId, for: indexPath) as! AdditionalMenuCollectionViewCell
        cell.fill(with: menuItems[indexPath.row])
        return cell
    }
}

