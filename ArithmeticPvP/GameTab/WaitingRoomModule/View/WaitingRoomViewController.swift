//
//  WaitingRoomViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.03.2023.
//

import UIKit

class WaitingRoomViewController: UIViewController {
    
    // MARK: - Class Properties
    var viewModel: WaitingRoomViewModelProtocol
    
    var initialView: InitialView!
    var waitingRoomView: WaitingRoomView!
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Inits
    init(viewModel: WaitingRoomViewModelProtocol) {
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
        tabBarController?.tabBar.isHidden = true
        viewModel.getWaitingRoomInfo()
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
    
    // MARK: - Func for updating UI
    func updateUI() {
        
        activityIndicator.stopAnimating()
        initialView.isHidden = true
        waitingRoomView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("WaitingRoomViewController initial")
            initialView.isHidden = false
        case .loading:
            NSLog("WaitingRoomViewController loading")
            initialView.isHidden = false
            activityIndicator.startAnimating()
        case .data(let waitingRoomData):
            NSLog("WaitingRoomViewController data")
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped(_:)))
            waitingRoomView.updateView(for: waitingRoomData)
            waitingRoomView.isHidden = false
            NSLog("\(waitingRoomData)")
        case .error(let error):
            NSLog("WaitingRoomViewController error")
            initialView.isHidden = false
            NSLog("\(error)")
            self.waitingRoomView.startGameTimer?.invalidate()
            viewModel.exit(with: error)
        }
    }
    
}

extension WaitingRoomViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        navigationItem.title = "WAITING ROOM"
        navigationItem.hidesBackButton = true
        
        createInitialView()
        createWaitingRoomView()
        createActivityIndicator()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createWaitingRoomView() {
        waitingRoomView = WaitingRoomView(frame: view.bounds, presentingVC: self)
        view.addSubview(waitingRoomView)
    }
    
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
    }
    
    // MARK: - Objc functions for buttons' actions
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        self.waitingRoomView.startGameTimer?.invalidate()
        self.viewModel.exit(with: nil)
    }
}
