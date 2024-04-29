//
//  BaseViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 30/04/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews() { }
    
    func setUpConstraints() { }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController (
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alert, animated: true)
    }
}
