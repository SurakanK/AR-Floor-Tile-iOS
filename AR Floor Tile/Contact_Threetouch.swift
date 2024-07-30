//
//  Contact_Threetouch.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 20/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

class Contact_Threetouch: UIViewController {
    
    var Image_background : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "math-yDq60_c-g2E-unsplash")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    //Element ScrollView Main---------------------------
    var ScrollView : UIScrollView = {
        let Scroll = UIScrollView()
        return Scroll
    }()
    
    // MARK: Element in view header
    let view_header: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.SecondaryColor?.withAlphaComponent(0.9)
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    var Image_Logo_Company : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "Logo-TheThreeTouch")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    let title_Company_Name: UILabel = {
        let label = UILabel()
        label.text = "TheThreeTouch \nAsia Pacific Co.,Ltd."
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.FredokaOneRegular(size: 20)
        label.numberOfLines = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    let Btn_back: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(back_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: Element in view sub header
    let view_Sub_header: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.PrimaryColor?.withAlphaComponent(0.9)
        return view
    }()
    
    //Element Contact --------------------------
    let title_Contact: UILabel = {
        let label = UILabel()
        label.text = "Contact"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 34)
        label.numberOfLines = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    let icon_location: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "map-location").withTintColor(UIColor.AccentColor!)
        return image
    }()
    
    let title_location: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let text_location: UILabel = {
        let label = UILabel()
        label.text = "56/23 Seri Thai Rd., Kannayao, Kannayao, Bangkok 10230 Thailand"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let icon_Mobile: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Phone-2").withTintColor(UIColor.AccentColor!)
        return image
    }()
    
    let title_Mobile: UILabel = {
        let label = UILabel()
        label.text = "Mobile"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let text_Mobile: UILabel = {
        let label = UILabel()
        label.text = "+662-3799065-67"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let icon_Email: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Email").withTintColor(UIColor.AccentColor!)
        return image
    }()
    
    let title_Email: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let text_Email: UILabel = {
        let label = UILabel()
        label.text = "treetouch@gmail.com"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let icon_Line: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Line").withTintColor(UIColor.AccentColor!)
        return image
    }()
    
    let title_Line: UILabel = {
        let label = UILabel()
        label.text = "Line"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let text_Line: UILabel = {
        let label = UILabel()
        label.text = "@thethreetouch"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    //Element Map--------------------------
    let image_Map: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Image-Map")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    let image_Map_shadow: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    //Element Follow-----------------------
    let title_Follow: UILabel = {
        let label = UILabel()
        label.text = "Follow on :"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let Btn_Follow_Line: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.LineColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "Line"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(openLine), for: .touchUpInside)
        return button
    }()
    
    let Btn_Follow_Facebook: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.FacebookColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .white
        
        setting_Element()

        //set event touch in image map
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openMap(tapGestureRecognizer:)))
        image_Map.isUserInteractionEnabled = true
        image_Map.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    @objc func openMap(tapGestureRecognizer: UITapGestureRecognizer){
       
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {// google map
            UIApplication.shared.open(URL(string:"comgooglemapsurl://maps.google.com/?q=@13.787323,100.6774031")!)
        } else {// apple map
            UIApplication.shared.open(URL(string: "http://maps.apple.com/?q=13.787323,100.6774031")!)
        }
        
    }
    
    @objc func openFacebook(){
        
        let fbUrl = URL(string:"fb://profile/450508941695241")!
        let fbUrlWeb = URL(string:"https://facebook.com/450508941695241")!
        
        if UIApplication.shared.canOpenURL(fbUrl) {// open in facebook app
            UIApplication.shared.open(fbUrl)
        } else {// open in safari
           UIApplication.shared.open(fbUrlWeb)
        }
    }
    
    @objc func openLine(){

        let LineUrl = URL(string:"https://line.me/ti/p/~@thethreetouch")!
        let LineDownloadApp = URL(string:"https://apps.apple.com/th/app/line/id443904275?l=th")!
        
        if UIApplication.shared.canOpenURL(URL(string: "line://")!) {// open line
            UIApplication.shared.open(LineUrl)
        } else {// open appstore Line download
           UIApplication.shared.open(LineDownloadApp)
        }
    }
   
    func setting_Element(){
        
        view.addSubview(Image_background)
         
        //set element background app
        Image_background.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        //Set Element ScrollView Main
        view.addSubview(ScrollView)
        ScrollView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
        ScrollView.contentOffset.x = 0
                 
        // MARK: set Element in view header
        ScrollView.addSubview(view_header)
        view_header.addSubview(Btn_back)
        view_header.addSubview(Image_Logo_Company)
        view_header.addSubview(title_Company_Name)

        view_header.anchor(ScrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: -500, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 340 + 500)
        
        Btn_back.anchor(nil, left: view_header.leftAnchor, bottom: Image_Logo_Company.topAnchor, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 15, rightConstant: 0, widthConstant: 25, heightConstant: 25)
         
        Image_Logo_Company.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 200, heightConstant: 200)
        Image_Logo_Company.anchor(nil, left: nil, bottom: title_Company_Name.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        title_Company_Name.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        title_Company_Name.anchor(nil, left: nil, bottom: view_header.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 30, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        // MARK: set Element in view sub header
        ScrollView.insertSubview(view_Sub_header, at: 0)
        
        view_Sub_header.anchor(view_header.bottomAnchor, left: view.leftAnchor, bottom: ScrollView.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -500, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set Element Contact------------------------------
        view_Sub_header.addSubview(title_Contact)
        view_Sub_header.addSubview(icon_location)
        view_Sub_header.addSubview(title_location)
        view_Sub_header.addSubview(text_location)
        view_Sub_header.addSubview(icon_Mobile)
        view_Sub_header.addSubview(title_Mobile)
        view_Sub_header.addSubview(text_Mobile)
        view_Sub_header.addSubview(icon_Email)
        view_Sub_header.addSubview(title_Email)
        view_Sub_header.addSubview(text_Email)
        view_Sub_header.addSubview(icon_Line)
        view_Sub_header.addSubview(title_Line)
        view_Sub_header.addSubview(text_Line)
         
        title_Contact.anchor(view_Sub_header.topAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: 35, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        icon_location.anchor(title_Contact.bottomAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
         
        title_location.anchor(icon_location.topAnchor, left: icon_location.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        text_location.anchor(title_location.bottomAnchor, left: title_location.leftAnchor, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 0)
         
        icon_Mobile.anchor(text_location.bottomAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
         
        title_Mobile.anchor(icon_Mobile.topAnchor, left: icon_location.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        text_Mobile.anchor(title_Mobile.bottomAnchor, left: title_location.leftAnchor, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 0)
         
        icon_Email.anchor(text_Mobile.bottomAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
         
        title_Email.anchor(icon_Email.topAnchor, left: icon_location.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        text_Email.anchor(title_Email.bottomAnchor, left: title_location.leftAnchor, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 0)
         
        icon_Line.anchor(text_Email.bottomAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 55, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
         
        title_Line.anchor(icon_Line.topAnchor, left: icon_location.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
         
        text_Line.anchor(title_Line.bottomAnchor, left: title_location.leftAnchor, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 55, widthConstant: 0, heightConstant: 0)
         
        //set Element Map--------------------------
        view_Sub_header.addSubview(image_Map_shadow)
        view_Sub_header.addSubview(image_Map)
         
        image_Map.anchor(text_Line.bottomAnchor, left: view_Sub_header.leftAnchor, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 30, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 130)
        
        image_Map_shadow.anchor(image_Map.topAnchor, left: image_Map.leftAnchor, bottom: image_Map.bottomAnchor, right: image_Map.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //set Element Follow-----------------------
        //view_Sub_header.addSubview(title_Follow)
        view_Sub_header.addSubview(Btn_Follow_Line)
        view_Sub_header.addSubview(Btn_Follow_Facebook)
        view_Sub_header.addSubview(title_Follow)

        Btn_Follow_Facebook.anchor(image_Map.bottomAnchor, left: nil, bottom: nil, right: view_Sub_header.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 50, heightConstant: 50)
         
        Btn_Follow_Line.anchor(image_Map.bottomAnchor, left: nil, bottom: view_Sub_header.bottomAnchor, right: Btn_Follow_Facebook.leftAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 20 + 500, rightConstant: 8, widthConstant: 50, heightConstant: 50)//view_Sub_header bottom Anchor

        title_Follow.anchorCenter(nil, AxisY: Btn_Follow_Line.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        title_Follow.anchor(nil, left: nil, bottom: nil, right: Btn_Follow_Line.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
         
        //ScrollView size height
        ScrollView.contentSize = view_Sub_header.bounds.size
    }
    
    @objc func back_Button_Clicked(){
        self.navigationController?.popViewController(animated: true)
        
    }

}
