//
//  ProfileView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class ProfileNotRegisteredView: UIView {
    
    //MARK: - Class Properties
    var presentingVC: ProfileViewController
    
    var errorImageView: UIImageView!
    var errorDescription: UILabel!
    var signInButton: UIButton!
    
    //MARK: - Inits
    init(frame: CGRect, presentingVC: ProfileViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Trait Collection
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        signInButton.layer.borderColor = Design.shared.signInButtonBorderColor.cgColor
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createErrorImageView()
        createErrorDescription()
        createSignInButton()
    }
    
    //MARK: - Error Image View
    private func createErrorImageView() {
        errorImageView = UIImageView()
        self.addSubview(errorImageView)
        
        errorImageView.image = Design.shared.notRegisteredImage
        
        updateErrorImageViewConstraints()
    }
    
    private func updateErrorImageViewConstraints() {
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            errorImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            errorImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            errorImageView.heightAnchor.constraint(equalTo: errorImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    //MARK: - Error Description
    private func createErrorDescription() {
        errorDescription = UILabel()
        self.addSubview(errorDescription)
        
        updateErrorDescriptionConstraints()
        
        errorDescription.text = "Sign In to dive into the Multiplayer Game"
        errorDescription.numberOfLines = 0
        errorDescription.lineBreakMode = .byWordWrapping
        errorDescription.textAlignment = .center
        errorDescription.textColor = Design.shared.textColor
        errorDescription.font = Design.shared.chillax(style: .regular, size: 32)
    }
    
    private func updateErrorDescriptionConstraints() {
        
        errorDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorDescription.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 15),
            errorDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            errorDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    //MARK: - Sign In Button
    private func createSignInButton() {
        signInButton = UIButton()
        self.addSubview(signInButton)
        
        updateSignInButtonConstraints()
        
        signInButton.backgroundColor = .none
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = Design.shared.signInButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 22)
        signInButton.setTitleColor(Design.shared.signInButtonTextColor, for: .normal)
        
        signInButton.addTarget(presentingVC, action: #selector(presentingVC.signInButtonTapped(_:)), for: .touchUpInside)
        signInButton.addTarget(presentingVC, action: #selector(presentingVC.signInButtonTouchDown(_:)), for: .touchDown)
        signInButton.addTarget(presentingVC, action: #selector(presentingVC.signInButtonTouchUpOutside(_:)), for: .touchUpOutside)
        
    }
    
    private func updateSignInButtonConstraints() {
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            signInButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescription.bottomAnchor, constant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

extension ProfileViewController {
    
    // MARK: - Obj funcs for Sign In button actions
    @objc func signInButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.signInButtonTextColor, for: .normal)
        }
        viewModel.goToSignIn()
    }
    
    @objc func signInButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.signInButtonTappedColor
            sender.setTitleColor(Design.shared.signInButtonTappedTextColor, for: .normal)
        }
    }
    
    @objc func signInButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.signInButtonTextColor, for: .normal)
        }
    }
}
