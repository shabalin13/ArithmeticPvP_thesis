//
//  SkinsErrorView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import UIKit

class SkinsErrorView: UIView {

    //MARK: - Class Properties
    var presentingVC: SkinsViewController
    
    var errorImageView: UIImageView!
    var errorDescription: UILabel!
    var reloadButton: UIButton!
    
    //MARK: - Inits
    init(frame: CGRect, presentingVC: SkinsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific error data
    func updateView(with error: NetworkService.NetworkServiceError) {
        errorDescription.text = "ERROR!\n\(error)\nPlease, try to reload this page!"
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createErrorImageView()
        createErrorDescription()
        createReloadButton()
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
        
        errorDescription.text = "Something went wrong!\nPlease, try to reload this page!"
        errorDescription.numberOfLines = 0
        errorDescription.lineBreakMode = .byWordWrapping
        errorDescription.textAlignment = .center
        errorDescription.font = UIFont.systemFont(ofSize: 32)
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
    
    //MARK: - Reload Button
    private func createReloadButton() {
        reloadButton = UIButton()
        self.addSubview(reloadButton)
        
        updateReloadButtonConstraints()
        
        reloadButton.backgroundColor = .systemBlue
        reloadButton.layer.cornerRadius = 10
        reloadButton.setTitle("RELOAD", for: .normal)
        reloadButton.setTitleColor(.systemGray, for: .highlighted)
        
        reloadButton.addTarget(presentingVC, action: #selector(presentingVC.reloadButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func updateReloadButtonConstraints() {
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            reloadButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            reloadButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            reloadButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            reloadButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescription.bottomAnchor, constant: 40),
            reloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
