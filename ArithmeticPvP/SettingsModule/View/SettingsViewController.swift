//
//  SettingsViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - SettingsViewController properties
    var viewModel: SettingsViewModelProtocol
    var settingsView: SettingsView!
    var activityIndicator: UIActivityIndicatorView!
    var initialView: InitialView!
    
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
        navigationItem.title = "Settings"
        
        initView()
        bindViewModel()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkCookie()
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
        
        activityIndicator.stopAnimating()
        initialView.isHidden = true
        settingsView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            print("initial")
            initialView.isHidden = false
        case .loading:
            print("loading")
            // initialView.isHidden = false
            settingsView.isHidden = false
            activityIndicator.startAnimating()
        case .error(let error):
            print("error")
            settingsView.isHidden = false
            displayError(error, title: "Failed to Log Out")
        case .registered:
            print("registered")
            settingsView.isHidden = false
            settingsView.logOutButton.isHidden = false
        case .notRegistered:
            print("not registered")
            settingsView.isHidden = false
            settingsView.logOutButton.isHidden = true
        }
    }
    
    private func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.checkCookie()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController {
    
    // MARK: - Initializing views
    private func initView() {
        createInitialView()
        createSettingsView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createSettingsView() {
        settingsView = SettingsView(frame: view.bounds)
        settingsView.logOutButton.addTarget(self, action: #selector(logOutButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(settingsView)
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
    }
    
    // MARK: - Selector objc functions
    @objc func logOutButtonTapped(_ sender: UIButton) {
        viewModel.logOutButtonTapped()
    }
}
