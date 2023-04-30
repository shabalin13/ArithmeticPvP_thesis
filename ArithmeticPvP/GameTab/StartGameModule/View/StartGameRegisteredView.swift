//
//  StartGameRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import UIKit

class StartGameRegisteredView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: StartGameViewController
    var startButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: StartGameViewController) {
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
        startButton.layer.borderColor = Design.shared.startButtonBorderColor.cgColor
    }
    
    // MARK: - Initializing views
    func initViews() {
        createStartButton()
    }
    
    // MARK: - Start Button
    func createStartButton() {
        startButton = UIButton()
        self.addSubview(startButton)
        
        updateStartButtonConstraints()
        
        startButton.backgroundColor = .none
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = Design.shared.startButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        startButton.layer.cornerRadius = 10
        startButton.setTitle("START", for: .normal)
        startButton.titleLabel?.font = Design.shared.chillax(style: .semibold, size: 30)
        startButton.setTitleColor(Design.shared.startButtonTextColor, for: .normal)
        
        startButton.addTarget(presentingVC, action: #selector(presentingVC.goToWaitingRoomButtonTapped(_:)), for: .touchUpInside)
        startButton.addTarget(presentingVC, action: #selector(presentingVC.startButtonTouchUpOutside(_:)), for: .touchUpOutside)
        startButton.addTarget(presentingVC, action: #selector(presentingVC.startButtonTouchDown(_:)), for: .touchDown)
    }
    
    private func updateStartButtonConstraints() {
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 55),
            startButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -55),
            startButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

extension StartGameViewController {
    
    // MARK: - Objc function for Start Button actions
    @objc func startButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.startButtonBorderTappedColor
            sender.setTitleColor(Design.shared.startButtonTappedTextColor, for: .normal)
        }
    }
    
    @objc func startButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.startButtonTextColor, for: .normal)
        }
    }
    
    @objc func goToWaitingRoomButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.startButtonTextColor, for: .normal)
        }
        viewModel.goToWaitingRoom()
    }
}
