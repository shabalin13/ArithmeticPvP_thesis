//
//  SkinsNotRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import UIKit

class SkinsNotRegisteredView: UIView {

    //MARK: - Class Properties
    var errorImageView: UIImageView!
    var errorDescription: UILabel!
    
    var presentingVC: SkinsViewController!
    
    //MARK: - Inits
    init(frame: CGRect, presentingVC: SkinsViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        self.backgroundColor = .white
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initViews() {
        createErrorImageView()
        createErrorDescription()
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
        
        errorDescription.text = "You are not loged in!\nPlease, go to Profile tab!"
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
            errorDescription.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
}
