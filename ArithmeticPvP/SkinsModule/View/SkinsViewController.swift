//
//  SkinsViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 12.03.2023.
//

import UIKit

class SkinsViewController: UIViewController {
    
    var viewModel: SkinsViewModelProtocol
    
    var initialView: InitialView!
    var skinsView: SkinsView!
    var skinAlertView: SkinAlertView!
    var skinsErrorView: SkinsErrorView!
    var skinsNotRegisteredView: SkinsNotRegisteredView!
    var activityIndicator: UIActivityIndicatorView!
    
    init(viewModel: SkinsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        skinsView.isHidden = true
        skinsErrorView.isHidden = true
        skinsNotRegisteredView.isHidden = true
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        
        switch viewModel.state.value {
        case .initial:
            print("SkinsViewController initial")
            initialView.isHidden = false
        case .loading:
            print("SkinsViewController initial")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .registered:
            print("SkinsViewController registered")
            skinsView.updateView()
            skinsView.isHidden = false
        case .notRegistered:
            print("SkinsViewController not registered")
            skinsNotRegisteredView.isHidden = false
        case .error(let error):
            print("SkinsViewController error")
            skinsErrorView.updateView(with: error)
            skinsErrorView.isHidden = false
        }
    }

}

extension SkinsViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        
        navigationItem.title = "SKINS"
        
        createInitialView()
        createSkinsView()
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
    
    private func createSkinsView() {
        skinsView = SkinsView(frame: view.bounds, presentingVC: self)
        view.addSubview(skinsView)
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
    
    func updateLeftBarButtonItem() {
        if skinsView.isShowOwnedSkins {
            navigationItem.leftBarButtonItem = skinsView.ownedSkinsButton
        } else {
            navigationItem.leftBarButtonItem = skinsView.allSkinsButton
        }
    }
    
    @objc func showSpecificSkinsButtonTapped(_ sender: UIBarButtonItem) {
        skinsView.isShowOwnedSkins.toggle()
        updateLeftBarButtonItem()
        skinsView.updateView()
    }
    
    func showSkinAlert(for skin: Skin, in cell: SkinCell?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.skinsView.alpha = 0.6
        })
        
        view.addSubview(skinAlertView)
        
        skinAlertView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinAlertView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            skinAlertView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            skinAlertView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            skinAlertView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        skinAlertView.updateView(for: skin, in: cell, with: viewModel.balance)
    }
    
    @objc func dismissSkinAlert() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.skinsView.alpha = 1
                self.skinAlertView.removeFromSuperview()
            })
        }
    }
    
    @objc func buyButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            if title == "Select" {
                viewModel.selectSkin(with: skinAlertView.skin.id) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        self.viewModel.updateState()
                    } else {
                        print("something went wrong")
                    }
                }
            } else if title.starts(with: "Buy") {
                viewModel.buySkin(with: skinAlertView.skin.id) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        self.viewModel.updateState()
                    } else {
                        print("something went wrong")
                    }
                }
            }
        }
    }
    
    @objc func reloadButtonTapped(_ sender: UIButton) {
        viewModel.updateState()
    }
}
