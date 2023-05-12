//
//  SignInView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit

// MARK: - Reason View Class
class ReasonView: UIView {
    
    // MARK: - Class Properties
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating view with specified data
    func updateView(title: String, description: String, image: UIImage) {
        titleLabel.text = title
        descriptionLabel.text = description
        imageView.image = image
    }
    
    // MARK: - Initializing views
    private func initView() {
        createImageView()
        createTitleLabel()
        createDescriptionLabel()
    }
    
    private func createImageView() {
        imageView = UIImageView()
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createTitleLabel() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = Design.shared.chillax(style: .medium, size: 20)
        titleLabel.textColor = Design.shared.signInReasonTitleLabelTextColor
        
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    private func createDescriptionLabel() {
        descriptionLabel = UILabel()
        self.addSubview(descriptionLabel)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Design.shared.chillax(style: .regular, size: 16)
        descriptionLabel.textColor = Design.shared.signInReasonDescriptionLabelTextColor
        
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])
    }
}


// MARK: - Sign In View Class
class SignInView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SignInViewController
    
    var mainLabel: UILabel!
    
    var reasonsData: [(String, String, UIImage)] = [
        ("Track your progress", "Track your statistics and try to improve them", Design.shared.ratingImage),
        ("Compete with others", "Get to the top of the rating", Design.shared.cupImage),
        ("Buy super-duper skins", "Buy the coolest skins to show off your unique style", Design.shared.skinsImage)
    ]
    var reasonsStackView: UIStackView!
    
    var signInWithGoogleButton: UIButton!
    var signInWithAppleButton: UIButton!
    var signInWithEmailButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: SignInViewController) {
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
        signInWithGoogleButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.cgColor
        signInWithAppleButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.cgColor
        signInWithEmailButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.cgColor
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createSignInWithGoogleButton()
        createSignInWithAppleButton()
        createSignInWithEmailButton()
        createMainLabel()
        createReasonsStackView()
    }
    
    // MARK: - Sign In With Google
    private func createSignInWithGoogleButton() {
        signInWithGoogleButton = UIButton()
        self.addSubview(signInWithGoogleButton)
        
        signInWithGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInWithGoogleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInWithGoogleButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            signInWithGoogleButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInWithGoogleButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signInWithGoogleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        signInWithGoogleButton.backgroundColor = .none
        signInWithGoogleButton.layer.borderWidth = 2
        signInWithGoogleButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        signInWithGoogleButton.layer.cornerRadius = 10
        signInWithGoogleButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 20)
        
        let currentText = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        let size = ("Continue with Google" as NSString).boundingRect(with: signInWithGoogleButton.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
        imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
        imageAttachment.image = Design.shared.googleLogoImage
        currentText.append(NSAttributedString(attachment: imageAttachment))
        currentText.append(NSAttributedString(string: " Continue with Google", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
        signInWithGoogleButton.setAttributedTitle(currentText, for: .normal)
    
        signInWithGoogleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithGoogleButtonTapped(_:)), for: .touchUpInside)
        signInWithGoogleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithGoogleButtonTouchDown(_:)), for: .touchDown)
        signInWithGoogleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithGoogleButtonTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    // MARK: - Sign In With Apple
    private func createSignInWithAppleButton() {
        signInWithAppleButton = UIButton()
        self.addSubview(signInWithAppleButton)
        
        signInWithAppleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInWithAppleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: signInWithGoogleButton.topAnchor, constant: -15),
            signInWithAppleButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInWithAppleButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        signInWithAppleButton.backgroundColor = .none
        signInWithAppleButton.layer.borderWidth = 2
        signInWithAppleButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        signInWithAppleButton.layer.cornerRadius = 10
        signInWithAppleButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 20)
        
        let currentText = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        let size = ("Continue with Apple" as NSString).boundingRect(with: signInWithAppleButton.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
        imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
        imageAttachment.image = Design.shared.appleLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
        currentText.append(NSAttributedString(attachment: imageAttachment))
        currentText.append(NSAttributedString(string: " Continue with Apple", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
        signInWithAppleButton.setAttributedTitle(currentText, for: .normal)
    
        signInWithAppleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithAppleButtonTapped(_:)), for: .touchUpInside)
        signInWithAppleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithAppleButtonTouchDown(_:)), for: .touchDown)
        signInWithAppleButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithAppleButtonTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    private func createSignInWithEmailButton() {
        signInWithEmailButton = UIButton()
        self.addSubview(signInWithEmailButton)
        
        signInWithEmailButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInWithEmailButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInWithEmailButton.bottomAnchor.constraint(equalTo: signInWithAppleButton.topAnchor, constant: -15),
            signInWithEmailButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInWithEmailButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signInWithEmailButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        signInWithEmailButton.backgroundColor = .none
        signInWithEmailButton.layer.borderWidth = 2
        signInWithEmailButton.layer.borderColor = Design.shared.signInWithGoogleButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        signInWithEmailButton.layer.cornerRadius = 10
        signInWithEmailButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 20)
        
        let currentText = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        let size = ("Continue with Email" as NSString).boundingRect(with: signInWithEmailButton.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
        imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
        imageAttachment.image = Design.shared.emailLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
        currentText.append(NSAttributedString(attachment: imageAttachment))
        currentText.append(NSAttributedString(string: " Continue with Email", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
        signInWithEmailButton.setAttributedTitle(currentText, for: .normal)
    
        signInWithEmailButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithEmailButtonTapped(_:)), for: .touchUpInside)
        signInWithEmailButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithEmailButtonTouchDown(_:)), for: .touchDown)
        signInWithEmailButton.addTarget(presentingVC, action: #selector(presentingVC.signInWithEmailButtonTouchUpOutside(_:)), for: .touchUpOutside)
    }
    
    // MARK: - Main Label
    private func createMainLabel() {
        mainLabel = UILabel()
        self.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
        ])
        
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        mainLabel.font = Design.shared.chillax(style: .semibold, size: 28)
        mainLabel.textColor = Design.shared.signInMainLabelTextColor
        mainLabel.minimumScaleFactor = 0.5
        mainLabel.adjustsFontSizeToFitWidth = true
        
        let currentText = NSMutableAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .semibold, size: 28)])
        currentText.append(NSAttributedString(string: " to get the most out of ", attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 28)]))
        currentText.append(NSAttributedString(string: "ArithmeticPvP", attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .semibold, size: 28)]))
        mainLabel.attributedText = currentText
    }
    
    // MARK: - Reasons Stack View
    private func createReasonsStackView() {
        reasonsStackView = UIStackView()
        self.addSubview(reasonsStackView)
        
        for (reasonTitle, reasonDescription, reasonImage) in reasonsData {
            let reasonView = ReasonView()
            reasonView.updateView(title: reasonTitle, description: reasonDescription, image: reasonImage)
            reasonsStackView.addArrangedSubview(reasonView)
        }
        
        reasonsStackView.axis = .vertical
        reasonsStackView.spacing = 10
        reasonsStackView.distribution = .fillEqually
        reasonsStackView.alignment = .leading
        
        reasonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reasonsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            reasonsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            reasonsStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            reasonsStackView.bottomAnchor.constraint(equalTo: signInWithEmailButton.topAnchor, constant: -15),
        ])

    }
    
}

extension SignInViewController {
    
    // MARK: - Obj funcs for Google's button actions
    @objc func signInWithGoogleButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Google" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.googleLogoImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Google", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
        viewModel.signInWithGoogleButtonTapped(presentingVC: self)
    }
    
    @objc func signInWithGoogleButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.signInWithGoogleButtonTappedColor
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Google" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.googleLogoImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Google", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTappedTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
    @objc func signInWithGoogleButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Google" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.googleLogoImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Google", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
    // MARK: - Obj funcs for Apple's button actions
    @objc func signInWithAppleButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Apple" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.appleLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Apple", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
        viewModel.signInWithApple(presentingVC: self)
    }
    
    @objc func signInWithAppleButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.signInWithGoogleButtonTappedColor
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Apple" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.appleLogoImage.withTintColor(Design.shared.signInWithAppleLogoHighlightedColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Apple", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTappedTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
    @objc func signInWithAppleButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Apple" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.appleLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Apple", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
    // MARK: - Obj funcs for Email's button actions
    @objc func signInWithEmailButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Email" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.emailLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Email", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
        self.displayEmailAlert()
    }
    
    @objc func signInWithEmailButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.signInWithGoogleButtonTappedColor
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Email" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.emailLogoImage.withTintColor(Design.shared.signInWithAppleLogoHighlightedColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Email", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTappedTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
    @objc func signInWithEmailButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            
            let currentText = NSMutableAttributedString()
            let imageAttachment = NSTextAttachment()
            let size = ("Continue with Email" as NSString).boundingRect(with: sender.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .medium, size: 20)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (Design.shared.chillax(style: .medium, size: 20).capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.emailLogoImage.withTintColor(Design.shared.signInWithAppleLogoColor, renderingMode: .alwaysOriginal)
            currentText.append(NSAttributedString(attachment: imageAttachment))
            currentText.append(NSAttributedString(string: " Continue with Email", attributes: [NSAttributedString.Key.foregroundColor : Design.shared.signInWithGoogleButtonTextColor]))
            sender.setAttributedTitle(currentText, for: .normal)
            
        }
    }
    
}
