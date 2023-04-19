//
//  SignInView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit

class SignInView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SignInViewController
    
    var signInWithGoogleButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: SignInViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        createSignInWithGoogleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Sign In With Google
    private func createSignInWithGoogleButton() {
        signInWithGoogleButton = UIButton()
        self.addSubview(signInWithGoogleButton)
        
        signInWithGoogleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithGoogleButtonTapped(_:)), for: .touchUpInside)
        
        updateSignInWithGoogleButtonConstraints()
        
        signInWithGoogleButton.backgroundColor = .systemBlue
        signInWithGoogleButton.layer.cornerRadius = 10
        signInWithGoogleButton.setTitle("Sign In With Google", for: .normal)
    }
    
    private func updateSignInWithGoogleButtonConstraints() {
        
        signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInWithGoogleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInWithGoogleButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signInWithGoogleButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            signInWithGoogleButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            signInWithGoogleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
