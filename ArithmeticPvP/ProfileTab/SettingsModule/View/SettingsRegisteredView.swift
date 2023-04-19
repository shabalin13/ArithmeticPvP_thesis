//
//  SettingsRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 17.03.2023.
//

import UIKit


// MARK: UserInfoSettingsView Class
class UserInfoSettingsView: UIView, UITextFieldDelegate {
    
    // MARK: - SettingsView properties
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
    
    // MARK: - Initializing views
    private func initViews() {
        createUsernameLabel()
        createUsernameTextField()
        createEmailLabel()
        createEmailTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return true
    }
    
    private func createUsernameLabel() {
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        
        usernameLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.textAlignment = .left
        
        usernameLabel.text = "Your Username"
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createUsernameTextField() {
        usernameTextField = UITextField()
        self.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.systemFont(ofSize: 22)
        usernameTextField.textAlignment = .left
        
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
        
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textAlignment = .left
        
        emailLabel.text = "Email"
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createEmailTextField() {
        emailTextField = UITextField()
        self.addSubview(emailTextField)
        
        emailTextField.isEnabled = false
        emailTextField.backgroundColor = .systemGray5
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 22)
        emailTextField.textAlignment = .left
        
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
    
    // MARK: - SettingsView properties
    var presentingVC: SettingsViewController
    
    var userInfoSettingsView: UserInfoSettingsView!
    
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
        
        logOutButton.backgroundColor = .systemBlue
        logOutButton.layer.cornerRadius = 10
        logOutButton.setTitle("Log Out", for: .normal)
        
        logOutButton.addTarget(presentingVC, action: #selector(presentingVC.logOutButtonTapped(_:)), for: .touchUpInside)
        
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
        
        reportBugButton.backgroundColor = .systemOrange
        reportBugButton.layer.cornerRadius = 10
        reportBugButton.setTitle("Report Bug", for: .normal)
        
        reportBugButton.addTarget(presentingVC, action: #selector(presentingVC.reportBugButtonTapped(_:)), for: .touchUpInside)
        
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
