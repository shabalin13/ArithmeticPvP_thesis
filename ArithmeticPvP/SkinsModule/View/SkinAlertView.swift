//
//  SkinAlertView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import UIKit

class SkinAlertView: UIView {
    
    var presentingVC: SkinsViewController!
    
    var skinImageView: UIImageView!
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var buyButton: UIButton!
    var cancelButton: UIButton!
    
    var skin: Skin!
    
    init(frame: CGRect, presentingVC: SkinsViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView(for skin: Skin, in cell: SkinCell?, with balance: Double) {
        
        self.skin = skin
        
        if let image = cell?.image {
            skinImageView.image = image
        } else {
            skinImageView.image = UIImage(systemName: "photo.on.rectangle")
        }
        
        nameLabel.text = skin.name
        descriptionLabel.text = skin.description
        
        if !skin.isOwner && balance >= skin.price {
            buyButton.backgroundColor = .systemGreen
            buyButton.isEnabled = true
            buyButton.setTitle("Buy ($\(skin.price))", for: .normal)
        } else if !skin.isOwner && balance < skin.price {
            buyButton.backgroundColor = .systemGray4
            buyButton.isEnabled = false
            buyButton.setTitle("Buy ($\(skin.price))", for: .normal)
        } else if skin.isOwner && !skin.isSelected {
            buyButton.backgroundColor = .systemGreen
            buyButton.isEnabled = true
            buyButton.setTitle("Select", for: .normal)
        } else {
            buyButton.setTitle("Selected", for: .normal)
            buyButton.backgroundColor = .systemGray4
            buyButton.isEnabled = false
        }
    }
    
    func initViews() {
        configureView()
        createSkinImageView()
        createNameLabel()
        createDescriptionLabel()
        createBuyButton()
        createCancelButton()
    }
    
    func configureView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
    }
    
    func createSkinImageView() {

        skinImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.addSubview(skinImageView)

        skinImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            skinImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            skinImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            skinImageView.widthAnchor.constraint(equalTo: skinImageView.heightAnchor, multiplier: 1)
        ])
    }
    
    func createNameLabel() {

        nameLabel = UILabel()
        self.addSubview(nameLabel)
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 26)
        nameLabel.numberOfLines = 1
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: skinImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func createDescriptionLabel() {

        descriptionLabel = UILabel()
        self.addSubview(descriptionLabel)
        
        descriptionLabel.textAlignment = .natural
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func createBuyButton() {

        buyButton = UIButton()
        self.addSubview(buyButton)
        
        buyButton.layer.cornerRadius = 10
        buyButton.setTitleColor(.systemGray, for: .highlighted)
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buyButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 20),
            buyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
        buyButton.addTarget(presentingVC, action: #selector(presentingVC.buyButtonTapped(_:)), for: .touchUpInside)
    }
    
    func createCancelButton() {
        cancelButton = UIButton()
        self.addSubview(cancelButton)
        
        cancelButton.backgroundColor = .systemRed
        cancelButton.layer.cornerRadius = 10
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemGray, for: .highlighted)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cancelButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalTo: buyButton.widthAnchor, multiplier: 1)
        ])
        
        cancelButton.addTarget(presentingVC, action: #selector(presentingVC.dismissSkinAlert), for: .touchUpInside)
    }

}
