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
    var eloNameLabel: UILabel!
    
    var usernameLabel: UILabel!
    
    var userSkinImageView: UIImageView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 0.2)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView(for user: User?, with skinData: Data?) {
        if let user = user {
            eloLabel.text = "\(user.rating)"
            eloNameLabel.text = "elo"
            usernameLabel.text = user.username
        }
        
        if let skinData = skinData {
            userSkinImageView.image = UIImage(data: skinData)
        }
    }
    
    // MARK: - Initilizing views
    private func initViews() {
        createUserSkinImageView()
        createEloLabel()
        createEloNameLabel()
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
        eloLabel.font = UIFont.systemFont(ofSize: 50)
        
        eloLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eloLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75),
            eloLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            eloLabel.trailingAnchor.constraint(equalTo: userSkinImageView.leadingAnchor, constant: -40)
        ])
    }
    
    private func createEloNameLabel() {
        eloNameLabel = UILabel()
        self.addSubview(eloNameLabel)
        
        eloNameLabel.textAlignment = .center
        eloNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        eloNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eloNameLabel.topAnchor.constraint(equalTo: eloLabel.bottomAnchor, constant: 5),
            eloNameLabel.centerXAnchor.constraint(equalTo: eloLabel.centerXAnchor)
        ])
    }
    
    private func createUsernameLabel() {
        usernameLabel = UILabel()
        self.addSubview(usernameLabel)
        
        usernameLabel.textAlignment = .center
        usernameLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            usernameLabel.topAnchor.constraint(greaterThanOrEqualTo: eloNameLabel.bottomAnchor, constant: 40),
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
    func updateView(statName: String, stat: String) {
        statLabel.text = stat
        statNameLabel.text = statName
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
        statStackView.spacing = 10
        statStackView.distribution = .fillProportionally
        statStackView.alignment = .leading
        
        statStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            statStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            statStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
    
    private func createStatLabel() {
        statLabel = UILabel()
        self.addSubview(statLabel)
        
        statLabel.textAlignment = .left
        statLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        statStackView.addArrangedSubview(statLabel)
    }
    
    private func createStatNameLabel() {
        statNameLabel = UILabel()
        self.addSubview(statNameLabel)
        
        statNameLabel.textAlignment = .left
        statNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
        
        self.backgroundColor = .black.withAlphaComponent(0.2)
        
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
            for (userStatName, userStat) in userStatistics {
                createUserStatView(userStatName: userStatName, userStat: userStat, frame: userStatisticsFrame)
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
    
    private func createUserStatView(userStatName: String, userStat: String, frame: CGRect) {
        let userStatView = StatView(frame: frame)
        statisticsScrollView.addSubview(userStatView)
        userStatView.updateView(statName: userStatName, stat: userStat)
        
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
        
        self.backgroundColor = .white
        
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
