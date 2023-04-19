//
//  StartGameRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import UIKit

class StartGameRegisteredView: UIView {
    
    var presentingVC: StartGameViewController
    var startButton: UIButton!
    
    init(frame: CGRect, presentingVC: StartGameViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        createStartButton()
    }
    
    func createStartButton() {
        startButton = UIButton()
        self.addSubview(startButton)
        
        updateStartButtonConstraints()
        
        startButton.backgroundColor = .white
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.cornerRadius = 10
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.setTitleColor(.systemGray, for: .highlighted)
        
        startButton.addTarget(presentingVC, action: #selector(presentingVC.goToWaitingRoomButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func updateStartButtonConstraints() {
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.widthAnchor.constraint(equalTo: startButton.heightAnchor, multiplier: 1)
        ])
    }
}

extension StartGameViewController {
    
    @objc func goToWaitingRoomButtonTapped(_ sender: UIButton) {
        viewModel.goToWaitingRoom()
    }
}
