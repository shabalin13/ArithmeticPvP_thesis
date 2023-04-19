//
//  ProfileViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Class Properties
    var viewModel: ProfileViewModelProtocol
    
    var initialView: InitialView!
    var registeredView: ProfileRegisteredView!
    var notRegisteredView: ProfileNotRegisteredView!
    var errorView: ProfileErrorView!
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Inits
    init(viewModel: ProfileViewModelProtocol) {
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
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        viewModel.profileData = ProfileData()
//    }
    
    // MARK: - ViewModel binding
    func bindViewModel() {
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
        registeredView.isHidden = true
        notRegisteredView.isHidden = true
        errorView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("ProfileViewController initial")
            initialView.isHidden = false
        case .loading:
            NSLog("ProfileViewController loading")
//            initialView.isHidden = false
            registeredView.isHidden = false
//            activityIndicator.startAnimating()
        case .error(let error):
            NSLog("ProfileViewController error")
            NSLog("\(error)")
            errorView.updateView(for: error)
            errorView.isHidden = false
        case .notRegistered:
            NSLog("ProfileViewController not registered")
            notRegisteredView.isHidden = false
        case .registered(let profileData):
            NSLog("ProfileViewController registered")
            registeredView.updateView(for: profileData)
            registeredView.isHidden = false
        }
    }
    
}


extension ProfileViewController {
    
    // MARK: - Initializing views
    private func initView() {
        
        navigationItem.title = "PROFILE"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(pushToSettings(_:)))
        
        createInitialView()
        createRegisteredView()
        createNotRegisteredView()
        createErrorView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createRegisteredView() {
        registeredView = ProfileRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(registeredView)
    }
    
    private func createNotRegisteredView() {
        notRegisteredView = ProfileNotRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(notRegisteredView)
    }
    
    private func createErrorView() {
        errorView = ProfileErrorView(frame: view.bounds, presentingVC: self)
        view.addSubview(errorView)
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
    @objc func pushToSettings(_ sender: UIBarButtonItem) {
        viewModel.goToSettings()
    }
    
    @objc func signInButtonTapped(_ sender: UIButton) {
        viewModel.goToSignIn()
    }
    
    @objc func reloadButtonTapped(_ sender: UIButton) {
        viewModel.updateState()
    }
}
