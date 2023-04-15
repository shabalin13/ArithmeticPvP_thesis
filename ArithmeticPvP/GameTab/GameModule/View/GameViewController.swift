//
//  GameViewController.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 30.03.2023.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Class Properties
    var viewModel: GameViewModelProtocol
    
    var initialView: InitialView!
    var gameView: GameView!
    
    // MARK: - Inits
    init(viewModel: GameViewModelProtocol) {
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
        gameView.isHidden = true
        
        switch viewModel.state.value {
        case .initial:
            NSLog("GameViewController initial")
            initialView.isHidden = false
        case .data(let gameData):
            NSLog("GameViewController data")
            gameView.updateView(for: gameData)
            gameView.isHidden = false
            NSLog("\(gameData)")
        case .incorrectData(let gameData):
            NSLog("GameViewController incorrectData")
            gameView.updateIncorrectView(for: gameData)
            gameView.isHidden = false
            NSLog("\(gameData)")
        case .error(let error):
            NSLog("GameViewController error")
            initialView.isHidden = false
            NSLog("\(error)")
            viewModel.exitGame(with: error)
        }
    }

}

extension GameViewController {
    
    // MARK: - Initializing views
    private func initViews() {
        
        navigationItem.title = "RATING GAME"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitButtonTapped(_:)))
        
        createInitialView()
        createGameView()
    }
    
    private func createInitialView() {
        initialView = InitialView(frame: view.bounds)
        view.addSubview(initialView)
    }
    
    private func createGameView() {
        gameView = GameView(frame: view.bounds, players: self.viewModel.players, presentingVC: self)
        view.addSubview(gameView)
    }
    
    private func displayAlert() {
        
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: "Exit the Game?", message: "Do you really want to leave the game?\nYou will be penalized!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            self.viewModel.exitGame(with: nil)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Objc functions for buttons' actions
    @objc func exitButtonTapped(_ sender: UIBarButtonItem) {
        displayAlert()
    }
    
    @objc func keyboardButtonTapped(_ sender: UIButton) {
        if let buttonTitle = sender.titleLabel?.text {
            viewModel.keyboardButtonTapped(buttonTitle: buttonTitle)
        }
    }
}
