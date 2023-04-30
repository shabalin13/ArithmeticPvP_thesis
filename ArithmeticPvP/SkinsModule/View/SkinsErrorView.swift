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
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific error data
    func updateView(with error: NetworkService.NetworkServiceError) {
        errorDescription.text = "ERROR!\n\(error)"
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
        
        errorImageView.image = Design.shared.internetErrorImage
        
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
        
        errorDescription.text = "Something went wrong!\nRELOAD this page!"
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
    
    //MARK: - Reload Button
    private func createReloadButton() {
        reloadButton = UIButton()
        self.addSubview(reloadButton)
        
        updateReloadButtonConstraints()
        
        reloadButton.backgroundColor = Design.shared.reloadButtonColor
        reloadButton.layer.cornerRadius = 10
        reloadButton.setTitle("RELOAD", for: .normal)
        reloadButton.titleLabel?.font = Design.shared.chillax(style: .semibold, size: 26)
        reloadButton.setTitleColor(Design.shared.reloadButtonTextColor, for: .normal)
        
        reloadButton.addTarget(presentingVC, action: #selector(presentingVC.reloadButtonTapped(_:)), for: .touchUpInside)
        reloadButton.addTarget(presentingVC, action: #selector(presentingVC.reloadButtonTouchUpOutside(_:)), for: .touchUpOutside)
        reloadButton.addTarget(presentingVC, action: #selector(presentingVC.reloadButtonTouchDown(_:)), for: .touchDown)
    }
    
    private func updateReloadButtonConstraints() {
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            reloadButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            reloadButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            reloadButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            reloadButton.topAnchor.constraint(greaterThanOrEqualTo: errorDescription.bottomAnchor, constant: 40),
            reloadButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}

extension SkinsViewController {
    
    // MARK: - Objc function for Reload Button actions
    @objc func reloadButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = Design.shared.reloadButtonTappedColor
        }
    }
    
    @objc func reloadButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = Design.shared.reloadButtonColor
        }
    }
    
    @objc func reloadButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = Design.shared.reloadButtonColor
        }
        viewModel.updateState()
    }
    
}
