//
//  SettingsRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.03.2023.
//

import UIKit


// MARK: UserInfoSettingsView Class
class UserInfoSettingsView: UIView, UITextFieldDelegate {
    
    // MARK: - Class Properties
    var usernameLabel: UILabel!
    var usernameTextField: UITextField!
    
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(with settingsData: SettingsData) {
        usernameTextField.text = settingsData.username
        emailTextField.text = settingsData.email
    }
    
    // MARK: - textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createUsernameLabel()
        createUsernameTextField()
        createEmailLabel()
        createEmailTextField()
    }
    
    private func createUsernameLabel() {
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        
        usernameLabel.textAlignment = .left
        usernameLabel.font = Design.shared.chillax(style: .regular, size: 16)
        usernameLabel.textColor = Design.shared.settingsUsernameAndEmailTextColor
        
        usernameLabel.text = "Your Username"
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createUsernameTextField() {
        usernameTextField = UITextField()
        self.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Username"
        usernameTextField.textAlignment = .left
        usernameTextField.font = Design.shared.chillax(style: .regular, size: 22)
        usernameTextField.textColor = Design.shared.settingsUsernameAndEmailTextColor
        
        usernameTextField.backgroundColor = Design.shared.settingsUsernameTextFieldColor
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            usernameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createEmailLabel() {
        emailLabel = UILabel()
        self.addSubview(emailLabel)
        
        emailLabel.textAlignment = .left
        emailLabel.font = Design.shared.chillax(style: .regular, size: 16)
        emailLabel.textColor = Design.shared.settingsUsernameAndEmailTextColor
        
        emailLabel.text = "Email"
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createEmailTextField() {
        emailTextField = UITextField()
        self.addSubview(emailTextField)
        
        emailTextField.isEnabled = false
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .left
        emailTextField.font = Design.shared.chillax(style: .regular, size: 22)
        emailTextField.textColor = Design.shared.settingsUsernameAndEmailTextColor
        
        emailTextField.minimumFontSize = 16
        emailTextField.adjustsFontSizeToFitWidth = true
        
        emailTextField.backgroundColor = Design.shared.settingsEmailTextFieldColor
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}


// MARK: - SettingsRegisteredView Class
class SettingsRegisteredView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SettingsViewController
    
    var userInfoSettingsView: UserInfoSettingsView!
    
    var reportBugButton: UIButton!
    var logOutButton: UIButton!
    
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
    
    // MARK: - Trait Collection
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        logOutButton.layer.borderColor = Design.shared.settingsLogOutButtonBorderColor.cgColor
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(with settingsData: SettingsData) {
        userInfoSettingsView.updateView(with: settingsData)
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createLogOutButton()
        createReportBugButton()
        createUserInfoSettingsView()
    }
    
    // MARK: - Log Out Button
    private func createLogOutButton() {
        logOutButton = UIButton()
        self.addSubview(logOutButton)
        
        logOutButton.backgroundColor = .none
        logOutButton.layer.borderWidth = 2
        logOutButton.layer.borderColor = Design.shared.settingsLogOutButtonBorderColor.resolvedColor(with: self.traitCollection).cgColor
        logOutButton.layer.cornerRadius = 10
        logOutButton.setTitle("LOG OUT", for: .normal)
        logOutButton.titleLabel?.font = Design.shared.chillax(style: .medium, size: 22)
        logOutButton.setTitleColor(Design.shared.settingsLogOutButtonTextColor, for: .normal)
        
        logOutButton.addTarget(presentingVC, action: #selector(presentingVC.logOutButtonTapped(_:)), for: .touchUpInside)
        logOutButton.addTarget(presentingVC, action: #selector(presentingVC.logOutButtonTouchDown(_:)), for: .touchDown)
        logOutButton.addTarget(presentingVC, action: #selector(presentingVC.logOutButtonTouchUpOutside(_:)), for: .touchUpOutside)
        
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
            reportBugButton.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -15),
            reportBugButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            reportBugButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            reportBugButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - User Info Settings View
    private func createUserInfoSettingsView() {
        userInfoSettingsView = UserInfoSettingsView()
        self.addSubview(userInfoSettingsView)
        
        userInfoSettingsView.usernameTextField.addTarget(presentingVC, action: #selector(presentingVC.usernameEditingChanged(_:)), for: .editingChanged)
        
        userInfoSettingsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoSettingsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            userInfoSettingsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userInfoSettingsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userInfoSettingsView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 1/2),
        ])
    }
    
}
