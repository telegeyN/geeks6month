//
//  SignInView.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func signInTapped()
}

class SignInView: BaseView {
    
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .init(hex: "#FF8B5B")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: SignInViewDelegate?
    
    override func setUp() {
        super.setUp()
        signInButton.addTarget(
            self,
            action: #selector(signInTapped),
            for: .touchUpInside
        )
    }
    
    override func setUpSubviews() {
        super.setUpSubviews()
        addSubview(logoImage)
        addSubview(signInButton)
        addSubview(signUpButton)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 234),
                logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                logoImage.heightAnchor.constraint(equalToConstant: 80),
                logoImage.widthAnchor.constraint(equalToConstant: 170),
                
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 98),
                signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                signInButton.heightAnchor.constraint(equalToConstant: 56),
                
                signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
                signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                signUpButton.heightAnchor.constraint(equalToConstant: 56)
            ]
        )
    }
    
    @objc
    private func signInTapped() {
        delegate?.signInTapped()
    }
}
