//
//  StartGameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit

class StartGameViewController: UIViewController {
    
    // MARK: - Class Properties
    var viewModel: StartGameViewModelProtocol
    
    var initialView: InitialView!
    var registeredView: StartGameRegisteredView!
    var notRegisteredView: StartGameNotRegisteredView!
    
    // MARK: - Inits
    init(viewModel: StartGameViewModelProtocol) {
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
        tabBarController?.tabBar.isHidden = false
        viewModel.updateState()
    }
    
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
        
        initialView.isHidden = true
        registeredView.isHidden = true
        notRegisteredView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("StartGameViewController initial")
            initialView.isHidden = false
        case .registered:
            NSLog("StartGameViewController registered")
            registeredView.isHidden = false
        case .notRegistered:
            NSLog("StartGameViewController not registered")
            notRegisteredView.isHidden = false
        }
    }
    
}

extension StartGameViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        navigationItem.title = "RATING GAME"
        
        createInitialView()
        createRegisteredView()
        createNotRegisteredView()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createRegisteredView() {
        registeredView = StartGameRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(registeredView)
        registeredView.isHidden = true
    }
    
    private func createNotRegisteredView() {
        notRegisteredView = StartGameNotRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(notRegisteredView)
        notRegisteredView.isHidden = true
    }
    
}
