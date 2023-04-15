//
//  GameView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 06.04.2023.
//

import UIKit

// MARK: - PlayerProgressView Class
class PlayerProgressView: UIView {
    
    // MARK: - Class Properties
    var playerUsernameLabel: UILabel!
    var playerProgressView: UIProgressView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for playerProgress: PlayerProgress, tasksAmount: Int) {
        playerProgressView.setProgress((Float(playerProgress.progress) / Float(tasksAmount)), animated: true)
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerUsernameLabel.isHidden = true
        playerProgressView.isHidden = true
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerUsernameLabel.isHidden = false
        playerProgressView.isHidden = false
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createPlayerProgressView()
        createPlayerUsernameLabel()
    }
    
    private func createPlayerProgressView() {
        playerProgressView = UIProgressView()
        self.addSubview(playerProgressView)
        playerProgressView.setProgress(0, animated: false)
        
        playerProgressView.layer.cornerRadius = 10
        playerProgressView.clipsToBounds = true
        playerProgressView.layer.sublayers?[1].cornerRadius = 10
        playerProgressView.subviews[1].clipsToBounds = true
        
        
        playerProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerProgressView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/5),
            playerProgressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerProgressView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playerProgressView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func createPlayerUsernameLabel() {
        playerUsernameLabel = UILabel()
        self.addSubview(playerUsernameLabel)
        
        playerUsernameLabel.textAlignment = .left
        playerUsernameLabel.font = UIFont.systemFont(ofSize: 20)
        
        playerUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerUsernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerUsernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playerUsernameLabel.trailingAnchor.constraint(equalTo: playerProgressView.leadingAnchor, constant: -10),
        ])
    }
}


// MARK: - QuestionView Class
class QuestionView: UIView {
    
    // MARK: - Class Properties
    var questionLabel: UILabel!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for gameData: GameData) {
        
        var currentText: NSMutableAttributedString
        
        if let currentAnswer = gameData.currentAnswer {
            
            let currentQuestionComponents = gameData.currentQuestion.task.components(separatedBy: "<mask>")
            let (stringBefore, stringAfter) = (currentQuestionComponents[0], currentQuestionComponents[1])
            
            currentText = NSMutableAttributedString(string: stringBefore)
            
            for number in currentAnswer {
                if number == "-" {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = UIImage(systemName: "minus.square")
                    currentText.append(NSAttributedString(attachment: imageAttachment))
                } else {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = UIImage(systemName: "\(number).square")
                    currentText.append(NSAttributedString(attachment: imageAttachment))
                }
            }
            
            for _ in 0..<(gameData.currentQuestion.answer.count - currentAnswer.count) {
                let imageAttachment = NSTextAttachment()
                imageAttachment.image = UIImage(systemName: "square")
                currentText.append(NSAttributedString(attachment: imageAttachment))
            }
            
            currentText.append(NSAttributedString(string: stringAfter))
        } else {
            
            let currentQuestionComponents = gameData.currentQuestion.task.components(separatedBy: "<mask>")
            let (stringBefore, stringAfter) = (currentQuestionComponents[0], currentQuestionComponents[1])
            
            currentText = NSMutableAttributedString(string: stringBefore)
            
            for _ in 0..<gameData.currentQuestion.answer.count {
                let imageAttachment = NSTextAttachment()
                imageAttachment.image = UIImage(systemName: "square")
                currentText.append(NSAttributedString(attachment: imageAttachment))
            }
            
            currentText.append(NSAttributedString(string: stringAfter))
        }
        questionLabel.attributedText = currentText
    }
    
    // MARK: - Func for updating UI with specific data when answer is not correct
    func updateIncorrectView() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.15, initialSpringVelocity: 0.5) {
            self.questionLabel.center.x = self.questionLabel.center.x + 5
        } completion: { _ in
            self.questionLabel.center.x = self.questionLabel.center.x - 5
        }
    }
    
    // MARK: - Initilizing view
    private func initView() {
        createQuestionLabel()
    }
    
    private func createQuestionLabel() {
        questionLabel = UILabel()
        self.addSubview(questionLabel)
        
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 20)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}


// MARK: - KeyboardView Class
class KeyboardView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: GameViewController
    
    var keyboardButtons = [[UIButton]]()
    var keyboradTitles = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], ["-", "0", "Del"]]
    
    var keyboardStackView: UIStackView!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: GameViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initilizing view
    private func initView() {
        createKeybordButtons()
        createKeyboardStackView()
    }
    
    private func createKeybordButtons() {
        for keyboradRowTitles in keyboradTitles {
            var keyboradRow = [UIButton]()
            for keyboradTitle in keyboradRowTitles {
                let button = UIButton()
                self.addSubview(button)
                
                button.addTarget(presentingVC, action: #selector(presentingVC.keyboardButtonTapped(_:)), for: .touchUpInside)
                
                button.backgroundColor = .systemBlue
                button.layer.cornerRadius = 10
                button.setTitle(keyboradTitle, for: .normal)
                button.setTitleColor(.systemGray, for: .highlighted)
                
                keyboradRow.append(button)
            }
            keyboardButtons.append(keyboradRow)
        }
    }
    
    private func createKeyboardStackView() {
        keyboardStackView = UIStackView()
        self.addSubview(keyboardStackView)
        
        keyboardStackView.axis = .vertical
        keyboardStackView.spacing = 5
        keyboardStackView.distribution = .fillEqually
        keyboardStackView.alignment = .fill
        
        for keyboradRowButtons in keyboardButtons {
            
            let keyboradRowButtonsStackView = UIStackView()
            self.addSubview(keyboradRowButtonsStackView)
            
            keyboradRowButtonsStackView.axis = .horizontal
            keyboradRowButtonsStackView.spacing = 5
            keyboradRowButtonsStackView.distribution = .fillEqually
            keyboradRowButtonsStackView.alignment = .fill
            
            for keyboradButton in keyboradRowButtons {
                keyboradRowButtonsStackView.addArrangedSubview(keyboradButton)
            }
            
            keyboardStackView.addArrangedSubview(keyboradRowButtonsStackView)
        }
        
        keyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyboardStackView.topAnchor.constraint(equalTo: self.topAnchor),
            keyboardStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            keyboardStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            keyboardStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}


// MARK: - GameView Class
class GameView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: GameViewController
    
    var playersDict = [Int: PlayerProgressView]()
    var playersProgressStackView: UIStackView!
    
    var questionView: QuestionView!
    var keyboardView: KeyboardView!
    
    // MARK: - Inits
    init(frame: CGRect, players: [Player], presentingVC: GameViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        backgroundColor = .white
        
        initViews(players: players)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for gameData: GameData) {
        
        if let playersProgress = gameData.currentPlayersProgress {
            for player in playersProgress.players {
                playersDict[player.id]?.updateView(for: player, tasksAmount: playersProgress.tasksAmount)
            }
        }
        questionView.updateView(for: gameData)
    }
    
    // MARK: - Func for updating UI with specific data when answer is not correct
    func updateIncorrectView(for gameData: GameData) {
        updateView(for: gameData)
        questionView.updateIncorrectView()
    }
    
}

extension GameView {
    
    // MARK: - Initilizing views
    private func initViews(players: [Player]) {
        createKeyboardView()
        createQuestionView()
        
        createPlayersProgressStackView()
        
        for player in players {
            let playerProgressView = PlayerProgressView()
            self.addSubview(playerProgressView)
            playerProgressView.playerUsernameLabel.text = player.username
            playersProgressStackView.addArrangedSubview(playerProgressView)
            playersDict[player.id] = playerProgressView
        }
    }
    
    private func createKeyboardView() {
        keyboardView = KeyboardView(frame: self.bounds, presentingVC: self.presentingVC)
        self.addSubview(keyboardView)
        
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyboardView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 2/5),
            keyboardView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            keyboardView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            keyboardView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func createQuestionView() {
        questionView = QuestionView(frame: self.bounds)
        self.addSubview(questionView)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 1.5/5),
            questionView.bottomAnchor.constraint(equalTo: self.keyboardView.topAnchor, constant: -10),
            questionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func createPlayersProgressStackView() {
        playersProgressStackView = UIStackView()
        self.addSubview(playersProgressStackView)
        
        playersProgressStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playersProgressStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            playersProgressStackView.bottomAnchor.constraint(equalTo: self.questionView.topAnchor, constant: -10),
            playersProgressStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            playersProgressStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        playersProgressStackView.axis = .vertical
        playersProgressStackView.spacing = 5
        playersProgressStackView.distribution = .fillEqually
        playersProgressStackView.alignment = .fill
    }
    
}
