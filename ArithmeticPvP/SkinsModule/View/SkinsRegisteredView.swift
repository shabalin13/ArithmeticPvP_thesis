//
//  SkinsRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import UIKit

class BalanceView: UIView {
    
    var coinsImageView: UIImageView!
    var balanceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(balance: Int) {
        balanceLabel.text = "\(balance)"
    }
    
    private func initView() {
        createCoinsImageView()
        createBalanceLabel()
    }
    
    private func createCoinsImageView() {
        coinsImageView = UIImageView(image: Design.shared.coinsImage)
        self.addSubview(coinsImageView)
        
        coinsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coinsImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinsImageView.widthAnchor.constraint(equalTo: coinsImageView.heightAnchor, multiplier: 1),
            coinsImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func createBalanceLabel() {
        balanceLabel = UILabel()
        self.addSubview(balanceLabel)
        
        balanceLabel.textAlignment = .center
        balanceLabel.font = Design.shared.chillax(style: .medium, size: 16)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            balanceLabel.leadingAnchor.constraint(equalTo: coinsImageView.trailingAnchor, constant: 7),
            balanceLabel.topAnchor.constraint(equalTo: self.topAnchor),
            balanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            balanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

class BarButtonItem: UIButton {
    
    var presentingVC: SkinsViewController!
    
    init(frame: CGRect, image: UIImage, presentingVC: SkinsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        createButton(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(image: UIImage) {
        
        self.setImage(image, for: .normal)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.addTarget(presentingVC, action: #selector(presentingVC.showSpecificSkinsButtonTapped(_:)), for: .touchUpInside)
    }
}

class SkinsRegisteredView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SkinsViewController
    
    var skinsTableView: UITableView!
    var balanceView: BalanceView!
    
    var isShowOwnedSkins: Bool!
    var ownedSkinsButton: UIBarButtonItem!
    var allSkinsButton: UIBarButtonItem!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: SkinsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        self.setBackgroundImage()
        
        isShowOwnedSkins = false
        
        ownedSkinsButton = UIBarButtonItem(customView: BarButtonItem(frame: .zero, image: Design.shared.ownSkinsImage.withTintColor(.black, renderingMode: .alwaysOriginal), presentingVC: presentingVC))
        
        allSkinsButton = UIBarButtonItem(customView: BarButtonItem(frame: .zero, image: Design.shared.allSkinsImage.withTintColor(.black, renderingMode: .alwaysOriginal), presentingVC: presentingVC))
        
        createBalanceView()
        createTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView() {
        skinsTableView.reloadData()

        balanceView.updateView(balance: presentingVC.viewModel.balance)
        presentingVC.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceView)
        
        presentingVC.updateLeftBarButtonItem()
    }
    
    // MARK: - Initializing views
    func createBalanceView() {
        balanceView = BalanceView()
    }
    
    func createTableView() {
        skinsTableView = UITableView()
        addSubview(skinsTableView)
        
        skinsTableView.separatorColor = Design.shared.skinsCellTintColor
        skinsTableView.backgroundColor = .clear
        
        skinsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinsTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            skinsTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            skinsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            skinsTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        skinsTableView.register(SkinCell.self, forCellReuseIdentifier: "SkinCell")
        skinsTableView.dataSource = self
        skinsTableView.delegate = self
    }
}

extension SkinsRegisteredView: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - DataSource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowOwnedSkins {
            return presentingVC.viewModel.ownedSkins.count
        } else {
            return presentingVC.viewModel.skins.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = skinsTableView.dequeueReusableCell(withIdentifier: "SkinCell", for: indexPath)
        
        configureCell(cell, forSkinAt: indexPath)
        
        return cell
    }
    
    // MARK: - Func for configuring cell for the Skin
    func configureCell(_ cell: UITableViewCell, forSkinAt indexPath: IndexPath) {
        guard let cell = cell as? SkinCell else { return }
        
        let skin: Skin
        if isShowOwnedSkins {
            skin = presentingVC.viewModel.ownedSkins[indexPath.row]
        } else {
            skin = presentingVC.viewModel.skins[indexPath.row]
        }
        
        cell.name = skin.name
        
        if skin.isOwner {
            cell.price = nil
        } else {
            cell.price = skin.price
        }
        
        if skin.isSelected {
            skinsTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        cell.image = nil
        
        presentingVC.viewModel.getSkinImage(from: skin.imageURL) { [weak self] imageData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.skinsTableView.indexPath(for: cell),
                   currentIndexPath == indexPath {
                    ImageHelper.shared.getImageForSkinCell(data: imageData) { image in
                        DispatchQueue.main.async {
                            cell.image = image
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Func for selecting specific skin cell
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let skin: Skin
        if isShowOwnedSkins {
            skin = presentingVC.viewModel.ownedSkins[indexPath.row]
        } else {
            skin = presentingVC.viewModel.skins[indexPath.row]
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? SkinCell
        presentingVC.viewModel.currentSkin = skin
        presentingVC.showSkinAlert(for: skin, in: cell)
        
        return nil
    }
    
}
