//
//  SettingsViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    // MARK: - Class properties
    var viewModel: SettingsViewModelProtocol
    
    var initialView: InitialView!
    var settingsRegisteredView: SettingsRegisteredView!
    var settingsNotRegisteredView: SettingsNotRegisteredView!
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Inits
    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateState()
    }
    
    // MARK: - ViewModel binding
    private func bindViewModel() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    // MARK: - UI functions
    private func updateUI() {
        
        navigationItem.rightBarButtonItem = nil
        activityIndicator.stopAnimating()
        initialView.isHidden = true
        settingsRegisteredView.isHidden = true
        settingsNotRegisteredView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("SettingsViewController initial")
            initialView.isHidden = false
        case .loading:
            NSLog("SettingsViewController loading")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .registered(let settingsData):
            NSLog("SettingsViewController registered")
            settingsRegisteredView.updateView(with: settingsData)
            settingsRegisteredView.isHidden = false
        case .notRegistered:
            NSLog("SettingsViewController not registered")
            settingsNotRegisteredView.isHidden = false
        case .error(let error):
            NSLog("SettingsViewController error")
            initialView.isHidden = false
            displayError(error, title: "Error!")
        }
    }
    
    // MARK: - Error Alert
    private func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.router.popToRoot()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController {
    
    // MARK: - Initializing views
    private func initView() {
        
        navigationItem.title = "SETTINGS"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withTintColor(Design.shared.navigationTitleColor, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        
        createInitialView()
        createSettingsRegisteredView()
        createSettingsNotRegisteredView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createSettingsRegisteredView() {
        settingsRegisteredView = SettingsRegisteredView(frame: view.bounds, presenetingVC: self)
        view.addSubview(settingsRegisteredView)
        settingsRegisteredView.isHidden = true
    }
    
    private func createSettingsNotRegisteredView() {
        settingsNotRegisteredView = SettingsNotRegisteredView(frame: view.bounds, presenetingVC: self)
        view.addSubview(settingsNotRegisteredView)
        settingsNotRegisteredView.isHidden = true
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
    }
    
    // MARK: - Objc function for buttons actions
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.router.popToRoot()
    }
    
    @objc func usernameEditingChanged(_ sender: UITextField) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(changeUsernameButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = Design.shared.settingsSaveTextColor
    }
    
    @objc func changeUsernameButtonTapped(_ sender: UIBarButtonItem) {
        let newUsername = settingsRegisteredView.userInfoSettingsView.usernameTextField.text
        settingsRegisteredView.userInfoSettingsView.usernameTextField.resignFirstResponder()
        viewModel.changeUsername(with: newUsername)
    }
}


// MARK: - Objc function for Report Bug Button actions
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    @objc func reportBugButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = Design.shared.settingsReportBugButtonColor
        }
        
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["d.shabal1n12@gmail.com"])
        mailComposer.setSubject("ArithmeticPvP Bug Report.")
        
        present(mailComposer, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func reportBugButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = Design.shared.settingsReportBugButtonTappedColor
        }
    }
    
    @objc func reportBugButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = Design.shared.settingsReportBugButtonColor
        }
    }
}


// MARK: - Objc function for Log Out Button actions
extension SettingsViewController {
    
    @objc func logOutButtonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = Design.shared.settingsLogOutButtonTappedColor
            sender.setTitleColor(Design.shared.settingsLogOutButtonTappedTextColor, for: .normal)
        }
    }
    
    @objc func logOutButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.settingsLogOutButtonTextColor, for: .normal)
        }
    }
    
    @objc func logOutButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.backgroundColor = .none
            sender.setTitleColor(Design.shared.settingsLogOutButtonTextColor, for: .normal)
        }
        viewModel.logOut()
    }
}
