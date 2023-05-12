//
//  SignInViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - Class Properties
    var viewModel: SignInViewModelProtocol
    
    var activityIndicator: UIActivityIndicatorView!
    var initialView: InitialView!
    var signInView: SignInView!
    
    // MARK: - Inits
    init(viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
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
        
        activityIndicator.stopAnimating()
        initialView.isHidden = true
        signInView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("SignInViewController initial")
            initialView.isHidden = false
        case .loading:
            NSLog("SignInViewController loading")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .error(let error):
            NSLog("SignInViewController error")
            NSLog("\(error)")
            signInView.isHidden = false
            displayError(error, title: "Failed to Sign In")
        case .notRegistered:
            NSLog("SignInViewController not registered")
            signInView.isHidden = false
        }
    }
    
    // MARK: - Func for displaying error using alert
    private func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.state.value = .notRegistered
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Func for displaying Email Auth alert
    func displayEmailAlert() {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: "Sign In", message: "This is only for testing emails", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
            guard let email = alert.textFields?.first?.text,
                  let password = alert.textFields?.last?.text else { return }
            
            self.viewModel.signInWithEmail(email: email, password: password)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension SignInViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        
        navigationItem.title = "REGISTRATION"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withTintColor(Design.shared.navigationTitleColor, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        
        createInitialView()
        createSignInView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createSignInView() {
        signInView = SignInView(frame: view.bounds, presentingVC: self)
        view.addSubview(signInView)
        signInView.isHidden = true
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
    }
    
    // MARK: - Objc function for button actions
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.router.popToRoot()
    }
    
}
