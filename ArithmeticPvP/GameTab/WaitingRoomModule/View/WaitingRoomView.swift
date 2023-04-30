//
//  WaitingRoomView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 03.04.2023.
//

import UIKit

// MARK: - PlayerView Class
class PlayerView: UIView {
    
    // MARK: - Class Properties
    var playerSkinView: UIImageView!
    var playerUsernameLabel: UILabel!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Design.shared.waitingRoomPlayerViewColor
        self.layer.cornerRadius = 12
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for player: Player, withSkin image: UIImage?) {
        if let image = image {
            playerSkinView.image = image
        }
        
        playerUsernameLabel.text = player.username
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerSkinView.isHidden = true
        playerUsernameLabel.isHidden = true
        backgroundColor = .none
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerSkinView.isHidden = false
        playerUsernameLabel.isHidden = false
        backgroundColor = Design.shared.waitingRoomPlayerViewColor
    }
    
    
    // MARK: - Initializing views
    private func initViews() {
        createPlayerSkinView()
        createPlayerUsernameLabel()
    }
    
    private func createPlayerSkinView() {
        playerSkinView = UIImageView()
        self.addSubview(playerSkinView)
        
        playerSkinView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerSkinView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            playerSkinView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            playerSkinView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            playerSkinView.widthAnchor.constraint(equalTo: playerSkinView.heightAnchor, multiplier: 1)
        ])
    }
    
    private func createPlayerUsernameLabel() {
        playerUsernameLabel = UILabel()
        self.addSubview(playerUsernameLabel)
        
        playerUsernameLabel.textAlignment = .left
        playerUsernameLabel.numberOfLines = 2
        playerUsernameLabel.lineBreakMode = .byCharWrapping
        playerUsernameLabel.font = Design.shared.chillax(style: .medium, size: 22)
        playerUsernameLabel.textColor = Design.shared.waitingRoomUsernameColor
        
        playerUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerUsernameLabel.leadingAnchor.constraint(equalTo: playerSkinView.trailingAnchor, constant: 20),
            playerUsernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playerUsernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
}


// MARK: - ClockView Class
class ClockView: UIView {
    
    // MARK: - Class Properties
    var clockImageView: UIImageView!
    var timeLabel: UILabel!
    
    var startGameTime: Date!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)

        initViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Func for updating time label
    func updateTimeLabel(with timeString: String) {
        timeLabel.text = timeString
    }
    
    // MARK: - Initializing views
    private func initViews() {
        createClockImageView()
        createTimeLabel()
    }
    
    private func createClockImageView() {
        clockImageView = UIImageView()
        self.addSubview(clockImageView)
        
        clockImageView.image = Design.shared.clockImage.withTintColor(Design.shared.waitingRoomClockImageTintColor)
        
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clockImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clockImageView.widthAnchor.constraint(equalTo: clockImageView.heightAnchor, multiplier: 1),
            clockImageView.widthAnchor.constraint(equalToConstant: 50),
            clockImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20)
        ])
    }
    
    private func createTimeLabel() {
        timeLabel = UILabel()
        self.addSubview(timeLabel)
        
        timeLabel.textAlignment = .center
        timeLabel.font = Design.shared.chillax(style: .medium, size: 30)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 10),
        ])
    }
    
}


// MARK: - WaitingRoomView Class
class WaitingRoomView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: WaitingRoomViewController
    
    var player1View: PlayerView!
    var player2View: PlayerView!
    var player3View: PlayerView!
    var player4View: PlayerView!
    var playersArray: [PlayerView] = []
    
    var clockView: ClockView!
    var startGameTimer: Timer!
    
    var playersStackView: UIStackView!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: WaitingRoomViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for waitingRoomData: WaitingRoomData) {
        
        if (clockView.startGameTime != nil && waitingRoomData.startTime != clockView.startGameTime!) || clockView.startGameTime == nil {
            clockView.startGameTime = waitingRoomData.startTime
            self.startGameTimer?.invalidate()
            self.startGameTimer = Timer(fireAt: Date(), interval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
            RunLoop.main.add(startGameTimer, forMode: .common)
        }
        
        for playerID in 0..<waitingRoomData.players.count {
            playersArray[playerID].showView()
            playersArray[playerID].updateView(for: waitingRoomData.players[playerID], withSkin: nil)
            
            presentingVC.viewModel.getSkinImage(from: waitingRoomData.players[playerID].skin) { [weak self] imageData in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.playersArray[playerID].updateView(for: waitingRoomData.players[playerID],
                                                           withSkin: ImageHelper.shared.getImage(data: imageData))
                }
            }
        }
        
        for playerID in waitingRoomData.players.count..<4 {
            playersArray[playerID].hideView()
        }
    }
    
    // MARK: - Func for updating Clock time
    @objc func updateClock() {
        let timeRemaining = Int(round(self.clockView.startGameTime.timeIntervalSinceNow))
        if timeRemaining > 0 {
            let minutes = timeRemaining / 60
            let seconds = timeRemaining % 60
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            self.clockView.updateTimeLabel(with: timeString)
        } else {
            self.startGameTimer?.invalidate()
        }
    }
    
}

extension WaitingRoomView {
    
    // MARK: - Initializing views
    private func initViews() {
        
        createClockView()
        
        createPlayersStackView()
        
        for playerID in 1...4 {
            createPlayerView(playerID: playerID)
        }
    }
    
    private func createClockView() {
        clockView = ClockView()
        self.addSubview(clockView)
        
        clockView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clockView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            clockView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
    
    private func createPlayersStackView() {
        playersStackView = UIStackView()
        self.addSubview(playersStackView)
        
        playersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playersStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            playersStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            playersStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            playersStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        playersStackView.axis = .vertical
        playersStackView.spacing = 10
        playersStackView.distribution = .equalSpacing
        playersStackView.alignment = .center
    }
    
    private func createPlayerView(playerID: Int) {
        
        if playerID == 1 {
            player1View = PlayerView()
            self.addSubview(player1View)
            updateCurrentPlayerViewConstraints(currentPlayerView: player1View)
            playersStackView.addArrangedSubview(player1View)
            playersArray.append(player1View)
        } else if playerID == 2 {
            player2View = PlayerView()
            self.addSubview(player2View)
            updateCurrentPlayerViewConstraints(currentPlayerView: player2View)
            playersStackView.addArrangedSubview(player2View)
            playersArray.append(player2View)
        } else if playerID == 3 {
            player3View = PlayerView()
            self.addSubview(player3View)
            updateCurrentPlayerViewConstraints(currentPlayerView: player3View)
            playersStackView.addArrangedSubview(player3View)
            playersArray.append(player3View)
        } else {
            player4View = PlayerView()
            self.addSubview(player4View)
            updateCurrentPlayerViewConstraints(currentPlayerView: player4View)
            playersStackView.addArrangedSubview(player4View)
            playersArray.append(player4View)
        }
        
    }
    
    private func updateCurrentPlayerViewConstraints(currentPlayerView: PlayerView) {
        
        currentPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentPlayerView.widthAnchor.constraint(equalTo: playersStackView.widthAnchor, multiplier: 0.8),
            currentPlayerView.heightAnchor.constraint(equalTo: playersStackView.heightAnchor, multiplier: 1/4, constant: -10),
        ])
    }
}
