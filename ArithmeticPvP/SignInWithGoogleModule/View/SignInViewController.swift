//
//  SignInViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - SignInViewController properties
    var viewModel: SignInViewModelProtocol
    var activityIndicator: UIActivityIndicatorView!
    var initialView: InitialView!
    var signInView: SignInView!
    
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
        navigationItem.title = "Registration"
        
        initView()
        bindViewModel()
        updateUI()
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
        
        print("SignInViewController.updateUI - \(Thread.current)")
        
        switch viewModel.state.value {
        case .initial:
            print("initial")
            initialView.isHidden = false
        case .loading:
            print("loading")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .error(let error):
            print("error")
            signInView.isHidden = false
            displayError(error, title: "Failed to Sign In")
        case .notRegistered:
            print("registered")
            signInView.isHidden = false
        }
    }
    
    private func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.state.value = .notRegistered
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension SignInViewController {
    
    // MARK: - Initializing views
    private func initView() {
        createInitialView()
        createSignInView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createSignInView() {
        signInView = SignInView(frame: view.bounds)
        signInView.signInWithGoogleButton.addTarget(self, action: #selector(signInWithGoogleButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(signInView)
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
    @objc func signInWithGoogleButtonTapped(_ sender: UIButton) {
        print("SignInViewController.signInWithGoogleButtonTapped - \(Thread.current)")
        viewModel.signInWithGoogleButtonTapped(presentingVC: self)
    }
}
