//
//  ProfileRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit
import SVGKit

class ProfileRegisteredView: UIView {
    
    //MARK: - ProfileRegisteredView properties
    var skinImageView: UIImageView!
    var usernameLabel: UILabel!
    var usernameChangeButton: UIButton!
    var emailLabel: UILabel!
    var ratingPlaceLabel: UILabel!
    
    var balanceImageView: UIImageView!
    var balanceLabel: UILabel!
    
    var presentingVC: ProfileViewController!
    
    //MARK: - Inits
    init(frame: CGRect, presentingVC: ProfileViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        
//        backgroundColor = UIColor(patternImage: Design.shared.backgroundImage)
        self.backgroundColor = .white
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView(for user: User) {
        if let currentSkinData = user.currentSkinData {
            skinImageView.image = UIImage(data: currentSkinData)
//            skinImageView.image = SVGKImage(named: "black_man").uiImage
        }
        usernameLabel.text = user.username
        usernameChangeButton.isHidden = false
        emailLabel.text = user.email
        ratingPlaceLabel.text = "Rating Place: \(user.ratingPlace)"
    }
    
    //MARK: - Initializing views
    private func initViews() {
        createSkinImageView()
        
        createUsernameLabel()
        createUsernameChangeButton()
        
//        usernameLabel.backgroundColor = .red
//        usernameChangeButton.backgroundColor = .blue
        
        let usernameStack = UIStackView(arrangedSubviews: [usernameLabel, usernameChangeButton])
        self.addSubview(usernameStack)
//        usernameStack.distribution = .fillEqually
//        usernameStack.distribution = .fill
        usernameStack.distribution = .fillProportionally
//        usernameStack.distribution = .equalSpacing
//        usernameStack.distribution = .equalCentering
        usernameStack.alignment = .center
        usernameStack.spacing = 10
        
        usernameStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            usernameStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            usernameStack.topAnchor.constraint(equalTo: skinImageView.bottomAnchor, constant: 20)
        ])
        
        createEmailLabel()
        createRatingPlaceLabel()
    }
    
    // MARK: - Skin
    private func createSkinImageView() {
        skinImageView = UIImageView()
        self.addSubview(skinImageView)
        
        updateSkinImageViewConstraints()
    }
    
    private func setSkin() {
        
    }
    
    private func updateSkinImageViewConstraints() {
        
        skinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            skinImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            skinImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            skinImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            skinImageView.heightAnchor.constraint(equalTo: skinImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    // MARK: - Username
    private func createUsernameLabel() {
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        
//        updateUsernameLabelConstraints()
        
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 24)
    }
    
//    private func updateUsernameLabelConstraints() {
//
//        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            usernameLabel.topAnchor.constraint(equalTo: skinImageView.bottomAnchor, constant: 20)
//        ])
//    }
    
    private func createUsernameChangeButton() {
        usernameChangeButton = UIButton()
        usernameChangeButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
        self.addSubview(usernameChangeButton)
        usernameChangeButton.isHidden = true
        
        usernameChangeButton.addTarget(presentingVC, action: #selector(presentingVC.displayUsernameChangeAlert), for: .touchUpInside)
//        updateUsernameChangeButtonConstraints()
    }
    
//    private func updateUsernameChangeButtonConstraints() {
//
//        usernameChangeButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            usernameLabel.topAnchor.constraint(equalTo: skinImageView.bottomAnchor, constant: 20)
//        ])
//    }
    
    // MARK: - Email
    private func createEmailLabel() {
        emailLabel = UILabel()
        self.addSubview(emailLabel)
        
        updateEmailLabelConstraints()
        
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 22)
    }
    
    private func updateEmailLabelConstraints() {
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - Rating Place
    private func createRatingPlaceLabel() {
        ratingPlaceLabel = UILabel()
        self.addSubview(ratingPlaceLabel)
        
        updateRatingPlaceLabelConstraints()
        
        ratingPlaceLabel.textAlignment = .center
        ratingPlaceLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func updateRatingPlaceLabelConstraints() {
        
        ratingPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingPlaceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ratingPlaceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ratingPlaceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ratingPlaceLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20)
        ])
    }
    
}

extension ProfileViewController {
    
    @objc func displayUsernameChangeAlert() {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: "Username Change", message: "You can change your username in this form.", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?[0].text = registeredView.usernameLabel.text
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { [weak self] alertAction in
            guard let self = self else { return }
            self.viewModel.changeUsernameButtonTapped(with: alert.textFields?[0].text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
