//
//  ProfileView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class ProfileNotRegisteredView: UIView {
    
    //MARK: - Class Properties
    var errorImageView: UIImageView!
    var errorDescription: UILabel!
    var signInButton: UIButton!
    
    var presentingVC: ProfileViewController!
    
    //MARK: - Inits
    init(frame: CGRect, presentingVC: ProfileViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        self.backgroundColor = .white
        
        createErrorImageView()
        createErrorDescription()
        createSignInButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Error Image View
    private func createErrorImageView() {
        errorImageView = UIImageView()
        self.addSubview(errorImageView)
        
        updateErrorImageViewConstraints()
        
        errorImageView.image = UIImage(systemName: "exclamationmark.square.fill")
        errorImageView.tintColor = .systemGray
    }
    
    private func updateErrorImageViewConstraints() {
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            errorImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            errorImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            errorImageView.heightAnchor.constraint(equalTo: errorImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    //MARK: - Error Description
    private func createErrorDescription() {
        errorDescription = UILabel()
        self.addSubview(errorDescription)
        
        updateErrorDescriptionConstraints()
        
        errorDescription.text = "Please, Sign In to have opportunity to play Multiplayer Game"
        errorDescription.numberOfLines = 0
        errorDescription.lineBreakMode = .byWordWrapping
        errorDescription.textAlignment = .center
        errorDescription.font = UIFont.systemFont(ofSize: 24)
    }
    
    private func updateErrorDescriptionConstraints() {
        
        errorDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorDescription.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 30),
            errorDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            errorDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    //MARK: - Sign In Button
    private func createSignInButton() {
        signInButton = UIButton()
        self.addSubview(signInButton)
        
        updateSignInButtonConstraints()
        
        signInButton.backgroundColor = .systemBlue
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign In", for: .normal)
        
        signInButton.addTarget(presentingVC, action: #selector(presentingVC.signInButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func updateSignInButtonConstraints() {
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signInButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            signInButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescription.bottomAnchor, constant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension ProfileViewController {
    
    @objc func signInButtonTapped(_ sender: UIButton) {
        viewModel.signInButtonTapped()
    }
    
}









