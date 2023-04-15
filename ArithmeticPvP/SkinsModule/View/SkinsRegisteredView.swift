//
//  SkinsRegisteredView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import UIKit

class SkinsRegisteredView: UIView {
    
    // MARK: - Class Properties
    var presentingVC: SkinsViewController
    
    var skinsTableView: UITableView!
    var balanceLabel: UILabel!
    
    var isShowOwnedSkins: Bool!
    var ownedSkinsButton: UIBarButtonItem!
    var allSkinsButton: UIBarButtonItem!
    
    // MARK: - Inits
    init(frame: CGRect, presentingVC: SkinsViewController) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        
        isShowOwnedSkins = false
        ownedSkinsButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: presentingVC, action: #selector(presentingVC.showSpecificSkinsButtonTapped(_:)))
        allSkinsButton = UIBarButtonItem(image: UIImage(systemName: "circle"), style: .plain, target: presentingVC, action: #selector(presentingVC.showSpecificSkinsButtonTapped(_:)))
        
        backgroundColor = .white
        
        createBalanceLabel()
        createTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func for updating UI with specific data
    func updateView() {
        skinsTableView.reloadData()
        
        balanceLabel.text = "$\(presentingVC.viewModel.balance)"
        presentingVC.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.balanceLabel)
        presentingVC.updateLeftBarButtonItem()
    }
    
    // MARK: - Initializing views
    func createBalanceLabel() {
        balanceLabel = UILabel()
        
        balanceLabel.textAlignment = .center
        balanceLabel.font = UIFont.systemFont(ofSize: 16)
        
    }
    
    func createTableView() {
        skinsTableView = UITableView()
        addSubview(skinsTableView)
        
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
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let currentIndexPath = self.skinsTableView.indexPath(for: cell),
                   currentIndexPath == indexPath {
                    cell.image = UIImage(data: imageData)
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
