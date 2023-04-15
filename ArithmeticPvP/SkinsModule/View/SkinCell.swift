//
//  SkinCell.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import UIKit

class SkinCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var priceLabel: UILabel!
    var skinImageView: UIImageView!
    
    var name: String? = nil {
        didSet {
            if oldValue != name {
                updateConfiguration()
            }
        }
    }
    
    var price: Double? = nil {
        didSet {
            if oldValue != price {
                updateConfiguration()
            }
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            if oldValue != image {
                updateConfiguration()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateConfiguration() {
        nameLabel.text = name
        
        if let price = price {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = nil
        }
        
        if let image = image {
            skinImageView.image = image
        } else {
            skinImageView.image = UIImage(systemName: "photo.on.rectangle")
        }
    }

}

extension SkinCell {
    
    func initView() {
        createSkinImageView()
        createNameLabel()
        createPriceLabel()
    }
    
    func createSkinImageView() {
        skinImageView = UIImageView()
        contentView.addSubview(skinImageView)
        
//        skinImageView.backgroundColor = .green
        
        skinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            skinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            skinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            skinImageView.widthAnchor.constraint(equalTo: skinImageView.heightAnchor, multiplier: 1)
        ])
        
    }
    
    func createNameLabel() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        
//        nameLabel.backgroundColor = .red
        
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: skinImageView.trailingAnchor, constant: 30),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
//            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    func createPriceLabel() {
        priceLabel = UILabel()
        contentView.addSubview(priceLabel)
        
//        priceLabel.backgroundColor = .blue
        
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        var temp = priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
//        temp.priority = .defaultHigh
        NSLayoutConstraint.activate([
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: contentView.safeAreaLayoutGuide.layoutFrame.width / 5),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 20),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
//            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
