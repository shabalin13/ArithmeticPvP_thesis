//
//  SettingsNotRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 19.04.2023.
//

import UIKit

class SettingsNotRegisteredView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SettingsViewController
    
    var reportBugButton: UIButton!
    
    // MARK: - Inits
    init(frame: CGRect, presenetingVC: SettingsViewController) {
        self.presentingVC = presenetingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createReportBugButton()
    }
    
    // MARK: - Report Bug Button
    private func createReportBugButton() {
        reportBugButton = UIButton()
        self.addSubview(reportBugButton)
        
        reportBugButton.backgroundColor = Design.shared.settingsReportBugButtonColor
        reportBugButton.layer.cornerRadius = 10
        reportBugButton.setTitle("REPORT BUG", for: .normal)
        reportBugButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 22)
        reportBugButton.setTitleColor(Design.shared.settingsReportBugButtonTextColor, for: .normal)
        
        reportBugButton.addTarget(presentingVC, action: #selector(presentingVC.reportBugButtonTapped(_:)), for: .touchUpInside)
        reportBugButton.addTarget(presentingVC, action: #selector(presentingVC.reportBugButtonTouchDown(_:)), for: .touchDown)
        reportBugButton.addTarget(presentingVC, action: #selector(presentingVC.reportBugButtonTouchUpOutside(_:)), for: .touchUpOutside)
        
        reportBugButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reportBugButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            reportBugButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            reportBugButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            reportBugButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            reportBugButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
