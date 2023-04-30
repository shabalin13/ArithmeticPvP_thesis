//
//  ProfileRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 13.03.2023.
//

import UIKit
import SVGKit


// MARK: - UserInfoView Class
class UserInfoView: UIView {
    
    // MARK: - Class Properties
    var eloLabel: UILabel!
    
    var usernameLabel: UILabel!
    
    var userSkinImageView: UIImageView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Design.shared.userInfoBackgroundColor
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for user: User?, with skinData: Data?) {
        if let user = user {
            
            let currentText = NSMutableAttributedString(string: "\(user.rating)",
                                                        attributes: [NSAttributedString.Key.font:
                                                                        Design.shared.chillax(style: .semibold, size: 60),
                                                                     NSAttributedString.Key.foregroundColor:
                                                                        Design.shared.userInfoEloLabelTextColor])
            currentText.append(NSAttributedString(string: "\nelo",
                                                  attributes: [NSAttributedString.Key.font:
                                                                Design.shared.chillax(style: .medium, size: 26),
                                                               NSAttributedString.Key.foregroundColor:
                                                                Design.shared.userInfoEloNameLabelTextColor]))
            eloLabel.attributedText = currentText
            
            usernameLabel.text = user.username
        }
        
        if let skinData = skinData {
            userSkinImageView.image = ImageHelper.shared.getImage(data: skinData)
        }
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createUserSkinImageView()
        createEloLabel()
        createUsernameLabel()
        
    }
    
    private func createUserSkinImageView() {
        userSkinImageView = UIImageView()
        self.addSubview(userSkinImageView)
        
        userSkinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userSkinImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            userSkinImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 80),
            userSkinImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            userSkinImageView.heightAnchor.constraint(equalTo: userSkinImageView.widthAnchor, multiplier: 1),
            userSkinImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2)
        ])
    }
    
    private func createEloLabel() {
        eloLabel = UILabel()
        self.addSubview(eloLabel)
        
        eloLabel.textAlignment = .center
        eloLabel.numberOfLines = 2
        
        eloLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eloLabel.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: 75),
            eloLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            eloLabel.trailingAnchor.constraint(equalTo: userSkinImageView.leadingAnchor, constant: -20)
        ])
    }
    
    private func createUsernameLabel() {
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        
        usernameLabel.textAlignment = .center
        usernameLabel.numberOfLines = 0
        usernameLabel.lineBreakMode = .byCharWrapping
        usernameLabel.font = Design.shared.chillax(style: .regular, size: 26)
        usernameLabel.textColor = Design.shared.userInfoUsernameLabelTextColor
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            usernameLabel.topAnchor.constraint(greaterThanOrEqualTo: eloLabel.bottomAnchor, constant: 40),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: userSkinImageView.leadingAnchor, constant: -15)
        ])
    }
}


// MARK: - StatView Class
class StatView: UIView {
    
    // MARK: - Class Properties
    var statStackView: UIStackView!
    var statLabel: UILabel!
    var statNameLabel: UILabel!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(statName: String, stat: String, withBorder: Bool) {
        statLabel.text = stat
        statNameLabel.text = statName
        
        if withBorder {
            let border = CALayer()
            border.backgroundColor = Design.shared.yellowColor.cgColor
            border.frame = CGRect(x: self.frame.width - 1, y: self.frame.height / 6, width: 1, height: 2 * self.frame.height / 3)
            self.layer.addSublayer(border)
        }
    }
    
    private func initViews() {
        createStatStackView()
        createStatLabel()
        createStatNameLabel()
    }
    
    private func createStatStackView() {
        statStackView = UIStackView()
        self.addSubview(statStackView)
        
        statStackView.axis = .vertical
        statStackView.spacing = 0
        statStackView.distribution = .fillEqually
        statStackView.alignment = .leading
        
        statStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            statStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            statStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
    
    private func createStatLabel() {
        statLabel = UILabel()
        self.addSubview(statLabel)
        
        statLabel.textAlignment = .left
        statLabel.font = Design.shared.chillax(style: .medium, size: 20)
        statLabel.textColor = Design.shared.statLabelTextColor
        
        statStackView.addArrangedSubview(statLabel)
    }
    
    private func createStatNameLabel() {
        statNameLabel = UILabel()
        self.addSubview(statNameLabel)
        
        statNameLabel.textAlignment = .left
        statNameLabel.font = Design.shared.chillax(style: .regular, size: 14)
        statNameLabel.textColor = .systemGray
        
        statStackView.addArrangedSubview(statNameLabel)
    }
}


// MARK: - StatisticsView Class
class StatisticsView: UIView, UIScrollViewDelegate {
    
    // MARK: - Class Properties
    var statisticsScrollView: UIScrollView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Design.shared.statisticsBackgroundColor
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for userStatistics: UserStatisticsArray?) {
        if let userStatistics = userStatistics {
            statisticsScrollView.subviews.forEach({ $0.removeFromSuperview() })
            statisticsScrollView.contentSize = CGSize(width: self.bounds.size.width * CGFloat(userStatistics.count) / 2.5, height: self.bounds.size.height)
            var userStatisticsFrame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width / 2.5, height: self.bounds.size.height)
            for (id, (userStatName, userStat)) in userStatistics.enumerated() {
                createUserStatView(userStatName: userStatName, userStat: userStat, frame: userStatisticsFrame, withBorder: id == userStatistics.count - 1 ? false: true)
                userStatisticsFrame.origin.x += self.bounds.size.width / 2.5
            }
        }
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createStatisticsScrollView()
    }
    
    private func createStatisticsScrollView() {
        statisticsScrollView = UIScrollView()
        self.addSubview(statisticsScrollView)
        
        statisticsScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statisticsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            statisticsScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            statisticsScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            statisticsScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func createUserStatView(userStatName: String, userStat: String, frame: CGRect, withBorder: Bool) {
        let userStatView = StatView(frame: frame)
        statisticsScrollView.addSubview(userStatView)
        userStatView.updateView(statName: userStatName, stat: userStat, withBorder: withBorder)
    }
    
}


// MARK: - ProfileRegisteredView Class
class ProfileRegisteredView: UIView {
    
    //MARK: - Class Properties
    var presentingVC: ProfileViewController
    
    var userInfoView: UserInfoView!
    var statisticsView: StatisticsView!
    
    init(frame: CGRect, presentingVC: ProfileViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(for profileData: ProfileData) {
        userInfoView.updateView(for: profileData.user, with: profileData.currentSkinData)
        statisticsView.updateView(for: profileData.userStatisticsArray)
    }
    
    private func initViews() {
        createUserInfoView()
        createStatisticsView()
    }
    
    private func createUserInfoView() {
        userInfoView = UserInfoView()
        self.addSubview(userInfoView)
        
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            userInfoView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            userInfoView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            userInfoView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 3/5)
        ])
    }
    
    private func createStatisticsView() {
        statisticsView = StatisticsView()
        self.addSubview(statisticsView)
        
        statisticsView.statisticsScrollView.delegate = presentingVC
        
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statisticsView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor),
            statisticsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            statisticsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            statisticsView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 1/5)
        ])
    }
}
