//
//  RemoveAds_Detail.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 27/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import StoreKit

class RemoveAds_Detail: UIViewController {
    
    // Parameter for Payment
    var myProduct: SKProduct?
    
    var Image_background : UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = #imageLiteral(resourceName: "White-Ceramic-Subway-Tile-Wallpaper-Mural-Room-825x535")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.alpha = 0.1
        return image
    }()
    
    let Btn_back: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.NautralBlack
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(back_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Title_Price: UILabel = {
        let label = UILabel()
        label.text = "Subscription"
        label.textColor = UIColor.AccentColor
        label.font = UIFont.FredokaOneRegular(size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let Btn_Payment: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.AccentColor
        button.layer.cornerRadius = 25
        button.setTitle("0.99 USD/ Month", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 20)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(Event_PaymentRemoveAds), for: .touchUpInside)
        return button
    }()
    
    let Btn_Restore: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 25
        button.setTitle("Restore Subscription", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 20)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(ButtonRestoreClicker), for: .touchUpInside)
        return button
    }()
    
    let view_main_RemoveAds: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    let title_RemoveAds: UILabel = {
        let label = UILabel()
        label.text = "Remove Ads"
        label.textColor = UIColor.SecondaryColor
        label.textAlignment = .center
        label.font = UIFont.FredokaOneRegular(size: 34)
        return label
    }()
    
    let image_RemoveAds: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Remove-Ads_Color")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let text_Discription_RemoveAds: UILabel = {
        let label = UILabel()
        label.text = """
            When you Upgade, all advertisements displayed in applications will be closed. Make you use the application more comfortably.
        """
        
        label.textColor = UIColor.black
        label.font = UIFont.LatoLight(size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PrimaryColor
        
        view.addSubview(Image_background)
          
        
        //set element background app
        Image_background.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
       
        view.addSubview(Btn_back)
        Btn_back.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 25, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
        view.addSubview(view_main_RemoveAds)
        view_main_RemoveAds.anchor(Btn_back.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        view_main_RemoveAds.addSubview(title_RemoveAds)
        view_main_RemoveAds.addSubview(image_RemoveAds)
        view_main_RemoveAds.addSubview(text_Discription_RemoveAds)
        
        title_RemoveAds.anchor(view_main_RemoveAds.topAnchor, left: view_main_RemoveAds.leftAnchor, bottom: nil, right: view_main_RemoveAds.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        image_RemoveAds.anchor(title_RemoveAds.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        image_RemoveAds.anchorCenter(view_main_RemoveAds.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 150, heightConstant: 150)
        
        text_Discription_RemoveAds.anchor(image_RemoveAds.bottomAnchor, left: view_main_RemoveAds.leftAnchor, bottom: view_main_RemoveAds.bottomAnchor, right: view_main_RemoveAds.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)

        view.addSubview(Title_Price)
        view.addSubview(Btn_Payment)
        view.addSubview(Btn_Restore)
        Title_Price.anchor(view_main_RemoveAds.bottomAnchor, left: view_main_RemoveAds.leftAnchor, bottom: nil, right: view_main_RemoveAds.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        Btn_Payment.anchor(Title_Price.bottomAnchor, left: view_main_RemoveAds.leftAnchor, bottom: nil, right: view_main_RemoveAds.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        Btn_Restore.anchor(Btn_Payment.bottomAnchor, left: view_main_RemoveAds.leftAnchor, bottom: nil, right: view_main_RemoveAds.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        // Config Payment Request for Remove Ads of User
        fetchProduct()
        setTextSubscription()

        SKPaymentQueue.default().add(self)
        
    }
    
    @objc func back_Button_Clicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // Func Fetch Product (Payment remove Ads)
    func fetchProduct() {
        
        let request = SKProductsRequest(productIdentifiers: ["ARF_099_1month"])
        request.delegate = self
        request.start()
        
    }
    
    // Event Button Buy remove Ads
    @objc func Event_PaymentRemoveAds(){
        
        guard let myProduct = myProduct else{return}
        
        if SKPaymentQueue.canMakePayments(){
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    @objc func ButtonRestoreClicker(){
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        self.Create_AlertMessage(Title: "subscription", Message: "restore success.")
    }
    
    func setTextSubscription(){
        if (Present_Page.State_RemoveAds) {
            Title_Price.text = "subscription success"
            Btn_Payment.isHidden = true
            Btn_Restore.isHidden = true
        } else {
            Title_Price.text = "Subscription"
            Btn_Payment.isHidden = false
            Btn_Restore.isHidden = false
        }
    }
    
    func Create_AlertMessage(Title : String!, Message : String!){
        
        view_Loading.isHidden = true
        Loader.stopAnimating()
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.FredokaOneRegular(size: 20), color: UIColor.ErrorColor)
        alert.setMessage(font: UIFont.LatoLight(size: 16), color: .black)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (acton) in
            view_Loading.isHidden = false
            Loader.startAnimating()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: extension
// extension Payment Request
extension RemoveAds_Detail : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if let product = response.products.first {
            myProduct = product
            print(product.productIdentifier)
            print(product.price)
            print(product.localizedTitle)
            print(product.localizedDescription)
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            
            case .purchasing:
                // no op
                print("purchasing")
                break
                
            case .purchased, .restored:
                // unlock their item
                UserDefaults.standard.set(true, forKey: "ads_removed")
                // Change State Remove Ads
                Present_Page.State_RemoveAds = true
                setTextSubscription()

                print("Success")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            case .failed, .deferred:
                print("failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            default:
                print("default")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
            }
        }
        
    }
    
    
    
    
}
