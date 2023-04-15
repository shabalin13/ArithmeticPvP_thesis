//
//  ProfileErrorView.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 18.03.2023.
//

import UIKit

class ProfileErrorView: UIView {

    var presentingVC: ProfileViewController!
    
    init(frame: CGRect, presentingVC: ProfileViewController) {
        super.init(frame: frame)
        self.presentingVC = presentingVC
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView(for error: Error) {
        
    }
}
