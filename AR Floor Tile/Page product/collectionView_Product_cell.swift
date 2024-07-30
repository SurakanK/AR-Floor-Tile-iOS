//
//  collectionView_Product_cell.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 18/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import SkeletonView

class collectionView_Product_cell: UICollectionViewCell {
    
    
    //Element Category----------------
    let view_main_Category: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let view_main_Category_shadow: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.SecondaryColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    let title_Category: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let image_Category: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    //---------------------------------
    
    
    //Element Product------------------
    let view_main_Product: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let image_Product: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let text_ProductName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let text_ProductPrice: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    //-------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetupTableViewCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func SetupTableViewCell(){
        self.backgroundColor = .clear
                       
        //Set Element Category------------------------------
        self.addSubview(view_main_Category_shadow)
        self.addSubview(view_main_Category)
        
        view_main_Category_shadow.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view_main_Category.anchor(view_main_Category_shadow.topAnchor, left: view_main_Category_shadow.leftAnchor, bottom: view_main_Category_shadow.bottomAnchor, right: view_main_Category_shadow.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width, heightConstant: self.frame.height)
        
        view_main_Category.addSubview(title_Category)
        view_main_Category.addSubview(image_Category)

        title_Category.anchor(view_main_Category.topAnchor, left: view_main_Category.leftAnchor, bottom: image_Category.topAnchor, right: view_main_Category.rightAnchor, topConstant: 15, leftConstant: 20, bottomConstant: 5, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        let lefConstant = (self.frame.width / 5)
        let topConstant = (self.frame.width - lefConstant)
        image_Category.anchor(self.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: -topConstant, leftConstant: lefConstant, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        //------------------------------------------------
        
        //Set Element Product-----------------------------
        self.addSubview(view_main_Product)
        
        view_main_Product.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view_main_Product.addSubview(image_Product)
        view_main_Product.addSubview(text_ProductName)
        view_main_Product.addSubview(text_ProductPrice)

        let widthConstant = self.frame.width
        image_Product.anchor(view_main_Product.topAnchor, left: view_main_Product.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: widthConstant, heightConstant: widthConstant)
        
        text_ProductName.anchor(image_Product.bottomAnchor, left: view_main_Product.leftAnchor, bottom: nil, right: image_Product.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: widthConstant, heightConstant: 18)
        
        text_ProductPrice.anchor(text_ProductName.bottomAnchor, left: view_main_Product.leftAnchor, bottom: view_main_Product.bottomAnchor, right: view_main_Product.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: widthConstant, heightConstant: 16)
        //---------------------------------------------
        
        
        //Hidden Element stage-------------------------
        view_main_Category.isHidden = true
        view_main_Category_shadow.isHidden = true
        view_main_Product.isHidden = true

        //Set Skeleton load----------------------------
        image_Category.isSkeletonable = true
        image_Product.isSkeletonable = true

    }
    
}

