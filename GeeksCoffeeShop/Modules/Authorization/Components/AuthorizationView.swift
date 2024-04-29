//
//  AuthorizationView.swift
//  GeeksCoffeeShop
//
//  Created by Telegey Nurbekova on 26/04/24.
//

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func signInTapped()
}

class AuthorizationView: BaseView {
    
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signInLabel: UILabel = {
        let view = UILabel()
        view.text = "Вход"
        view.font = .boldSystemFont(ofSize: 34)
        view.textColor = .init(UIColor(hex: "#283952"))
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let phoneNumberTextField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 16)
        field.backgroundColor = .init(hex: "#EDEDED")
        field.placeholder = "  555 555 555"
        field.layer.cornerRadius = 24
        field.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView(image: UIImage(systemName: "phone"))
        imageView.tintColor = .gray
        
        field.leftView = imageView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .init(hex: "#FF8B5B")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AuthorizationViewDelegate?
    
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
        addSubview(signInLabel)
        addSubview(phoneNumberTextField)
        addSubview(signInButton)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        NSLayoutConstraint.activate(
            [
                logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 155),
                logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                logoImage.heightAnchor.constraint(equalToConstant: 80),
                logoImage.widthAnchor.constraint(equalToConstant: 170),
                
                signInLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
                signInLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                signInLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                signInLabel.heightAnchor.constraint(equalToConstant: 36),
                
                phoneNumberTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 16),
                phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                phoneNumberTextField.heightAnchor.constraint(equalToConstant: 56),
                
                signInButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
                signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
                signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                signInButton.heightAnchor.constraint(equalToConstant: 56)
            ]
        )
    }
    
    @objc
    private func signInTapped() {
        guard
            let phoneNumber = phoneNumberTextField.text
        else {
            return
        }
        
        let isValidPhoneNumber = phoneNumber.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil && phoneNumber.count == 9
        
        if !isValidPhoneNumber {
            phoneNumberTextField.layer.borderWidth = 1
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
            phoneNumberTextField.text = ""
            signInLabel.text = "Введите корректный номер!"
            signInLabel.font = .systemFont(ofSize: 16)
            signInLabel.textColor = .red
            return
        }
        delegate?.signInTapped()
    }
}
