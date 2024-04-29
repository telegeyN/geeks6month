//
//  AuthorizationViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private let authorizationView: AuthorizationView = {
        let view = AuthorizationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        authorizationView.delegate = self
        setUp()
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
        setupNavItem()
    }
    
    func setUpSubviews() {
        view.addSubview(authorizationView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                authorizationView.topAnchor.constraint(equalTo: view.topAnchor),
                authorizationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                authorizationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                authorizationView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
    
    private func setupNavItem() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension AuthorizationViewController: AuthorizationViewDelegate {
    
    func signInTapped() {
        let vc = MenuViewController()
        navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.setValue(true, forKey: "isAuthorizationCompleted")
    }
}
