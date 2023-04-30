//
//  SkinAlertView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import UIKit

class SkinAlertView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SkinsViewController
    
    var skinImageView: UIImageView!
    var nameLabel: UILabel!
    var descriptionTextView: UITextView!
    var buyButton: UIButton!
    var cancelButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: SkinsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.backgroundColor = Design.shared.skinAlertBackgroundColor
        self.layer.cornerRadius = 10
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for skin: Skin, in cell: SkinCell?, with balance: Int) {
        
        if let image = cell?.image {
            skinImageView.image = image
        } else {
            skinImageView.image = nil
        }
        
        nameLabel.text = skin.name
        descriptionTextView.text = skin.description
        
        if !skin.isOwner && balance >= skin.price {
            buyButton.backgroundColor = Design.shared.skinsBuyButtonBackgroundColor
            buyButton.isEnabled = true
            
            let currentText = NSMutableAttributedString(string: "\(skin.price) ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            
            let imageAttachment = NSTextAttachment()
            let size = ("\(skin.price) " as NSString).boundingRect(with: buyButton.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.coinImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            
            buyButton.setAttributedTitle(currentText, for: .normal)
            
        } else if !skin.isOwner && balance < skin.price {
            buyButton.backgroundColor = Design.shared.skinsBuyButtonSelectedBackgroundColor
            buyButton.isEnabled = false
            
            let currentText = NSMutableAttributedString(string: "\(skin.price) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
            let imageAttachment = NSTextAttachment()
            let size = ("\(skin.price) " as NSString).boundingRect(with: buyButton.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.coinImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            
            buyButton.setAttributedTitle(currentText, for: .normal)
            
        } else if skin.isOwner && !skin.isSelected {
            buyButton.backgroundColor = Design.shared.skinsBuyButtonBackgroundColor
            buyButton.isEnabled = true
            buyButton.setAttributedTitle(NSAttributedString(string: "Select", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        } else {
            buyButton.backgroundColor = Design.shared.skinsBuyButtonSelectedBackgroundColor
            buyButton.isEnabled = false
            buyButton.setAttributedTitle(NSAttributedString(string: "Selected", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        }
    }
    
    // MARK: - Initializing views
    func initViews() {
        createSkinImageView()
        createNameLabel()
        createBuyButton()
        createCancelButton()
        createDescriptionTextView()
    }
    
    func createSkinImageView() {

        skinImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width / 2, height: self.bounds.width / 2))
        self.addSubview(skinImageView)
        
        skinImageView.contentMode = .scaleAspectFit

        skinImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            skinImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            skinImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -self.bounds.width / 6),
            skinImageView.widthAnchor.constraint(equalTo: skinImageView.heightAnchor, multiplier: 1),
            skinImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2)
        ])
    }
    
    func createNameLabel() {

        nameLabel = UILabel()
        self.addSubview(nameLabel)
        
        nameLabel.textAlignment = .center
        nameLabel.font = Design.shared.chillax(style: .medium, size: 26)
        nameLabel.textColor = Design.shared.skinsUsernameColor
        nameLabel.numberOfLines = 1
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: skinImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func createBuyButton() {

        buyButton = UIButton()
        self.addSubview(buyButton)
        
        buyButton.layer.cornerRadius = 10
        buyButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 20)
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buyButton.heightAnchor.constraint(equalToConstant: 40),
            buyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        
        buyButton.addTarget(presentingVC, action: #selector(presentingVC.buyButtonTapped(_:)), for: .touchUpInside)
        buyButton.addTarget(presentingVC, action: #selector(presentingVC.buyButtonTouchDown(_:)), for: .touchDown)
        buyButton.addTarget(presentingVC, action: #selector(presentingVC.buyButtonTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    func createCancelButton() {
        cancelButton = UIButton()
        self.addSubview(cancelButton)
        
        cancelButton.backgroundColor = Design.shared.skinsCancelButtonBackgroundColor
        cancelButton.layer.cornerRadius = 10
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 20)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: buyButton.trailingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalTo: buyButton.widthAnchor, multiplier: 1),
            cancelButton.heightAnchor.constraint(equalTo: buyButton.heightAnchor, multiplier: 1)
        ])
        
        cancelButton.addTarget(presentingVC, action: #selector(presentingVC.dismissSkinAlertButtonTapped(_:)), for: .touchUpInside)
        cancelButton.addTarget(presentingVC, action: #selector(presentingVC.dismissSkinAlertTouchDown(_:)), for: .touchDown)
        cancelButton.addTarget(presentingVC, action: #selector(presentingVC.dismissSkinAlertTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    func createDescriptionTextView() {

        descriptionTextView = UITextView()
        self.addSubview(descriptionTextView)
        
        descriptionTextView.textAlignment = .justified
        descriptionTextView.font = Design.shared.chillax(style: .regular, size: 18)
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = false
        descriptionTextView.backgroundColor = Design.shared.skinAlertBackgroundColor
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionTextView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -20),
        ])
    }

}
