//
//  SettingsView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.03.2023.
//

import UIKit

class SettingsView: UIView {
    
    // MARK: - SettingsView properties
    var presentingVC: SettingsViewController
    
    var reportBugButton: UIButton!
    var logOutButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presenetingVC: SettingsViewController) {
        self.presentingVC = presenetingVC
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        initViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createLogOutButton()
        createReportBugButton()
    }
    
    // MARK: - Log Out Button
    private func createLogOutButton() {
        logOutButton = UIButton()
        self.addSubview(logOutButton)
        
        logOutButton.addTarget(presentingVC, action: #selector(presentingVC.logOutButtonTapped(_:)), for: .touchUpInside)
        
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
    
    // MARK: - Report Bug Button
    private func createReportBugButton() {
        reportBugButton = UIButton()
        self.addSubview(reportBugButton)
        
        reportBugButton.addTarget(presentingVC, action: #selector(presentingVC.reportBugButtonTapped(_:)), for: .touchUpInside)
        
        updateReportBugButtonConstraints()
        
        reportBugButton.backgroundColor = .systemOrange
        reportBugButton.layer.cornerRadius = 10
        reportBugButton.setTitle("Report Bug", for: .normal)
    }
    
    private func updateReportBugButtonConstraints() {
        
        reportBugButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reportBugButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            reportBugButton.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -15),
            reportBugButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            reportBugButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            reportBugButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
