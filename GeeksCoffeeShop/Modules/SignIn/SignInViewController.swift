//
//  ViewController.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInView: SignInView = {
        let view = SignInView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        signInView.delegate = self
        setUp()
    }
    
    func setUp() {
        setUpSubviews()
        setUpConstraints()
    }
    
    func setUpSubviews() {
        view.addSubview(signInView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                signInView.topAnchor.constraint(equalTo: view.topAnchor),
                signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
}

extension SignInViewController: SignInViewDelegate {
    
    func signInTapped() {
        let vc = AuthorizationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
