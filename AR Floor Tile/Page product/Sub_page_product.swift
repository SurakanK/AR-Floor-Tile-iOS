//
//  Sub_page_product.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 15/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Alamofire
import SkeletonView

class Sub_page_product: UIViewController {
            
    //collectionView---------------
    weak var collectionView_Grout : UICollectionView?
    weak var collectionView_Product : UICollectionView?
    //-----------------------------

    
    //Data Grout--------------------
    let color_Grout = ["#F6F1F2FF","#D2D1D2FF","#A3A19FFF","#696164FF","#1D191DFF","#CAB8B5FF",
                       "#E5DCC9FF","#DCD6CEFF","#D8C3A6FF","#E4BA69FF","#D3AF99FF","#BB9A9BFF",
                       "#D1A5A7FF","#C58B94FF","#CB8F77FF","#906144FF","#AF674CFF","#963A35FF",
                       "#7A5B53FF","#97A99FFF","#617261FF","#729680FF","#7A877BFF","#C3D8E7FF",
                       "#C5E4F7FF","#76B1BBFF","#3182BAFF","#7073ACFF","#656684FF","#C4A3D9FF"]
    
    //-----------------------------
    
    var Progress = 0
    var indexDownload = [Bool]()
    //------------------------------
    
    //Element Sub page Product-----
    let view_Handle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AccentColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let title_Grout_Color: UILabel = {
        let label = UILabel()
        label.text = "Grout Color"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.FredokaOneRegular(size: 20)
        label.numberOfLines = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    let title_Tile_List: UILabel = {
        let label = UILabel()
        label.text = "Tile List"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.FredokaOneRegular(size: 20)
        label.numberOfLines = 0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.2
        return label
    }()
    
    let text_Bread_Crum: UILabel = {
        let label = UILabel()
        label.text = "CATEGORY"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 10)
        label.numberOfLines = 1
        return label
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
    
    //--------------------------
    
    
    //size Element--------------
    
    let viewSize: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    //--------------------------
    
    
    //Element Google Ads mob----
    var Google_Ads_banner: GADBannerView!
    //--------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.PrimaryColor
        
        setting_Element()
        // Check Remove Ads
        if Present_Page.State_RemoveAds == false {
            setting_Element_GoogleAds()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //State one company product
        if Present_Page.DataCategory.count == 1 && Present_Page.StateView == "Category"{
            //Set State to SubCategory
            Present_Page.StateView = "SubCategory"
            //set id to first company
            let id = Present_Page.DataCategory[0][Head_GetCategory().id] as! Int
            Present_Page.SubCategoryid = id
        }
        
        //isHidden button back first category
        switch Present_Page.StateView {
        case "Category":
            
            //Download image
            guard Present_Page.DataCategory.count != Present_Page.imageCategory.count else {return}
            DownloadImage(DataSource: Present_Page.DataCategory, Head: Head_GetCategory().CatImage)
            
        case "SubCategory":
            if Present_Page.DataCategory.count != 1{
                Btn_back.isHidden = false
            }else{
                Btn_back.isHidden = true
            }
            
            //Download image
            let id = Present_Page.SubCategoryid
            guard Present_Page.DataSubCategory[id]!.count != Present_Page.imageSubCategory.count else {return}
            DownloadImage(DataSource: Present_Page.DataSubCategory[id]!, Head:  Head_GetSubCategory().CatImage)
            
        case "Product":
            Btn_back.isHidden = false
            
            //Download image
            let id = Present_Page.CategoryProid
            guard Present_Page.DataProduct[id]!.count != Present_Page.imageProduct.count else {return}
            DownloadImage(DataSource: Present_Page.DataProduct[id]!, Head: Head_GetProduct().ProImage)
        default:
            Btn_back.isHidden = true
        }
            
        //set BreadCrum
        UpdateBreadCrum()
        
       

    }
    
    func setting_Element(){
        
        //view main Element------------------
        view.addSubview(viewSize)
        viewSize.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        //-----------------------------------
        
        //set Element Sub page Product-------
        view.addSubview(view_Handle)
        
        view_Handle.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        view_Handle.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 18, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 10)
        
        view.addSubview(title_Grout_Color)
        title_Grout_Color.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        title_Grout_Color.anchor(view_Handle.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        //-----------------------------------
        
        
        //set Element collectionView Grout---
        collectionView_Grout_Setting()
        //-----------------------------------
        
        
        //set Element Sub page Product-------
        view.addSubview(Btn_back)
        view.addSubview(title_Tile_List)
        view.addSubview(text_Bread_Crum)
        
        Btn_back.anchor(collectionView_Grout?.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
        title_Tile_List.anchor(collectionView_Grout?.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: -5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        title_Tile_List.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        
        text_Bread_Crum.anchor(title_Tile_List.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        //-----------------------------------

        //set Element collectionView Product-
        collectionView_Product_Setting()
        //-----------------------------------
        

    }
    
    func setting_Element_GoogleAds(){
        
        Google_Ads_banner = GADBannerView(adSize: kGADAdSizeLargeBanner)
        Google_Ads_banner.backgroundColor = UIColor.PrimaryColor
        
        Google_Ads_banner.adUnitID = String.GADBannerID
        Google_Ads_banner.rootViewController = self
        Google_Ads_banner.delegate = self
        Google_Ads_banner.load(GADRequest())
    }
    
    
    func collectionView_Grout_Setting(){
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView_Grout = collection
        collectionView_Grout!.register(collectionView_Grout_cell.self, forCellWithReuseIdentifier: "CellGrout")
        collectionView_Grout!.backgroundColor = .systemGray6
        collectionView_Grout!.delegate = self
        collectionView_Grout!.dataSource = self
        collectionView_Grout!.showsHorizontalScrollIndicator = false
        collectionView_Grout!.backgroundColor = .clear
        
        view.addSubview(collectionView_Grout!)
        
        let height = (UIScreen.main.bounds.width - 120) / 6
        
        collectionView_Grout?.anchor(title_Grout_Color.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: -5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: height + 20)
    }
    
    func collectionView_Product_Setting(){
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView_Product = collection
        collectionView_Product!.register(collectionView_Product_cell.self, forCellWithReuseIdentifier: "CellProduct")
        collectionView_Product!.backgroundColor = .systemGray6
        collectionView_Product!.delegate = self
        collectionView_Product!.dataSource = self
        collectionView_Product!.showsHorizontalScrollIndicator = false
        collectionView_Product!.backgroundColor = .clear

        view.addSubview(collectionView_Product!)
        
        let height = ((UIScreen.main.bounds.width - 60) / 3) * 1.4
        
        collectionView_Product?.anchor(text_Bread_Crum.bottomAnchor, left: view.leftAnchor, bottom: viewSize.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 60, rightConstant: 0, widthConstant: 0, heightConstant: height + 25)
    }
    
    @objc func back_Button_Clicked(){

        switch Present_Page.StateView {
        case "SubCategory":
            
            //check one company product
            if Present_Page.DataCategory.count != 1{
                Present_Page.BreadCrum.removeLast()
                UpdateBreadCrum()
                    
                Present_Page.imageSubCategory.removeAll()
                Present_Page.StateView = "Category"
                collectionView_Product?.reloadData()
                
                Present_Page.scrollSubCategory = 0
                
                Btn_back.isHidden = true
            }
            
        case "Product":
            
            Present_Page.BreadCrum.removeLast()
            UpdateBreadCrum()
            
            Present_Page.imageProduct.removeAll()
            Present_Page.StateView = "SubCategory"
            collectionView_Product?.reloadData()
            
            Present_Page.scrollProduct = 0
            
            //check one company product
            if Present_Page.DataCategory.count == 1{
                Btn_back.isHidden = true
            }
            
        default: break
        }

    }

    func UpdateBreadCrum(){
        var text = ""
        for index in 0..<Present_Page.BreadCrum.count{
            text = text + Present_Page.BreadCrum[index]
        }
        text_Bread_Crum.text = text
    }
    

    //Download Image
    func DownloadImage(DataSource : [[String:Any]], Head : String){
        
        //check DataSource
        guard  DataSource.count != 0  else {return}
        
        for index in 0..<DataSource.count{
            
            let StateView = Present_Page.StateView
            let Path = DataSource[index][Head] as! String
            let Url =  URL(string: .Url_DownloadImage + Path)!
            
            //print(.Url_DownloadImage + Path)
            
            AF.download(Url).responseData { response in
                
                if let data = response.value {
                    
                    let image = UIImage(data: data)
                    let indexpath = IndexPath(row: index, section: 0)
                    
                    //save data in datastore
                    switch StateView {
                    case "Category":
                        //guard index out of range when click back button
                        guard Present_Page.imageCategory.count != 0 && image != nil else {return}
                        //save image to data set and reload cell
                        Present_Page.imageCategory[index] = image!
                        self.collectionView_Product?.reloadItems(at: [indexpath])
                    case "SubCategory":
                        //guard index out of range when click back button
                        guard Present_Page.imageSubCategory.count != 0 && image != nil else {return}
                        //save image to data set and reload cell
                        Present_Page.imageSubCategory[index] = image!
                        self.collectionView_Product?.reloadItems(at: [indexpath])
                    case "Product":
                        //guard index out of range when click back button
                        guard Present_Page.imageProduct.count != 0 && image != nil else {return}
                        //save image to data set and reload cell
                        Present_Page.imageProduct[index] = image!
                        self.collectionView_Product?.reloadItems(at: [indexpath])
                    default: break
                    }
                }
            }
        }

    }
    
    func InsertHistory(TokenID:String, idProduct:Int, Remark:String){
      
        let Header : HTTPHeaders = [.contentType("application/json")]
        let Url :String = .Url_InsertHistory
        let parameter = ["TokenID":TokenID, "idProduct":idProduct, "Remark":Remark] as [String : Any]
              
            AF.request(Url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
                  
                switch response.result{
                case .success(let value):
                              
                    let JSON = value as? [String : Any]
                  
                    if JSON!["results2"] != nil{
                        print("Insert History")
                    }else{
                        print("have already a user")
                    }
                              
                case .failure(_):
                    self.Create_AlertMessage(Title: "Server Crashes", Message: "Requesting data from the server has crashed. Please check the internet.")
                              
                    break
                }
            })
        
    }
    
    
    func Create_AlertMessage(Title : String!, Message : String!){
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Set Attribute Alert
        alert.setTitlet(font: UIFont.FredokaOneRegular(size: 20), color: UIColor.ErrorColor)
        alert.setMessage(font: UIFont.LatoLight(size: 16), color: .black)
        
        self.present(alert, animated: true, completion: nil)
    }


}

extension Sub_page_product : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionView_Grout{
            collectionView_Grout?.contentOffset.x = Present_Page.scrollGrout
            return color_Grout.count
        }else{
            //collectionView product
            switch Present_Page.StateView {
            case "Category":
                //Count Data in category
                let count = Present_Page.DataCategory.count
                //Set scrolling to position before
                collectionView_Product?.contentOffset.x = Present_Page.scrollCategory
                //Creat Data set image Category
                if Present_Page.imageCategory.count == 0{
                    Present_Page.imageCategory = Array(repeating: UIImage(), count: count)
                }
                            
                return count
                
            case "SubCategory":
                
                //Count Data in SubCategory
                let id = Present_Page.SubCategoryid
                let count = Present_Page.DataSubCategory[id]!.count
                //Set scrolling to position before
                collectionView_Product?.contentOffset.x = Present_Page.scrollSubCategory
                //Creat Data set image SubCategory
                if Present_Page.imageSubCategory.count == 0{
                    Present_Page.imageSubCategory = Array(repeating: UIImage(), count: count)
                }
               

                return count
                
            case "Product":
                
                //Count Data Product
                let id = Present_Page.CategoryProid
                let count = Present_Page.DataProduct[id]!.count
                //Set scrolling to position before
                collectionView_Product?.contentOffset.x = Present_Page.scrollProduct
                //Creat Data set image Product
                if Present_Page.imageProduct.count == 0{
                    Present_Page.imageProduct = Array(repeating: UIImage(), count: count)
                }
               
                return count
                
            default: return 0
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView_Grout{//collectionView Grout
            
            let cell = collectionView_Grout!.dequeueReusableCell(withReuseIdentifier: "CellGrout", for: indexPath) as! collectionView_Grout_cell
            
            cell.Color_Grout.backgroundColor = UIColor(hex: color_Grout[indexPath.row])
            
            // Add HightLight Cell
            if AR_Page.Index_GroutSelect == indexPath.row {
                cell.Color_Grout.layer.borderColor = UIColor.AccentColor?.cgColor
                cell.Color_Grout.layer.borderWidth = 3
            }else {
                cell.Color_Grout.layer.borderColor = UIColor.NautralBlack?.cgColor
                cell.Color_Grout.layer.borderWidth = 1
            }
        
            return cell
            
        }else{//collectionView product
            
            let cell = collectionView_Product!.dequeueReusableCell(withReuseIdentifier: "CellProduct", for: indexPath) as! collectionView_Product_cell
                       
            switch Present_Page.StateView {
            case "Category":
                
                //hidden view
                cell.view_main_Category_shadow.isHidden = false
                cell.view_main_Category.isHidden = false
                cell.view_main_Product.isHidden = true
                //Set text title Category
                cell.title_Category.text =  Present_Page.DataCategory[indexPath.row][Head_GetCategory().CatName] as? String
                
                //check image Category in data set
                if Present_Page.imageCategory[indexPath.row].size.width != 0{
                    //set image Category
                    cell.image_Category.image = Present_Page.imageCategory[indexPath.row]
                    //hide animation loading
                    cell.image_Category.hideSkeleton()
                }else{
                    //Show Animation loading
                    cell.image_Category.showAnimatedSkeleton(usingColor: UIColor.NautralBlack!)
                }
                
            case "SubCategory":
                
                //hidden view
                cell.view_main_Category_shadow.isHidden = false
                cell.view_main_Category.isHidden = false
                cell.view_main_Product.isHidden = true
                //id Select SubCategory
                let id = Present_Page.SubCategoryid
                //Set text title SubCategory
                cell.title_Category.text = Present_Page.DataSubCategory[id]![indexPath.row][Head_GetSubCategory().CatName] as? String
                
                //check image SubCategory in data set
                if Present_Page.imageSubCategory[indexPath.row].size.width != 0{
                    //set image SubCategory
                    cell.image_Category.image = Present_Page.imageSubCategory[indexPath.row]
                    //hide animation loading
                    cell.image_Category.hideSkeleton()
                }else{
                    //Show Animation loading
                    cell.image_Category.showAnimatedSkeleton(usingColor: UIColor.NautralBlack!)
                    
                }
                
            case "Product":
                
                //hidden view
                cell.view_main_Category_shadow.isHidden = true
                cell.view_main_Category.isHidden = true
                cell.view_main_Product.isHidden = false
                //id Select Product
                let id = Present_Page.CategoryProid
                //set text ProductName and ProductPrice
                let ProductName = Present_Page.DataProduct[id]![indexPath.row][Head_GetProduct().ProName] as? String
                let ProductPrice = Present_Page.DataProduct[id]![indexPath.row][Head_GetProduct().ProPrice] as? Int
                cell.text_ProductName.text = ProductName
                cell.text_ProductPrice.text = "฿ " + String(ProductPrice!) + "/m2"
                
                //check image Product in data set
                if Present_Page.imageProduct[indexPath.row].size.width != 0{
                    //set image Product
                    cell.image_Product.image = Present_Page.imageProduct[indexPath.row]
                    //hide animation loading
                    cell.image_Product.hideSkeleton()
                }else{
                    //Show Animation loading
                    cell.image_Product.showAnimatedSkeleton(usingColor: UIColor.SecondaryColor!)
                }
                               
            default: break
            }
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionView_Grout{//collectionView Grout
            
            // Update Hightlight Cell UnSelect
            if AR_Page.IndexPath_Previous != nil {
                if let cell = collectionView.cellForItem(at: AR_Page.IndexPath_Previous!) as? collectionView_Grout_cell{
                    
                    cell.Color_Grout.layer.borderColor = UIColor.NautralBlack?.cgColor
                    cell.Color_Grout.layer.borderWidth = 1
                }
            }
            
            let color = UIColor(hex: color_Grout[indexPath.row])
            
            // Record Color Grout
            AR_Page.Color_Grout = color ?? UIColor.white
            AR_Page.Index_GroutSelect = indexPath.row
            AR_Page.IndexPath_Previous = indexPath
            
            // Create IMage Tile
            NotificationCenter.default.post(name: NSNotification.Name("sheetControllerSelect_Product"), object: nil)
            
            //NotificationCenter.default.post(name: NSNotification.Name("sheetControllerSelect_Grout"), object: nil)
            // Reload Cell
            collectionView_Grout?.reloadItems(at: [indexPath])
            

        }else{
            //collectionView product
            switch Present_Page.StateView {
            case "Category":
                
                Present_Page.StateView = "SubCategory"
               
                let categoryName = Present_Page.DataCategory[indexPath.row][Head_GetCategory().CatName] as! String
                Present_Page.BreadCrum.append(">" + categoryName)
                
                let id = Present_Page.DataCategory[indexPath.row][Head_GetCategory().id] as! Int
                Present_Page.SubCategoryid = id
                
                UpdateBreadCrum()
                
                collectionView_Product!.reloadData()

                Btn_back.isHidden = false
                
                //Download image
                guard Present_Page.DataSubCategory[id]!.count != Present_Page.imageSubCategory.count else {return}
                DownloadImage(DataSource: Present_Page.DataSubCategory[id]!, Head:  Head_GetSubCategory().CatImage)
                
            case "SubCategory":
            
                Present_Page.StateView = "Product"
                
                let idSub = Present_Page.SubCategoryid
                let Data = Present_Page.DataSubCategory[idSub]!
                
                let categoryName = Data[indexPath.row][Head_GetSubCategory().CatName] as! String
                Present_Page.BreadCrum.append(">" + categoryName)
                
                Present_Page.CategoryProid = Data[indexPath.row][Head_GetSubCategory().id] as! Int
                
                UpdateBreadCrum()
                
                collectionView_Product!.reloadData()
                
                Btn_back.isHidden = false

                //Download image
                let id = Present_Page.CategoryProid
                guard Present_Page.DataProduct[Present_Page.CategoryProid]!.count != Present_Page.imageProduct.count else {return}
                DownloadImage(DataSource: Present_Page.DataProduct[id]!, Head: Head_GetProduct().ProImage)
                
            case "Product":
            
                let imageSelect = Present_Page.imageProduct[indexPath.row]
                guard imageSelect.size.width != 0 else {return}
                
                //print(imageSelect)
                AR_Page.Index_ProductSelect = indexPath.row
                
                //Data user select product
                let id = Present_Page.CategoryProid
                let ProductID = Present_Page.DataProduct[id]![indexPath.row][Head_GetProduct().idPro] as? Int
                
                //Insert History user
                InsertHistory(TokenID: String.UserTokenID, idProduct: ProductID!, Remark: "")
                
                // Create IMage Tile
                NotificationCenter.default.post(name: NSNotification.Name("sheetControllerSelect_Product"), object: nil)

            default: break
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollPos = scrollView.contentOffset.x

        if scrollView == collectionView_Grout{
            Present_Page.scrollGrout = scrollPos
        }else if scrollView == collectionView_Product{
            
            switch Present_Page.StateView {
            case "Category": Present_Page.scrollCategory = scrollPos
            case "SubCategory": Present_Page.scrollSubCategory = scrollPos
            case "Product": Present_Page.scrollProduct = scrollPos
            default: break
            }
            
        }
        
    }
    
}

extension Sub_page_product : UICollectionViewDelegateFlowLayout{
    
    //Set Size cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             
        if collectionView == collectionView_Grout{
            //collectionView Grout
            let itemWidth: CGFloat = (UIScreen.main.bounds.width - 140) / 6
            return CGSize(width: itemWidth, height: itemWidth)
            
        }else{
            //collectionView product
            let itemWidth: CGFloat = (UIScreen.main.bounds.width - 60) / 3
            let itemheight: CGFloat = itemWidth * 1.4
            return CGSize(width: itemWidth, height: itemheight)
            
        }
    }
         
    //Set space cell with wall collectionView
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
             
        if collectionView == collectionView_Grout{
            //collectionView Grout
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }else{
            //collectionView product
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
    }
    
    //Set space between cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == collectionView_Grout{
            //collectionView Grout
            return 20
        }else{
            //collectionView product
            return 20
        }

    }

}

extension Sub_page_product : GADBannerViewDelegate{
    
    // Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        view.addSubview(Google_Ads_banner)
               
        Google_Ads_banner.anchor(collectionView_Product?.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 50, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        Google_Ads_banner.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 320, heightConstant: 100)
        
        NotificationCenter.default.post(name: NSNotification.Name("viewProductReSize"), object: nil)
    }
    
}

