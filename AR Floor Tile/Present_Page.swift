//
//  Present_Page.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 14/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import Alamofire
import Network
import NVActivityIndicatorView

let view_main: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.alpha = 0
    return view
}()

var Image_background : UIImageView = {
    let image = UIImageView(frame: UIScreen.main.bounds)
    image.image = #imageLiteral(resourceName: "charles-deluvio-LyQi9DS7AEg-unsplash")
    image.alpha = 0.5
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    return image
}()

var Image_Logo : UIImageView = {
    let image = UIImageView(frame: UIScreen.main.bounds)
    image.image = #imageLiteral(resourceName: "Logo_AR_Floor_Tile5")
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    return image
}()

let title_Name: UILabel = {
    let label = UILabel()
    label.text = "AR Floor Tile"
    label.textColor = UIColor.NautralBlack
    label.font = UIFont.FredokaOneRegular(size: 34)
    label.numberOfLines = 0
    return label
}()

let view_center: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
}()

let view_Loading: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.AccentColor
    view.layer.cornerRadius = 10
    return view
}()

let text_Loading: UILabel = {
    let label = UILabel()
    label.text = "Loading"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.LatoLight(size: 26)
    label.numberOfLines = 0
    return label
}()

var Loader = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .white, padding: 10)


class Present_Page: UIViewController {
   
    //---------------------------------------------------------
    
    ///State show View in sub page product
    static var StateView : String = "Category"
    
    ///Data product
    static var DataCategory = [[String:Any]]()
    static var DataSubCategory = [Int:[[String:Any]]]()
    static var DataProduct = [Int:[[String:Any]]]()

    ///Data image product
    static var imageCategory = [UIImage]()
    static var imageSubCategory = [UIImage]()
    static var imageProduct = [UIImage]()
    
    ///Data id category
    static var SubCategoryid = 0
    static var CategoryProid = 0
    
    ///Data BreadCrum
    static var BreadCrum = ["CATEGORY"]

    ///Data scrollView in collectionview
    static var scrollGrout : CGFloat = 0
    static var scrollCategory : CGFloat = 0
    static var scrollSubCategory : CGFloat = 0
    static var scrollProduct : CGFloat = 0
    
    // State Remove Ads
    static var State_RemoveAds : Bool = false

    ///Progress Download Data
    var ProgressIndex = 0
    var Progressfinish = 0
    
    ///Check Network
    let monitor = NWPathMonitor()
    
    //---------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Check User Payment for Remove Ads ?
        if UserDefaults.standard.bool(forKey: "ads_removed"){
            Present_Page.State_RemoveAds = true
        }
        else {
            Present_Page.State_RemoveAds = false
        }
        
        setting_Element()
        
        view_main.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animate(withDuration: 1) {
            view_main.alpha = 1
        }
       
        //UIView.animate(withDuration: 1, delay: 2, options: .curveLinear, animations: {

        UIView.animate(withDuration: 0.25, delay: 1, options: .curveLinear, animations: {
            view_main.alpha = 0
        }) { (Sucess : Bool) in
            if Sucess == true{
                
                view_Loading.isHidden = false
                Loader.startAnimating()
                
                self.getCategory()
            }
        }
                

    }
    

    func setting_Element(){
        
        view.addSubview(view_main)
        view_main.addSubview(Image_background)
        view_main.addSubview(view_center)
        view_center.addSubview(Image_Logo)
        view_center.addSubview(title_Name)
        
        //set element background app--------------------------------
        Image_background.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set element logo and name app--------------------------------
        view_center.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        Image_Logo.anchorCenter(view_center.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Image_Logo.anchor(view_center.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 200)
        
        title_Name.anchor(Image_Logo.bottomAnchor, left: view_center.leftAnchor, bottom: view_center.bottomAnchor, right: view_center.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(view_Loading)
        view_Loading.anchorCenter(view.centerXAnchor, AxisY: view.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        view_Loading.addSubview(Loader)
        Loader.anchorCenter(view_Loading.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Loader.anchor(view_Loading.topAnchor, left: view_Loading.leftAnchor, bottom: nil, right: view_Loading.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 100, heightConstant: 100)
        
        view_Loading.addSubview(text_Loading)
        text_Loading.anchor(Loader.bottomAnchor, left: view_Loading.leftAnchor, bottom: view_Loading.bottomAnchor, right: view_Loading.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view_Loading.isHidden = true
    }
    
    func getCategory(){
        
        let Header : HTTPHeaders = [.contentType("application/json")]
        let Url : String = .Url_GetCategory
        
        AF.request(Url, method: .post, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    
                    let Data = JSON!["results"] as! [[String : Any]]
                    Present_Page.self.DataCategory = Data
                    
                    for index in 0..<Data.count{
                        let Categoryid = Data[index]["idCategory"] as! Int
                        self.getSubCategory(id: Categoryid)
                    }
                    
                }
                
            case .failure(_):
                
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
            
        })
    }
    
    func getSubCategory(id:Int){
        
        let Header : HTTPHeaders = [.contentType("application/json")]
        let Url : String = .Url_GetSubCategory
        let parameters = ["idCategory":id]
        
        AF.request(Url, method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    
                    let Data = JSON!["results"] as! [[String : Any]]
                    Present_Page.self.DataSubCategory[id] = Data
                    self.ProgressIndex = self.ProgressIndex + Data.count
                    
                    for index in 0..<Data.count{
                        let SubCategoryid = Data[index]["idCategory"] as! Int
                        self.getProduct(id: SubCategoryid)
                    }

                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
            
        })
    }
    
    func getProduct(id:Int){
        
        let Header : HTTPHeaders = [.contentType("application/json")]
        let Url : String = .Url_GetProduct
        let parameters = ["idCategory":id]
        
        AF.request(Url, method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
                
                if JSON!["results"] != nil{
                    
                    let Data = JSON!["results"] as! [[String : Any]]
                    Present_Page.self.DataProduct[id] = Data
                    self.Progressfinish = self.Progressfinish + 1
                    
                    if self.ProgressIndex == self.Progressfinish{
                        
                        Loader.stopAnimating()

                        view_Loading.isHidden = true
                        Loader.stopAnimating()

                        let viewPresent = Login_Page()
                        let navigation = UINavigationController(rootViewController: viewPresent)
                        navigation.isNavigationBarHidden = true
                        navigation.modalPresentationStyle = .fullScreen
                        self.present(navigation, animated: true, completion: nil)
                        
                        //test one company product
                        //Present_Page.DataCategory.removeLast()
                        
                    }
                    

                }
                
            case .failure(_):
                self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                
                break
            }
            
        })
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
