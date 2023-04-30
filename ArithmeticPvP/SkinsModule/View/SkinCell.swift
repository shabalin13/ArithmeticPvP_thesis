//
//  SkinCell.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 23.03.2023.
//

import UIKit

class SkinCell: UITableViewCell {
    
    // MARK: - Class Properties
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
    
    var price: Int? = nil {
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
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.accessoryView =  UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(Design.shared.skinsCellTintColor, renderingMode: .alwaysOriginal))
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Design.shared.skinsSelectedCellColor
        self.selectedBackgroundView = backgroundView
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Func for updating configuration of cell
    func updateConfiguration() {
        nameLabel.text = name
        
        if let price = price {
            let currentText = NSMutableAttributedString(string: "\(price) ")
            let imageAttachment = NSTextAttachment()
            let size = ("\(price) " as NSString).boundingRect(with: priceLabel.bounds.size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: Design.shared.chillax(style: .regular, size: 14)], context: nil).size
            imageAttachment.bounds = CGRect(x: 0, y: (priceLabel.font.capHeight - size.height).rounded() / 2, width: size.height, height: size.height)
            imageAttachment.image = Design.shared.coinImage
            currentText.append(NSAttributedString(attachment: imageAttachment))
            
            priceLabel.attributedText = currentText
        } else {
            priceLabel.text = nil
        }
        
        if let image = image {
            skinImageView.image = image
        } else {
            skinImageView.image = nil
        }
    }

}

extension SkinCell {
    
    // MARK: - Initializing views
    func initView() {
        createSkinImageView()
        createNameLabel()
        createPriceLabel()
    }
    
    func createSkinImageView() {
        skinImageView = UIImageView()
        contentView.addSubview(skinImageView)
        
        skinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            skinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            skinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            skinImageView.widthAnchor.constraint(equalTo: skinImageView.heightAnchor, multiplier: 1)
        ])
        
    }
    
    func createNameLabel() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        
        nameLabel.textAlignment = .left
        nameLabel.font = Design.shared.chillax(style: .regular, size: 20)
        nameLabel.textColor = Design.shared.skinsUsernameColor
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: skinImageView.trailingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func createPriceLabel() {
        priceLabel = UILabel()
        contentView.addSubview(priceLabel)
        
        priceLabel.textAlignment = .right
        priceLabel.font = Design.shared.chillax(style: .regular, size: 14)
        nameLabel.textColor = Design.shared.skinsUsernameColor
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: contentView.safeAreaLayoutGuide.layoutFrame.width / 5),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 20),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
    }
}
