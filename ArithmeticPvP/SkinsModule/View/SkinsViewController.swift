//
//  SkinsViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class SkinsViewController: UIViewController {
    
    // MARK: - Class Properties
    var viewModel: SkinsViewModelProtocol
    
    var initialView: InitialView!
    var skinsRegisteredView: SkinsRegisteredView!
    var skinsNotRegisteredView: SkinsNotRegisteredView!
    var skinAlertView: SkinAlertView!
    var skinsErrorView: SkinsErrorView!
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Inits
    init(viewModel: SkinsViewModelProtocol) {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        allowUserInteraction()
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
        
        dismissSkinAlert()
        activityIndicator.stopAnimating()
        initialView.isHidden = true
        skinsRegisteredView.isHidden = true
        skinsErrorView.isHidden = true
        skinsNotRegisteredView.isHidden = true
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        
        switch viewModel.state.value {
        case .initial:
            NSLog("SkinsViewController initial")
            initialView.isHidden = false
        case .loading:
            NSLog("SkinsViewController initial")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .registered:
            NSLog("SkinsViewController registered")
            skinsRegisteredView.updateView()
            skinsRegisteredView.isHidden = false
        case .notRegistered:
            NSLog("SkinsViewController not registered")
            skinsNotRegisteredView.isHidden = false
        case .error(let error):
            NSLog("SkinsViewController error")
            skinsErrorView.updateView(with: error)
            skinsErrorView.isHidden = false
        }
    }
    
    // MARK: - Funcs for disable and allow user interaction when skin alert is opened or closed
    private func allowUserInteraction() {
        self.viewModel.currentSkin = nil
        self.skinsRegisteredView.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
    
    private func disableUserInteraction() {
        self.skinsRegisteredView.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
    }

}

extension SkinsViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        
        navigationItem.title = "SKINS"
        
        createInitialView()
        createSkinsRegisteredView()
        createSkinAlertView()
        createSkinsErrorView()
        createSkinsNotRegisteredView()
        createActivityIndicator()
        
        updateLeftBarButtonItem()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createSkinsRegisteredView() {
        skinsRegisteredView = SkinsRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(skinsRegisteredView)
    }
    
    private func createSkinAlertView() {
        skinAlertView = SkinAlertView(frame: view.bounds, presentingVC: self)
    }
    
    private func createSkinsErrorView() {
        skinsErrorView = SkinsErrorView(frame: view.bounds, presentingVC: self)
        view.addSubview(skinsErrorView)
    }
    
    func createSkinsNotRegisteredView() {
        skinsNotRegisteredView = SkinsNotRegisteredView(frame: view.bounds, presentingVC: self)
        view.addSubview(skinsNotRegisteredView)
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
    }
    
    // MARK: - Func for updating button for choosing which skins to display
    func updateLeftBarButtonItem() {
        if skinsRegisteredView.isShowOwnedSkins {
            navigationItem.leftBarButtonItem = skinsRegisteredView.ownedSkinsButton
        } else {
            navigationItem.leftBarButtonItem = skinsRegisteredView.allSkinsButton
        }
    }
    
    // MARK: - Func for creating and displaying Skin Alert
    func showSkinAlert(for skin: Skin, in cell: SkinCell?) {
        
        disableUserInteraction()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.skinsRegisteredView.alpha = 0.6
        })
        
        skinAlertView.updateView(for: skin, in: cell, with: viewModel.balance)
        
        view.addSubview(skinAlertView)
        
        skinAlertView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinAlertView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            skinAlertView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            skinAlertView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            skinAlertView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    // MARK: - Func dismissing Skin Alert from view
    @objc func dismissSkinAlert() {
        
        allowUserInteraction()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.skinsRegisteredView.alpha = 1
                self.skinAlertView.removeFromSuperview()
            })
        }
    }
    
    // MARK: - Objc functions for buttons' actions
    @objc func showSpecificSkinsButtonTapped(_ sender: UIBarButtonItem) {
        skinsRegisteredView.isShowOwnedSkins.toggle()
        updateLeftBarButtonItem()
        skinsRegisteredView.updateView()
    }
    
    @objc func buyButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text, let skin = viewModel.currentSkin {
            if title == "Select" {
                viewModel.selectSkin(with: skin.id) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        self.viewModel.updateState()
                    } else {
                        NSLog("Cannot select skin for some reason")
                    }
                }
            } else if title.starts(with: "Buy") {
                viewModel.buySkin(with: skin.id) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        self.viewModel.updateState()
                    } else {
                        NSLog("Cannot buy skin for some reason")
                    }
                }
            }
        }
        allowUserInteraction()
    }
    
    @objc func reloadButtonTapped(_ sender: UIButton) {
        viewModel.updateState()
    }
}
