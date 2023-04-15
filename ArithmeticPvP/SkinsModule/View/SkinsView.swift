//
//  SkinsView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import UIKit

class SkinsView: UIView {
    
    var skinsTableView: UITableView!
    var presentingVC: SkinsViewController!
    
    var balanceLabel: UILabel!
    
    var isShowOwnedSkins: Bool!
    var ownedSkinsButton: UIBarButtonItem!
    var allSkinsButton: UIBarButtonItem!
    
    init(frame: CGRect, presentingVC: SkinsViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        
        isShowOwnedSkins = false
        ownedSkinsButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: presentingVC, action: #selector(presentingVC.showSpecificSkinsButtonTapped(_:)))
        allSkinsButton = UIBarButtonItem(image: UIImage(systemName: "circle"), style: .plain, target: presentingVC, action: #selector(presentingVC.showSpecificSkinsButtonTapped(_:)))
        
        backgroundColor = .white
//        backgroundColor = UIColor(patternImage: Design.shared.backgroundImage)
        
        createBalanceLabel()
        createTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView() {
        skinsTableView.reloadData()
        
        balanceLabel.text = "$\(presentingVC.viewModel.balance)"
        presentingVC.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.balanceLabel)
        presentingVC.updateLeftBarButtonItem()
    }
    
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
            skinsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            skinsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            skinsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            skinsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        skinsTableView.register(SkinCell.self, forCellReuseIdentifier: "SkinCell")
        skinsTableView.dataSource = self
        skinsTableView.delegate = self
    }
}

extension SkinsView: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let skin: Skin
        if isShowOwnedSkins {
            skin = presentingVC.viewModel.ownedSkins[indexPath.row]
        } else {
            skin = presentingVC.viewModel.skins[indexPath.row]
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? SkinCell
        presentingVC.showSkinAlert(for: skin, in: cell)
        
//        if skin.isOwner && !skin.isSelected {
//            presentingVC.viewModel.selectSkin(withID: skin.id) { [weak self] isSuccess in
//                guard let self = self else { return }
//                if isSuccess {
//                    self.presentingVC.viewModel.updateState()
//                } else {
//                    print("something went wrong")
//                }
//            }
//        }
        return nil
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let skin: Skin
//        if isShowOwnedSkins {
//            skin = presentingVC.viewModel.ownedSkins[indexPath.row]
//        } else {
//            skin = presentingVC.viewModel.skins[indexPath.row]
//        }
//
//        let cell = tableView.cellForRow(at: indexPath) as? SkinCell
//        presentingVC.showSkinAlert(for: skin, in: cell)
//    }
}
