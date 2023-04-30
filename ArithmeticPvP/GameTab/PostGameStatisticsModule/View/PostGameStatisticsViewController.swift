//
//  PostGameStatisticsViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import UIKit

class PostGameStatisticsViewController: UIViewController {
    
    // MARK: - Class Properties
    var viewModel: PostGameStatisticsViewModelProtocol
    
    var initialView: InitialView!
    var postGameStatisticsView: PostGameStatisticsView!
    
    // MARK: - Inits
    init(viewModel: PostGameStatisticsViewModelProtocol) {
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
        viewModel.update()
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
        
        initialView.isHidden = true
        postGameStatisticsView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("PostGameStatisticsViewController initial")
            initialView.isHidden = false
        case .data(let postGameStatisticsData):
            NSLog("PostGameStatisticsViewController data")
            postGameStatisticsView.updateView(for: postGameStatisticsData)
            postGameStatisticsView.isHidden = false
            NSLog("\(postGameStatisticsData)")
        case .error(let error):
            NSLog("PostGameStatisticsViewController error")
            initialView.isHidden = false
            NSLog("\(error)")
            viewModel.exit(with: error)
        }
    }
    
}

extension PostGameStatisticsViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        navigationItem.title = "POST-GAME STATISTICS"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = Design.shared.navigationTitleColor
        
        createInitialView()
        createPostGameStatisticsView()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createPostGameStatisticsView() {
        postGameStatisticsView = PostGameStatisticsView(frame: view.bounds, presentingVC: self)
        view.addSubview(postGameStatisticsView)
        postGameStatisticsView.isHidden = true
    }
    
    // MARK: - Objc function for Exit button action
    @objc func exitButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.exit(with: nil)
    }
}
