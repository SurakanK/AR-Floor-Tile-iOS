//
//  Image_Detail_Page.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 14/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Photos
import GoogleMobileAds
import FittedSheets
import JJFloatingActionButton

class Image_Detail_Page: UIViewController {
    
    var product_RemoveAds = SKProduct()
    static var DataCenter_ProductCopy = Detial_Product(Product_Image: #imageLiteral(resourceName: "Logo_AR_Floor_Tile"), Product_Name: "", Product_Price: 0, Product_Size_W: 0, Product_Size_H: 0, Product_Area: 0, Product_Dimension_L: 0, Product_Dimension_W: 0, Product_Spare: 0, Product_TotalPrice: 0, Index_TypeDimension: 0, Index_Spare: 0)
    
    // Element Image capture--------------------------------
    
    //Sheet Calculate
    static var SheetCalculate = SheetViewController()
    
    // State Save Image
    var State_SaveImage : Bool = false {
        didSet{
            self.Control_AlertSaveImage(State: self.State_SaveImage)
        }
    }
    
    var Image_capture : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "asasas")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    // Element menu button--------------------------------
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
    
    let Btn_NoAds: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.SecondaryColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "at"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom:7, right: 7)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(NoAds_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Btn_Contact: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.SecondaryColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "order"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(Contact_Button_Clicked), for: .touchUpInside)
        return button
    }()

    // Tool List Button
    lazy var Btn_ToolList : JJFloatingActionButton = {
        let button = JJFloatingActionButton()
        
        // Setup Item of Button List
        button.addItem(title: "Save Image", image: #imageLiteral(resourceName: "save").withRenderingMode(.alwaysTemplate)) { (item) in
            self.Save_Button_Clicked()
        }
        button.addItem(title: "Share Image", image: #imageLiteral(resourceName: "share").withRenderingMode(.alwaysTemplate)) { (item) in
            self.Share_Button_Clicked()
        }
        button.addItem(title: "Calculate Price", image: #imageLiteral(resourceName: "calculator").withRenderingMode(.alwaysTemplate)) { (item) in
            self.Control_ViewCalculate()
        }
        
        // Setup Button Style
        button.handleSingleActionDirectly = false
        //button.buttonDiameter = 50
        button.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        button.buttonImage = #imageLiteral(resourceName: "setup").withRenderingMode(.alwaysTemplate)
        button.buttonColor = UIColor.SecondaryColor!
        button.buttonImageColor = .white
        button.buttonImageSize = CGSize(width: 23, height: 23)
        
        // Setup Button
        button.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate))
        // Create New Animation (Not Have in Library)
        let animation = JJItemAnimationConfiguration()
        animation.itemLayout = JJItemLayout { items, actionButton in
            var previousItem: JJActionItem?
            for item in items {
                let previousView = previousItem ?? actionButton
                //let isFirstItem = (previousItem == nil)
                let spacing = CGFloat(8)
                item.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: spacing).isActive = true
                item.circleView.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor).isActive = true
                previousItem = item
            }
        }
        animation.closedState = .horizontalOffset()
        button.itemAnimationConfiguration = animation
        
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        // Setup Style of Item Button
        button.itemSizeRatio = 1
        button.configureDefaultItem { item in
            item.titlePosition = .leading
    
            item.titleLabel.font = UIFont.Subtitle1
            item.titleLabel.textColor = .white
            item.buttonColor = UIColor.SecondaryColor!
            item.buttonImageColor = .white
            item.imageSize = CGSize(width: 24, height: 24)
            

            item.layer.shadowOffset = CGSize(width: 3, height: 3)
            item.layer.shadowRadius = 5
            item.layer.shadowOpacity = 0.2
        }
        
        button.display(inViewController: self)
        
        return button
    }()
    
    //Element Discription-------------------------------------
    let watermark_Image: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Logo_AR_Floor_Tile5")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.alpha = 0.25
        return image
    }()
    
    // Element View Detial Product
    let View_DetialPro : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PrimaryColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        view.alpha = 0
        return view
    }()
    
    let text_Product_Name: UILabel = {
        let label = UILabel()
        label.text = "GA-101"
        label.textColor = UIColor.NautralBlack
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.H3
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    let text_Area: UILabel = {
        let label = UILabel()
        label.text = "Area : 15 m2 (5 x 3 m)"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.Body2
        label.numberOfLines = 0
        return label
    }()

    
    let text_Baht: UILabel = {
        let label = UILabel()
        label.text = "TotalPrice : 15,000 Baht"
        label.textColor = UIColor.NautralBlack
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.Body2
        label.numberOfLines = 0
        return label
    }()
    
    // View Label Alert -----------------------
    var View_AlertProcess : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgbAlpha(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.alpha = 0
        view.layer.cornerRadius = 5
        return view
    }()
    // Label Alert Process AR
    var Lb_AlertProcess : UILabel = {
        let label = UILabel()
        label.text = "Scanning the area to be simulated"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: 2))
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    // --------------------------------------
    
    //Element Google Ads mob--------
    var Google_Ads_interstitial: GADInterstitial!
    var Google_Ads_banner: GADBannerView!
    //------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting_GoogleAds()
        setting_Element()
        // Check State Remove Ads
        if Present_Page.State_RemoveAds == false {
            // Btn No Ads
            Btn_NoAds.alpha = 1
        }
        else {
           // Btn No Ads Dis Appear
            Btn_NoAds.alpha = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setting_GoogleAds()
        
        // Check State Remove Ads
        if Present_Page.State_RemoveAds == false {
            // Btn No Ads
            Btn_NoAds.alpha = 1
        }
        else {
            // Btn No Ads Dis Appear
            Btn_NoAds.alpha = 0
            // Remove Ads
            Google_Ads_banner.removeFromSuperview()
        }

    }
    
    func setting_Element(){
        
        // set Element Image capture--------------------------------
        view.addSubview(Image_capture)
        
        Image_capture.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        ///Element Discription
    
        Image_capture.addSubview(watermark_Image)
        
        watermark_Image.anchorCenter(Image_capture.centerXAnchor, AxisY: Image_capture.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 150, heightConstant: 150)
        
        // Layout Product Detial Section
        Image_capture.addSubview(View_DetialPro)
        View_DetialPro.anchor(Image_capture.topAnchor, left: Image_capture.leftAnchor, bottom: nil, right: Image_capture.rightAnchor, topConstant: 14, leftConstant: 15, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        // Name Pro
        View_DetialPro.addSubview(text_Product_Name)
        text_Product_Name.anchor(View_DetialPro.topAnchor, left: View_DetialPro.leftAnchor, bottom: nil, right: View_DetialPro.rightAnchor, topConstant: 8, leftConstant: 14, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 0)
        
        // Area
        View_DetialPro.addSubview(text_Area)
        text_Area.anchor(text_Product_Name.bottomAnchor, left: text_Product_Name.leftAnchor, bottom: View_DetialPro.bottomAnchor, right: View_DetialPro.centerXAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 4, widthConstant: 0, heightConstant: 0)
        // Total Price
        View_DetialPro.addSubview(text_Baht)
        text_Baht.anchor(text_Area.topAnchor, left: View_DetialPro.centerXAnchor, bottom: text_Area.bottomAnchor, right: View_DetialPro.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 14, widthConstant: 0, heightConstant: 0)
        
        
        // Element menu button--------------------------------------
        view.addSubview(Btn_back)
        view.addSubview(Btn_NoAds)
        view.addSubview(Btn_Contact)
        view.addSubview(Btn_ToolList)
        
        Btn_ToolList.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 25, widthConstant: 48, heightConstant: 48)
        
        Btn_Contact.anchor(Btn_ToolList.topAnchor, left: nil, bottom: nil, right: Btn_ToolList.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 14, widthConstant: 48, heightConstant: 48)
        
        Btn_NoAds.anchor(Btn_ToolList.topAnchor, left: nil, bottom: nil, right: Btn_Contact.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 14, widthConstant: 48, heightConstant: 48)
        
        Btn_back.anchorCenter(nil, AxisY: Btn_ToolList.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Btn_back.anchor(nil, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
        // Element View Alert -------------------------------------
        view.addSubview(View_AlertProcess)
        View_AlertProcess.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: -200, widthConstant: 0, heightConstant: 0)
        // Label
        View_AlertProcess.addSubview(Lb_AlertProcess)
        Lb_AlertProcess.anchor(View_AlertProcess.topAnchor, left: View_AlertProcess.leftAnchor, bottom: View_AlertProcess.bottomAnchor, right: View_AlertProcess.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
            
    }
    
    func setting_GoogleAds(){
        
        ///Google Ads interstitial
        Google_Ads_interstitial = GADInterstitial(adUnitID: String.GADInterstitial)
        
        //ca-app-pub-8252673033863069/5907139120
        
        let request = GADRequest()
        Google_Ads_interstitial.load(request)
        Google_Ads_interstitial.delegate = self
        
        ///Google Ads banner
        Google_Ads_banner = GADBannerView(adSize: kGADAdSizeBanner)
        Google_Ads_banner.backgroundColor = UIColor.clear
        Google_Ads_banner.adUnitID = String.GADBannerID
        Google_Ads_banner.rootViewController = self
        Google_Ads_banner.load(GADRequest())
        
        view.addSubview(Google_Ads_banner)
        
        Google_Ads_banner.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Google_Ads_banner.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func Control_ViewCalculate(){
        
        // Size Height SheetView
        let viewController = Calculate_Page()
        viewController.viewDidLoad()
        viewController.View_Size.layoutIfNeeded()
        let HeightViewSheet = viewController.View_Size.frame.height
        
        //Setting SheetView
        let controller = Calculate_Page()
        Image_Detail_Page.SheetCalculate = SheetViewController(controller: controller, sizes: [SheetSize.fixed(HeightViewSheet)])
        Image_Detail_Page.SheetCalculate.overlayColor = .clear
        Image_Detail_Page.SheetCalculate.topCornersRadius = 24
        Image_Detail_Page.SheetCalculate.handleColor = .clear
        
        self.present(Image_Detail_Page.SheetCalculate, animated: true, completion: nil)
        
    }
    
    
    @objc func Contact_Button_Clicked(){
        let viewPresent = Contact_Threetouch()
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }
    
    @objc func back_Button_Clicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func Share_Button_Clicked(){
        
        // Set Data for Detial Image
        text_Product_Name.text = AR_Page.DataCenter_Product.Product_Name + " (\(String(AR_Page.DataCenter_Product.Product_Price).currencyFormatting()) ฿/m²)"
        text_Area.text = "Area: \(String(AR_Page.DataCenter_Product.Product_Area).currencyFormatting()) m² (+\(AR_Page.DataCenter_Product.Product_Spare)%)"
        text_Baht.text = "Total Price: \(String(AR_Page.DataCenter_Product.Product_TotalPrice).currencyFormatting()) ฿"
        
        View_DetialPro.alpha = 1
        
        let image = Image_capture.asImage()
        
        View_DetialPro.alpha = 0
                
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
    
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    func Save_Button_Clicked(){
        
        if Google_Ads_interstitial.isReady && Present_Page.State_RemoveAds == false {
            Google_Ads_interstitial.present(fromRootViewController: self)
        } else {
           SavePoto()
        }
    
    }
    
    func SavePoto() {
        
        // Set Data for Detial Image
        text_Product_Name.text = AR_Page.DataCenter_Product.Product_Name + " (\(String(AR_Page.DataCenter_Product.Product_Price).currencyFormatting()) ฿/m²)"
        text_Area.text = "Area: \(String(AR_Page.DataCenter_Product.Product_Area).currencyFormatting()) m² (+\(AR_Page.DataCenter_Product.Product_Spare)%)"
        text_Baht.text = "Total Price: \(String(AR_Page.DataCenter_Product.Product_TotalPrice).currencyFormatting()) ฿"
        
        View_DetialPro.alpha = 1
        // Get Alabum for Store Image Capture
        getAlbum(title: "AR Floor Tile") { (_) in}
        // Capture Screen AR
        let imageScreen = Image_capture.asImage()
        save(photo: imageScreen, toAlbum: "AR Floor Tile") { (State, error) in
            
            
        }
        
        
        self.View_DetialPro.alpha = 0
    }
    
    @objc func NoAds_Button_Clicked(){
        let viewPresent = RemoveAds_Detail()
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }
    
    
    // MARK: Save Image to Album
    func createAlbum(withTitle title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var placeholder: PHObjectPlaceholder?
            
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
                placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }, completionHandler: { (created, error) in
                var album: PHAssetCollection?
                if created {
                    let collectionFetchResult = placeholder.map { PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [$0.localIdentifier], options: nil) }
                    album = collectionFetchResult?.firstObject
                }
                
                completionHandler(album)
            })
        }
    }
    
    func getAlbum(title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", title)
            let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            if let album = collections.firstObject {
                completionHandler(album)
            } else {
                self?.createAlbum(withTitle: title, completionHandler: { (album) in
                    completionHandler(album)
                })
            }
        }
    }
    
    func save(photo: UIImage, toAlbum titled: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        getAlbum(title: titled) { (album) in
            DispatchQueue.global(qos: .background).async {
                PHPhotoLibrary.shared().performChanges({
                    let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: photo)
                    let assets = assetRequest.placeholderForCreatedAsset
                        .map { [$0] as NSArray } ?? NSArray()
                    let albumChangeRequest = album.flatMap { PHAssetCollectionChangeRequest(for: $0) }
                    albumChangeRequest?.addAssets(assets)
                }, completionHandler: { (success, error) in
                    
                    self.State_SaveImage = success
                    
                    completionHandler(success, error)
                })
            }
        }
    }
    
    // MARK: Func Control View Alert Save Image
    func Control_AlertSaveImage(State : Bool) {
        
        var TextAlert = "Save image Complete"
        if State == false {
            TextAlert = "Save image Incomplete"
        }
        // Set Text Alert
        DispatchQueue.main.async {
            self.Lb_AlertProcess.text = TextAlert
        
        
            // Set Animation Present ViewAlert
            // Open
            UIView.animate(withDuration: 0.5) {
                self.View_AlertProcess.alpha = 1
            }
            // Close
            UIView.animate(withDuration: 0.5, delay: 5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.View_AlertProcess.alpha = 0
            }, completion: nil)
        }
    }
    
    
}

extension Image_Detail_Page : GADInterstitialDelegate{

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        SavePoto()
    }
}

extension Image_Detail_Page : JJFloatingActionButtonDelegate {
    func floatingActionButtonWillOpen(_ button: JJFloatingActionButton) {
        print("Open")
    }
}
