//
//  MenuView.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func itemDetailsTapped(item: MenuItem)
}

class MenuView: BaseView {
    
    private let menuCategotiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 32)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let menuNameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 24)
        view.textColor = .init(UIColor(hex: "#283952"))
        view.text = "Кофе"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private let categories = [
        Category(categoryName: "Кофе"),
        Category(categoryName: "Десерты"),
        Category(categoryName: "Завтраки"),
        Category(categoryName: "Напитки"),
        Category(categoryName: "Сэндвичи")
    ]
    
    private let coffeeItems = [
        MenuItem(logo: UIImage(named: "capuccino"), name: "Капучино", description: "Кофейный напиток", price: "199 c"),
        MenuItem(logo: UIImage(named: "latte"), name: "Латте", description: "Кофейный напиток", price: "209 c"),
        MenuItem(logo: UIImage(named: "americano"), name: "Американо", description: "Кофейный напиток", price: "159 c"),
        MenuItem(logo: UIImage(named: "raf"), name: "Раф", description: "Кофейный напиток", price: "239"),
        MenuItem(logo: UIImage(named: "espresso"), name: "Эспрессо", description: "Кофейный напиток", price: "149 с"),
        MenuItem(logo: UIImage(named: "mokko"), name: "Мокко", description: "Кофейный напиток", price: "199 c"),
        MenuItem(logo: UIImage(named: "matcha"), name: "Матча капучино", description: "Кофейный напиток", price: "339 c")
    ]
    
    private let dessertItems = [
        MenuItem(logo: UIImage(named: "redvelvet"), name: "Красный бархат", description: "", price: "329 c"),
        MenuItem(logo: UIImage(named: "cheesecake"), name: "Чизкейк Нью-Йорк", description: "", price: "319 c"),
        MenuItem(logo: UIImage(named: "truffle"), name: "Трюффельный", description: "", price: "339 c")
    ]
    
    private let breakfastItems = [
        MenuItem(logo: UIImage(named: "kasha"), name: "Каша овсяная", description: "С ягодами", price: "209 c"),
        MenuItem(logo: UIImage(named: "blinchiki"), name: "Блинчики", description: "С ягодами", price: "219 c"),
        MenuItem(logo: UIImage(named: "syrniki"), name: "Сырники", description: "С джемом", price: "349 c")
    ]
    
    private let beverageItems = [
        MenuItem(logo: UIImage(named: "smoothie"), name: "Смузи", description: "Ягодный / Клубничный", price: "299 c"),
        MenuItem(logo: UIImage(named: "milkshake"), name: "Милкшейк", description: "Орео / Банановый", price: "329 c"),
        MenuItem(logo: UIImage(named: "juice"), name: "Свежевыжатый сок", description: "Апельсиновый / Яблочный", price: "259 c")
    ]
    
    private let sandwichItems = [
        MenuItem(logo: UIImage(named: "chicken"), name: "Сэндвич", description: "с Курицей", price: "290 с"),
        MenuItem(logo: UIImage(named: "semga"), name: "Сэндвич", description: "с Семгой", price: "410 с")
    ]
    
    private var selectedCategoryIndex: Int = 0
    
    weak var delegate: MenuViewDelegate?
    
    override func setUp() {
        super.setUp()
        
        menuCategotiesCollectionView.dataSource = self
        menuCategotiesCollectionView.register(
            CategoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseId
        )
        menuCategotiesCollectionView.delegate = self
        
        menuItemsCollectionView.dataSource = self
        menuItemsCollectionView.register(
            MenuItemsCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuItemsCollectionViewCell.reuseId
        )
        menuItemsCollectionView.delegate = self
    }
    
    override func setUpSubviews() {
        super.setUpSubviews()
        addSubview(menuCategotiesCollectionView)
        addSubview(menuNameLabel)
        addSubview(menuItemsCollectionView)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                menuCategotiesCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
                menuCategotiesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                menuCategotiesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                menuCategotiesCollectionView.heightAnchor.constraint(equalToConstant: 32),
                
                menuNameLabel.topAnchor.constraint(equalTo: menuCategotiesCollectionView.bottomAnchor, constant: 24),
                menuNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                menuNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                menuNameLabel.heightAnchor.constraint(equalToConstant: 24),
                
                menuItemsCollectionView.topAnchor.constraint(equalTo: menuNameLabel.bottomAnchor, constant: 18),
                menuItemsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                menuItemsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                menuItemsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}

extension MenuView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCategotiesCollectionView {
            return categories.count
        } else {
            switch selectedCategoryIndex {
            case 1:
                return dessertItems.count
            case 2:
                return breakfastItems.count
            case 3:
                return beverageItems.count
            case 4:
                return sandwichItems.count
            default:
                return coffeeItems.count
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuCategotiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseId, for: indexPath) as! CategoriesCollectionViewCell
            cell.fill(with: categories[indexPath.row])
            let isSelectedCategory = indexPath.row == selectedCategoryIndex
            
            cell.backgroundColor = isSelectedCategory ? .init(hex: "#283952") : .clear
            cell.layer.cornerRadius = 12
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemsCollectionViewCell.reuseId, for: indexPath) as! MenuItemsCollectionViewCell
            
            switch selectedCategoryIndex {
            case 1:
                cell.fill(with: dessertItems[indexPath.row])
            case 2:
                cell.fill(with: breakfastItems[indexPath.row])
            case 3:
                cell.fill(with: beverageItems[indexPath.row])
            case 4:
                cell.fill(with: sandwichItems[indexPath.row])
            default:
                cell.fill(with: coffeeItems[indexPath.row])
            }
            return cell
        }
    }
}

extension MenuView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCategotiesCollectionView {
            selectedCategoryIndex = indexPath.row
            menuCategotiesCollectionView.reloadData()
            menuItemsCollectionView.reloadData()
            switch selectedCategoryIndex {
            case 1:
                menuNameLabel.text = "Десерты"
            case 2:
                menuNameLabel.text = "Завтраки"
            case 3:
                menuNameLabel.text = "Напитки"
            case 4:
                menuNameLabel.text = "Сэндвичи"
            default:
                menuNameLabel.text = "Кофе"
            }
        } else if collectionView == menuItemsCollectionView {
            switch selectedCategoryIndex {
            case 1:
                delegate?.itemDetailsTapped(item: dessertItems[indexPath.row])
            case 2:
                delegate?.itemDetailsTapped(item: breakfastItems[indexPath.row])
            case 3:
                delegate?.itemDetailsTapped(item: beverageItems[indexPath.row])
            case 4:
                delegate?.itemDetailsTapped(item: sandwichItems[indexPath.row])
            default:
                delegate?.itemDetailsTapped(item: coffeeItems[indexPath.row])
            }
        }
    }
}
