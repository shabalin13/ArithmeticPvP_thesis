//
//  SettingsView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.03.2023.
//

import UIKit

class SettingsView: UIView {
    
    // MARK: - SettingsView properties
    var logOutButton: UIButton!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        
        createLogOutButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Log Out
    private func createLogOutButton() {
        logOutButton = UIButton()
        self.addSubview(logOutButton)
        
        updateLogOutButtonConstraints()
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.layer.cornerRadius = 10
        logOutButton.setTitle("Log Out", for: .normal)
    }
    
    private func updateLogOutButtonConstraints() {
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logOutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            logOutButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
