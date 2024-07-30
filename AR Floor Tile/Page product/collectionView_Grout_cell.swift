//
//  collectionView_Grout_cell.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 18/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class collectionView_Grout_cell: UICollectionViewCell {
    
    let Color_Grout: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.borderColor = UIColor.NautralBlack?.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetupTableViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetupTableViewCell(){
        self.backgroundColor = .clear
        
        self.addSubview(Color_Grout)
        
        Color_Grout.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Color_Grout.layer.cornerRadius = (self.frame.size.width / 2)
    }
    
}

