//
//  PostGameStatisticsView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 08.04.2023.
//

import UIKit

// MARK: - PlayerPlaceView Class
class PlayerPlaceView: UIView {
    
    // MARK: - Class Properties
    var playerPlaceImageView: UIImageView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createPlayerPlaceImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for place: Int) {
        if place == 1 {
            playerPlaceImageView.image = Design.shared.goldMedalImage
        } else if place == 2 {
            playerPlaceImageView.image = Design.shared.silverMedalImage
        } else if place == 3 {
            playerPlaceImageView.image = Design.shared.bronzeMedalImage
        }
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerPlaceImageView.isHidden = true
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerPlaceImageView.isHidden = false
    }
    
    // MARK: - Initilizing view
    private func createPlayerPlaceImageView() {
        playerPlaceImageView = UIImageView()
        self.addSubview(playerPlaceImageView)
        
        playerPlaceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerPlaceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerPlaceImageView.topAnchor.constraint(equalTo: self.topAnchor),
            playerPlaceImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerPlaceImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerPlaceImageView.heightAnchor.constraint(equalTo: playerPlaceImageView.widthAnchor, multiplier: 1)
        ])
    }
}


// MARK: - PlayerBottomView Class
class PlayerBottomView: UIView {
    
    // MARK: - Class Properties
    var playerBottomStackView: UIStackView!
    
    var playerBalanceStackView: UIStackView!
    var playerBalanceImageView: UIImageView!
    var playerBalanceLabel: UILabel!
    
    var playerRatingStackView: UIStackView!
    var playerRatingImageView: UIImageView!
    var playerRatingLabel: UILabel!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = Design.shared.playerViewBorderColor.resolvedColor(with: self.traitCollection).cgColor
        self.backgroundColor = Design.shared.playerViewBackgroundColor
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Trait Collection
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.layer.borderColor = Design.shared.playerViewBorderColor.cgColor
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for playerStatistics: PlayerPostGameStatistics) {
        
        if let balance = playerStatistics.balanceDiff {
            if balance > 0 {
                playerBalanceLabel.text = "\(balance)"
            } else if balance < 0 {
                playerBalanceLabel.text = "\(balance)"
            } else {
                playerBalanceLabel.text = "0"
            }
        } else {
            playerBalanceLabel.text = ""
        }
        
        if let ratingDiff = playerStatistics.ratingDiff {
            if ratingDiff > 0 {
                playerRatingLabel.text = "\(ratingDiff)"
            } else if ratingDiff < 0 {
                playerRatingLabel.text = "\(ratingDiff)"
            } else if ratingDiff == 0 {
                playerRatingLabel.text = "0"
            }
        } else {
            playerRatingLabel.text = ""
        }
        
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerBottomStackView.isHidden = true
        
        playerBalanceStackView.isHidden = true
        playerBalanceImageView.isHidden = true
        playerBalanceLabel.isHidden = true
        
        playerRatingStackView.isHidden = true
        playerRatingImageView.isHidden = true
        playerRatingLabel.isHidden = true
        
        backgroundColor = .none
        self.layer.borderWidth = 0
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerBottomStackView.isHidden = false
        
        playerBalanceStackView.isHidden = false
        playerBalanceImageView.isHidden = false
        playerBalanceLabel.isHidden = false
        
        playerRatingStackView.isHidden = false
        playerRatingImageView.isHidden = false
        playerRatingLabel.isHidden = false
        
        self.backgroundColor = Design.shared.playerViewBackgroundColor
        self.layer.borderWidth = 2
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        
        createPlayerBottomStackView()
        
        createPlayerBalanceStackView()
        createPlayerBalanceImageView()
        createPlayerBalanceLabel()
        
        createPlayerRatingStackView()
        createPlayerRatingImageView()
        createPlayerRatingLabel()
    }
    
    private func createPlayerBottomStackView() {
        playerBottomStackView = UIStackView()
        self.addSubview(playerBottomStackView)
        
        playerBottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerBottomStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            playerBottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            playerBottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            playerBottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        playerBottomStackView.axis = .horizontal
        playerBottomStackView.spacing = 10
        playerBottomStackView.distribution = .fillEqually
        playerBottomStackView.alignment = .center
    }
    
    private func createPlayerBalanceStackView() {
        playerBalanceStackView = UIStackView()
        self.addSubview(playerBalanceStackView)
        
        playerBottomStackView.addArrangedSubview(playerBalanceStackView)
        
        playerBalanceStackView.axis = .horizontal
        playerBalanceStackView.spacing = 10
        playerBalanceStackView.distribution = .fillEqually
        playerBalanceStackView.alignment = .center
    }
    
    private func createPlayerBalanceImageView() {
        
        playerBalanceImageView = UIImageView()
        self.addSubview(playerBalanceImageView)
        
        playerBalanceImageView.image = Design.shared.coinsImage
        
        playerBalanceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerBalanceImageView.heightAnchor.constraint(equalTo: playerBalanceImageView.widthAnchor, multiplier: 1)
        ])
        
        playerBalanceStackView.addArrangedSubview(playerBalanceImageView)
    }
    
    private func createPlayerBalanceLabel() {
        
        playerBalanceLabel = UILabel()
        self.addSubview(playerBalanceLabel)
        
        playerBalanceLabel.textAlignment = .left
        playerBalanceLabel.font = Design.shared.chillax(style: .medium, size: 20)
        playerBalanceLabel.textColor = Design.shared.playerBalanceAndRatingTextColor
        
        playerBalanceStackView.addArrangedSubview(playerBalanceLabel)
    }
    
    private func createPlayerRatingStackView() {
        playerRatingStackView = UIStackView()
        self.addSubview(playerRatingStackView)
        
        playerBottomStackView.addArrangedSubview(playerRatingStackView)
        
        playerRatingStackView.axis = .horizontal
        playerRatingStackView.spacing = 10
        playerRatingStackView.distribution = .fillEqually
        playerRatingStackView.alignment = .center
    }
    
    private func createPlayerRatingImageView() {
        
        playerRatingImageView = UIImageView()
        self.addSubview(playerRatingImageView)
        
        playerRatingImageView.image = Design.shared.ratingImage
        
        playerRatingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerRatingImageView.heightAnchor.constraint(equalTo: playerRatingImageView.widthAnchor, multiplier: 1)
        ])
        
        playerRatingStackView.addArrangedSubview(playerRatingImageView)
    }
    
    private func createPlayerRatingLabel() {
        
        playerRatingLabel = UILabel()
        self.addSubview(playerRatingLabel)
        
        playerRatingLabel.textAlignment = .left
        playerRatingLabel.font = Design.shared.chillax(style: .medium, size: 20)
        playerRatingLabel.textColor = Design.shared.playerBalanceAndRatingTextColor
        
        playerRatingStackView.addArrangedSubview(playerRatingLabel)
    }
}


// MARK: - PlayerUpperView Class
class PlayerUpperView: UIView {
    
    // MARK: - Class Properties
    var playerSkinView: UIImageView!
    var playerUsernameLabel: UILabel!
    var playerPlaceView: PlayerPlaceView!
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = Design.shared.playerViewBorderColor.resolvedColor(with: self.traitCollection).cgColor
        self.backgroundColor = Design.shared.playerViewBackgroundColor
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Trait Collection
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.layer.borderColor = Design.shared.playerViewBorderColor.cgColor
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for playerStatistics: PlayerPostGameStatistics, withSkin image: UIImage?) {
        if let image = image {
            playerSkinView.image = image
        }
        
        playerUsernameLabel.text = playerStatistics.username
        
        playerPlaceView.updateView(for: playerStatistics.place)
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerSkinView.isHidden = true
        playerUsernameLabel.isHidden = true
        playerPlaceView.hideView()
        self.backgroundColor = .none
        self.layer.borderWidth = 0
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerSkinView.isHidden = false
        playerUsernameLabel.isHidden = false
        playerPlaceView.showView()
        self.backgroundColor = Design.shared.playerViewBackgroundColor
        self.layer.borderWidth = 2
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createPlayerSkinView()
        createPlayerUsernameLabel()
        createPlayerPlaceView()
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
        playerUsernameLabel.font = Design.shared.chillax(style: .regular, size: 22)
        playerUsernameLabel.textColor = Design.shared.playerUsernameTextColor
        
        playerUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerUsernameLabel.leadingAnchor.constraint(equalTo: playerSkinView.trailingAnchor, constant: 20),
            playerUsernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            playerUsernameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func createPlayerPlaceView() {
        playerPlaceView = PlayerPlaceView()
        self.addSubview(playerPlaceView)
        
        playerPlaceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerPlaceView.leadingAnchor.constraint(equalTo: playerUsernameLabel.trailingAnchor, constant: 10),
            playerPlaceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            playerPlaceView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            playerPlaceView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}


// MARK: - PlayerStatisticsView Class
class PlayerStatisticsView: UIView {
    
    // MARK: - Class Properties
    var playerUpperView: PlayerUpperView!
    var playerBottomView: PlayerBottomView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for playerStatistics: PlayerPostGameStatistics, withSkin image: UIImage?) {
        playerUpperView.updateView(for: playerStatistics, withSkin: image)
        playerBottomView.updateView(for: playerStatistics)
    }
    
    // MARK: - Func for hiding view
    func hideView() {
        playerUpperView.hideView()
        playerBottomView.hideView()
    }
    
    // MARK: - Func for showing view
    func showView() {
        playerUpperView.showView()
        playerBottomView.showView()
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createPlayerUpperView()
        createPlayerBottomView()
    }
    
    private func createPlayerUpperView() {
        playerUpperView = PlayerUpperView()
        self.addSubview(playerUpperView)
        
        playerUpperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerUpperView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerUpperView.topAnchor.constraint(equalTo: self.topAnchor),
            playerUpperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createPlayerBottomView() {
        playerBottomView = PlayerBottomView()
        self.addSubview(playerBottomView)
        
        playerBottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerBottomView.leadingAnchor.constraint(equalTo: playerUpperView.playerSkinView.trailingAnchor, constant: 20),
            playerBottomView.topAnchor.constraint(equalTo: self.centerYAnchor),
            playerBottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            playerBottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerUpperView.bottomAnchor.constraint(equalTo: playerBottomView.centerYAnchor)
        ])
        
    }
}


// MARK: - PostGameStatisticsView Class
class PostGameStatisticsView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: PostGameStatisticsViewController
    
    var playerStatistics1View: PlayerStatisticsView!
    var playerStatistics2View: PlayerStatisticsView!
    var playerStatistics3View: PlayerStatisticsView!
    var playerStatistics4View: PlayerStatisticsView!
    var playersArray: [PlayerStatisticsView] = []
    
    var playersStatisticsStackView: UIStackView!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: PostGameStatisticsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for postGameStatisticsData: PostGameStatisticsData) {
        
        for playerID in 0..<postGameStatisticsData.postGameStatistics.statistics.count {
            playersArray[playerID].showView()
            playersArray[playerID].updateView(for: postGameStatisticsData.postGameStatistics.statistics[playerID], withSkin: nil)
            
            presentingVC.viewModel.getSkinImage(from: postGameStatisticsData.postGameStatistics.statistics[playerID].skin) { [weak self] imageData in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.playersArray[playerID].updateView(for: postGameStatisticsData.postGameStatistics.statistics[playerID],
                                                           withSkin: ImageHelper.shared.getImage(data: imageData))
                }
            }
        }
        
        for playerID in postGameStatisticsData.postGameStatistics.statistics.count..<4 {
            playersArray[playerID].hideView()
        }
    }
    
}

extension PostGameStatisticsView {
    
    // MARK: - Initializing views
    private func initViews() {
        
        createPlayersStackView()
        
        for playerID in 1...4 {
            createPlayerView(playerID: playerID)
        }
    }
    
    private func createPlayersStackView() {
        playersStatisticsStackView = UIStackView()
        self.addSubview(playersStatisticsStackView)
        
        playersStatisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playersStatisticsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            playersStatisticsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            playersStatisticsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playersStatisticsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        playersStatisticsStackView.axis = .vertical
        playersStatisticsStackView.spacing = 20
        playersStatisticsStackView.distribution = .fillEqually
        playersStatisticsStackView.alignment = .fill
    }
    
    private func createPlayerView(playerID: Int) {
        
        if playerID == 1 {
            playerStatistics1View = PlayerStatisticsView()
            self.addSubview(playerStatistics1View)
            updateCurrentPlayerViewConstraints(currentPlayerView: playerStatistics1View)
            playersStatisticsStackView.addArrangedSubview(playerStatistics1View)
            playersArray.append(playerStatistics1View)
        } else if playerID == 2 {
            playerStatistics2View = PlayerStatisticsView()
            self.addSubview(playerStatistics2View)
            updateCurrentPlayerViewConstraints(currentPlayerView: playerStatistics2View)
            playersStatisticsStackView.addArrangedSubview(playerStatistics2View)
            playersArray.append(playerStatistics2View)
        } else if playerID == 3 {
            playerStatistics3View = PlayerStatisticsView()
            self.addSubview(playerStatistics3View)
            updateCurrentPlayerViewConstraints(currentPlayerView: playerStatistics3View)
            playersStatisticsStackView.addArrangedSubview(playerStatistics3View)
            playersArray.append(playerStatistics3View)
        } else {
            playerStatistics4View = PlayerStatisticsView()
            self.addSubview(playerStatistics4View)
            updateCurrentPlayerViewConstraints(currentPlayerView: playerStatistics4View)
            playersStatisticsStackView.addArrangedSubview(playerStatistics4View)
            playersArray.append(playerStatistics4View)
        }
        
    }
    
    private func updateCurrentPlayerViewConstraints(currentPlayerView: PlayerStatisticsView) {
        currentPlayerView.translatesAutoresizingMaskIntoConstraints = false
    }
}
