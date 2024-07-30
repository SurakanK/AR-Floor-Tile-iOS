//
//  Calulate_Page.swift
//  AR Floor Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 20/9/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import ALRadioButtons


class Calculate_Page : UIViewController {
    
    // MARK: Parameter
    var Index_TypeDimension : Int = 0 {
        didSet{
            
            if Index_TypeDimension == 0 {
                // Change UI Fill Value Dimension (Area)
                Txt_Width.alpha = 0
                // Set Value
                Txt_Sqm2.placeholder = "Area(m²)"
                Txt_Sqm2.text = String(Image_Detail_Page.DataCenter_ProductCopy.Product_Area).currencyFormatting()

            }
            else if Index_TypeDimension == 1 {
                // Change UI Fill Value Dimension (LxW)
                Txt_Width.alpha = 1
                // Set Value
                Txt_Sqm2.placeholder = "L(m)"
                Txt_Sqm2.text = String(Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_L).currencyFormatting()
                Txt_Width.text = String(Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_W).currencyFormatting()
            }
            
        }
    }
    
    // Value Spare
    var PercentSpare : [Int] = [5, 10, 15, 0]

    // MARK: Element
    // View Size
    var View_Size : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // View Slide
    var View_Slide : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AccentColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    // Label Header Calculate
    var Lb_HCalculate : UILabel = {
        let label = UILabel()
        label.text = "Calculate Price"
        label.font = UIFont.H2
        label.textColor = UIColor.NautralBlack
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.16
        label.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        return label
    }()
    
    // Image Product
    var Im_Pro : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "GA-7").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    // Label Name Pro
    var Lb_NamePro : UILabel = {
        let label = UILabel()
        label.text = "GA-101"
        label.font = UIFont.H3
        label.textColor = UIColor.NautralBlack
        return label
    }()
    // Label Price Per Unit
    var Lb_PricePro : UILabel = {
        let label = UILabel()
        label.text = "Price : ???? ฿/m²"
        label.font = UIFont.Body1
        label.textColor = UIColor.NautralBlack
        return label
    }()
    
    // Label Dimension Product
    var Lb_DimensionPro : UILabel = {
        let label = UILabel()
        label.text = "Dimension : ?? x ?? cm"
        label.font = UIFont.Body1
        label.textColor = UIColor.NautralBlack
        return label
    }()
    
    // Label Header Enter Diemention of Simulaiton
    var Lb_HDimension : UILabel = {
        let label = UILabel()
        label.text = "Enter your floor area"
        label.font = UIFont.H3
        label.textColor = UIColor.NautralBlack
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.16
        label.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        return label
    }()
    // Label Dimension
    var Lb_Dimension : UILabel = {
        let label = UILabel()
        label.text = "Floor Area"
        label.font = UIFont.FredokaOneRegular(size: 14)
        label.textColor = UIColor.NautralBlack
        return label
    }()
    // TextFiled Lenght or Sqm2
    lazy var Txt_Sqm2 : UITextField = {
        let txt = UITextField()
        txt.delegate = self
        // Set Border
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.SecondaryColor?.cgColor
        // Set CornerRadius
        txt.layer.cornerRadius = 16
        // Set BG Color
        txt.backgroundColor = UIColor.NautralWhite
        // Set Font
        txt.font = UIFont.Body1
        txt.textColor = UIColor.NautralBlack
        txt.textAlignment = .center
        // Set Keyboard Type
        txt.keyboardType = .decimalPad
        // Set PlaceHolder
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        txt.attributedPlaceholder = NSAttributedString(string: "Area(m²)", attributes: [NSAttributedString.Key.font : UIFont.Body1!, NSAttributedString.Key.paragraphStyle : centeredParagraphStyle])
        
        return txt
    }()
    // TextFiled Width
    lazy var Txt_Width : UITextField = {
        let txt = UITextField()
        txt.delegate = self
        txt.alpha = 0
        // Set Border
        txt.layer.borderWidth = 2
        txt.layer.borderColor = UIColor.SecondaryColor?.cgColor
        // Set CornerRadius
        txt.layer.cornerRadius = 16
        // Set BG Color
        txt.backgroundColor = UIColor.NautralWhite
        // Set Font
        txt.font = UIFont.Body1
        txt.textColor = UIColor.NautralBlack
        txt.textAlignment = .center
        // Set Keyboard Type
        txt.keyboardType = .decimalPad
        // Set PlaceHolder
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        txt.attributedPlaceholder = NSAttributedString(string: "W(m)", attributes: [NSAttributedString.Key.font : UIFont.Body1!, NSAttributedString.Key.paragraphStyle : centeredParagraphStyle])
        
        return txt
    }()
    
    // Segment Control for Select Type of Dimention
    var Seg_TypeDimension : BetterSegmentedControl = {
        let Seg = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Area", "L x W"], normalFont: UIFont.FredokaOneRegular(size: 14), normalTextColor: UIColor.SecondaryColor, selectedFont: UIFont.FredokaOneRegular(size: 14), selectedTextColor: UIColor.NautralWhite), index: 0, options: [.backgroundColor(UIColor.NautralWhite!), .indicatorViewBackgroundColor(UIColor.SecondaryColor!), .cornerRadius(10)])
        Seg.layer.borderColor = UIColor.SecondaryColor?.cgColor
        Seg.layer.borderWidth = 2
        
        Seg.layer.shadowColor = UIColor.black.cgColor
        Seg.layer.shadowRadius = 6
        Seg.layer.shadowOpacity = 0.16
        Seg.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        // Add Target
        Seg.addTarget(self, action: #selector(Event_ChooseTypeDimension), for: .valueChanged)
        
        return Seg
    }()
    
    // Label Header Select Percent of Sapre
    var Lb_HPercent_Spare : UILabel = {
        let label = UILabel()
        label.text = "How many percent of spare tile ?"
        label.numberOfLines = 2
        label.font = UIFont.H3
        label.textColor = UIColor.NautralBlack
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.16
        label.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        return label
    }()
    
    // Radio Button of Percent Spare
    var Radio_SpareTile : ALRadioGroup = {
        let radio = ALRadioGroup(items: [.init(title: "5%"),.init(title: "10%"),.init(title: "15%"),.init(title: "None")], style: .standard)
        radio.selectedIndex = 0
        radio.axis = .horizontal
        radio.cornerRadius = 0
        radio.spacing = 8
        radio.buttonBackgroundColor = .clear
        radio.separatorColor = .clear
        // Set Font
        radio.titleFont = UIFont.Body1!
        radio.tintColor = UIColor.NautralBlack
        // Set Ring
        radio.indicatorRingSize = 20
        radio.indicatorRingWidth = 2
        radio.indicatorCircleInset = 5
        
        // Unselect
        radio.unselectedTitleColor = UIColor.NautralBlack!
        radio.unselectedIndicatorColor = UIColor.SecondaryColor!
        
        // Select
        radio.selectedTitleColor = UIColor.NautralBlack!
        radio.selectedIndicatorColor = UIColor.SecondaryColor!
        
        // Add Target
        radio.addTarget(self, action: #selector(Event_ChoosePercentSpare), for: .valueChanged)
        
        return radio
    }()
    
    // Label Header Total Price
    var Lb_HTotalPrice : UILabel = {
        let label = UILabel()
        label.text = "Total Price"
        label.font = UIFont.H3
        label.textColor = UIColor.NautralBlack
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.16
        label.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        return label
    }()
    
    // Label total Price
    var Lb_TotalPrice : UILabel = {
        let label = UILabel()
        label.text = "0 ฿"
        label.font = UIFont.H2
        label.textColor = UIColor.AccentColor
        label.textAlignment = .center
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 6
        label.layer.shadowOpacity = 0.16
        label.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        return label
    }()
    
    // Button Calculate Price
    var Btn_Cal : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.AccentColor
        button.setTitle("SAVE TO DETAIL IMAGE", for: .normal)
        button.titleLabel?.font = UIFont.Button1
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.NautralWhite
        
        button.layer.cornerRadius = 24
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.16
        button.layer.shadowOffset = CGSize(width: 3,height: 3)
        
        // Add Target
        button.addTarget(self, action: #selector(Event_SaveDataCal), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Func Layout Element Page
    func Layout_Page(){
        
        // Set Background View
        view.backgroundColor = UIColor.PrimaryColor
        view.layer.masksToBounds = true
        
        // View Main
        view.addSubview(View_Size)
        View_Size.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Set View_Slide
        view.addSubview(View_Slide)
        View_Slide.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        View_Slide.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 18, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 10)
        
        // Set Label Header Calculate
        view.addSubview(Lb_HCalculate)
        Lb_HCalculate.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HCalculate.anchor(View_Slide.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        // Set Image Product
        view.addSubview(Im_Pro)
        Im_Pro.anchor(Lb_HCalculate.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 28, bottomConstant: 0, rightConstant: 0, widthConstant: 78, heightConstant: 78)
        // Set Label Name Pro
        view.addSubview(Lb_NamePro)
        Lb_NamePro.anchor(Im_Pro.topAnchor, left: Im_Pro.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 1, leftConstant: 16, bottomConstant: 0, rightConstant: 28, widthConstant: 0, heightConstant: 24)
        // Set Label Price Product
        view.addSubview(Lb_PricePro)
        Lb_PricePro.anchor(Lb_NamePro.bottomAnchor, left: Lb_NamePro.leftAnchor, bottom: nil, right: Lb_NamePro.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        // Set Label Dimension
        view.addSubview(Lb_DimensionPro)
        Lb_DimensionPro.anchor(Lb_PricePro.bottomAnchor, left: Lb_PricePro.leftAnchor, bottom: Im_Pro.bottomAnchor, right: Lb_PricePro.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 1, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        // Set Header Enter Dimension Simulation
        view.addSubview(Lb_HDimension)
        Lb_HDimension.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Lb_HDimension.anchor(Im_Pro.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 24)
        // Set Segment Control Select Type Dimension
        view.addSubview(Seg_TypeDimension)
        Seg_TypeDimension.anchor(Lb_HDimension.bottomAnchor, left:view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 28, bottomConstant: 0, rightConstant: 28, widthConstant: 0, heightConstant: 32)
        // Set Label Dimension
        view.addSubview(Lb_Dimension)
        Lb_Dimension.anchor(Seg_TypeDimension.bottomAnchor, left: Seg_TypeDimension.leftAnchor, bottom: nil, right: nil, topConstant: 24, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        // Set Label Area of Lenght
        view.addSubview(Txt_Sqm2)
        Txt_Sqm2.anchorCenter(nil, AxisY: Lb_Dimension.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Txt_Sqm2.anchor(nil, left: Lb_Dimension.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 14, bottomConstant: 0, rightConstant: 0, widthConstant: 112, heightConstant: 32)
        // Set Label Width
        view.addSubview(Txt_Width)
        Txt_Width.anchorCenter(nil, AxisY: Lb_Dimension.centerYAnchor, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Txt_Width.anchor(nil, left: Txt_Sqm2.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 112, heightConstant: 32)
        
        // Set Label Header Percent Spare
        view.addSubview(Lb_HPercent_Spare)
        Lb_HPercent_Spare.anchor(Txt_Sqm2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 28, bottomConstant: 0, rightConstant: 28, widthConstant: 0, heightConstant: 52)
        
        // Set Radio Button of Percent Spare
        view.addSubview(Radio_SpareTile)
        Radio_SpareTile.anchor(Lb_HPercent_Spare.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 28, bottomConstant: 0, rightConstant: 28, widthConstant: 0, heightConstant: 30)
        
        // Set Label Header Total Price
        view.addSubview(Lb_HTotalPrice)
        Lb_HTotalPrice.anchor(Radio_SpareTile.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 28, bottomConstant: 0, rightConstant: 28, widthConstant: 0, heightConstant: 24)
        // Set Label Total Price
        view.addSubview(Lb_TotalPrice)
        Lb_TotalPrice.anchor(Lb_HTotalPrice.bottomAnchor, left: Lb_HTotalPrice.leftAnchor, bottom: nil, right: Lb_HTotalPrice.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 42)
        // Set Button Cal
        view.addSubview(Btn_Cal)
        Btn_Cal.anchor(Lb_TotalPrice.bottomAnchor, left: view.leftAnchor, bottom: View_Size.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 16, leftConstant: 28, bottomConstant: 16, rightConstant: 28, widthConstant: 0, heightConstant: 48)
        
    }
    
    
    // MARK: Func Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Layout_Page()
        
        // Config Data Initail
        // Image Product
        Im_Pro.image = Present_Page.imageProduct[AR_Page.Index_ProductSelect!]
        // Name
        Lb_NamePro.text = Image_Detail_Page.DataCenter_ProductCopy.Product_Name
        // Price
        Lb_PricePro.text = "Price:  \(String(Image_Detail_Page.DataCenter_ProductCopy.Product_Price).currencyFormatting()) ฿/m²"
        // Dimension
        Lb_DimensionPro.text = "Dimension:  \(String(Image_Detail_Page.DataCenter_ProductCopy.Product_Size_W).currencyFormatting())x\(String(Image_Detail_Page.DataCenter_ProductCopy.Product_Size_H).currencyFormatting()) cm"
        // Segment Control Type Dimension Area
        Index_TypeDimension = Image_Detail_Page.DataCenter_ProductCopy.Index_TypeDimension
        Seg_TypeDimension.setIndex(Index_TypeDimension)
        // Radio Spare Tile
        Radio_SpareTile.selectedIndex = Image_Detail_Page.DataCenter_ProductCopy.Index_Spare
        // Total Price
        Lb_TotalPrice.text = String(Image_Detail_Page.DataCenter_ProductCopy.Product_TotalPrice).currencyFormatting() + " ฿"
        
        
        
    }
    // MARK: Func Handle of Button and Another Event
    // Func Segment Control Change Value
    @objc func Event_ChooseTypeDimension(){
        
        // Record Value Change
        Index_TypeDimension = Seg_TypeDimension.index
        // Record to Data Center Copy
        Image_Detail_Page.DataCenter_ProductCopy.Index_TypeDimension = Seg_TypeDimension.index
        // Cal Total Price of Product
        Cal_TotalPrice()
        
    }
    
    // Func Radiobutton Change Value
    @objc func Event_ChoosePercentSpare(){
        
        // Record Data to Data Center Copy
        Image_Detail_Page.DataCenter_ProductCopy.Index_Spare = Radio_SpareTile.selectedIndex
        Image_Detail_Page.DataCenter_ProductCopy.Product_Spare = PercentSpare[Radio_SpareTile.selectedIndex]
        // Cal Total Price of Product
        Cal_TotalPrice()

    }
    
    // Func Event Save Data Center Copy to Data Center Main
    @objc func Event_SaveDataCal(){
        
        // Save Data Center Copy To Data Center Main
        AR_Page.DataCenter_Product = Image_Detail_Page.DataCenter_ProductCopy
        
        // Close Section Cal
        Image_Detail_Page.SheetCalculate.closeSheet()
    }
    
    
    // MARK: Normal Func
    func Cal_TotalPrice(){
        
        let Price = Image_Detail_Page.DataCenter_ProductCopy.Product_Price
        var Area = Image_Detail_Page.DataCenter_ProductCopy.Product_Area
        if Index_TypeDimension == 1 {
            Area = Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_L * Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_W
            // Record to Data Center Copy
            Image_Detail_Page.DataCenter_ProductCopy.Product_Area = Area
        }
        let Spare = Double(Double(Image_Detail_Page.DataCenter_ProductCopy.Product_Spare) / 100) * Area

        let TotalPrice = Price * (Area + Spare)
        
        // Record Data Center And Show in Label TotalPrice
        Image_Detail_Page.DataCenter_ProductCopy.Product_TotalPrice = TotalPrice
        Lb_TotalPrice.text = String(TotalPrice).currencyFormatting() + " ฿"
    }
    
}

extension Calculate_Page : UITextFieldDelegate {
    // When Edit Text Complete
    func textFieldDidEndEditing(_ textField: UITextField){
        
        guard textField.text != "" else {return}
        
        var Area : Double = 0
        // Cal Total Price of Product
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        // Area
        if Index_TypeDimension == 0 {
            Area = Double(truncating: formatter.number(from: Txt_Sqm2.text!)!)
            // Record Data Area
            Image_Detail_Page.DataCenter_ProductCopy.Product_Area = Area
        }
        // LxW
        else if Index_TypeDimension == 1 {
            
            let L = Double(truncating: formatter.number(from: Txt_Sqm2.text!)!)
            let W = Double(truncating: formatter.number(from: Txt_Width.text!)!)
            
            print(L, W)
            Area = L * W
            // Record Data L, W, Area
            Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_L = L
            Image_Detail_Page.DataCenter_ProductCopy.Product_Dimension_W = W
            Image_Detail_Page.DataCenter_ProductCopy.Product_Area = Area
        }
        
        // Cal Total Price
        Cal_TotalPrice()
    }
}
