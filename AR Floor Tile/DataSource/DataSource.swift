//
//  DataSource.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 24/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

extension String {
    
    //Url Server
    static var Url_InsertUser = "https://7dgdzy0vx3.execute-api.ap-southeast-1.amazonaws.com/artile/insertuser"
    static var Url_GetCategory = "https://7dgdzy0vx3.execute-api.ap-southeast-1.amazonaws.com/artile/getcategory"
    static var Url_GetSubCategory = "https://7dgdzy0vx3.execute-api.ap-southeast-1.amazonaws.com/artile/getsubcategory"
    static var Url_GetProduct = "https://7dgdzy0vx3.execute-api.ap-southeast-1.amazonaws.com/artile/getproduct"
    static var Url_DownloadImage = "https://artiles.s3-ap-southeast-1.amazonaws.com/"
    static var Url_InsertHistory = "https://7dgdzy0vx3.execute-api.ap-southeast-1.amazonaws.com/artile/inserthistory"
    
    //id google ads mob
    static var GADBannerID = "ca-app-pub-8947871431601213/2651594826"
    static var GADInterstitial = "ca-app-pub-8947871431601213/5632981385"
    
    //User Token ID
    static var UserTokenID = ""
}

//Header JSON
struct Head_GetCategory {
    var id : String = "idCategory"
    var CatName : String = "CategoryName"
    var CatImage : String = "CategoryImage"
}

struct Head_GetSubCategory {
    var id : String = "idCategory"
    var CatName : String = "CategoryName"
    var CatImage : String = "CategoryImage"
}

struct Head_GetProduct {
    var CatName : String = "CategoryName"
    var CatsubName : String = "SubCategoryName"
    var idPro : String = "idProduct"
    var ProName : String = "ProductName"
    var ProDescription : String = "ProductDescription"
    var ProPrice : String = "ProductPrice"
    var ProImage : String = "ProductImage"
    var ProWidth : String = "ProductWidth"
    var ProHeight : String = "ProductHeight"
    var ProPattern : String = "ProductPattern"
    var SetStyle : String = "SetStyle"

}

