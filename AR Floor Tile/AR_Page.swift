//
//  AR_Page.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 14/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import FittedSheets
import FBSDKLoginKit
import GoogleSignIn
import GoogleMobileAds
import ARKit
import AVFoundation

class AR_Page: UIViewController, ARSessionDelegate {
   
    // Parameter AR Process
    // SceneView
    var Sceneview : ARSCNView = {
        let view = ARSCNView()
        return view
    }()
    // Coaching View for AR Process
    var CoachingOverlay = ARCoachingOverlayView()
    // Configuration AR Process
    var configuration = ARWorldTrackingConfiguration()
    // Position Y Plane Select
    var Position_PlaneSelect : CGFloat = 0
    // Area (Extent.x * Exteny.z) of PlaneAnchor
    var Area_PlaneAnchor : Float = 0
    // Text Alert Process AR
    var Text_AlertProcessAR : String = "Place the pointer on the plane you want to simulate."
    // Index of Product
    static var Index_ProductSelect : Int? = nil
    static var Index_GroutSelect : Int = 0
    // Update Cell Grout When Select Cell Grout
    static var IndexPath_Previous : IndexPath? = [0,0]
    // Color Grout
    static var Color_Grout : UIColor = UIColor.init(hex: "#F6F1F2FF") ?? UIColor.white
    // State Prepare AR
    var State_Prepare : Bool = true
    // State PLane Select
    var State_SelectPlane : Bool = true {
        didSet {
            
            // Set Text Alert Follow State Change
            if self.State_SelectPlane == true{
                self.Text_AlertProcessAR = "Place the pointer on the plane you want to simulate."
            }else {
                self.Text_AlertProcessAR = "Scanning the area to be simulated"
            }
            
        }
    }
    // State Plane Create
    var State_PlaneCreate : Bool = false
    // State Confirm
    var State_Confirm : Bool = false {
        didSet{
            
            if self.State_Confirm {
                
                // Change Icon Button Confirm to Icon Capture
                Btn_capture.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
                // Open Button Menu
                UIView.animate(withDuration: 0.5) {
                    self.Btn_Menu.alpha = 1
                }
                // Set Coaching Overlay AR Process Don't Auto
                CoachingOverlay.activatesAutomatically = false
                
                
            }else {
                
                // Change Icon Button Capture to Icon Confirm
                Btn_capture.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
                // Close Button Menu
                UIView.animate(withDuration: 0.5) {
                    self.Btn_Menu.alpha = 0
                }
                // Set Coaching Overlay AR Process Auto
                CoachingOverlay.activatesAutomatically = true
                
            }
            
        }
    }
    
    // Data Center Product
    static var DataCenter_Product = Detial_Product(Product_Image: #imageLiteral(resourceName: "Logo_AR_Floor_Tile"), Product_Name: "", Product_Price: 0, Product_Size_W: 0, Product_Size_H: 0, Product_Area: 0, Product_Dimension_L: 0, Product_Dimension_W: 0, Product_Spare: 0, Product_TotalPrice: 0, Index_TypeDimension: 0, Index_Spare: 0)
    
    // Func Config AR
    func Config_AR(){
        
        // Set Screen AR
        self.Sceneview.delegate = self
        self.Sceneview.session.delegate = self
        //self.Sceneview.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        
        // Config Plane Detection
        configuration.planeDetection = .horizontal
        
        // Set Coaching Overlay View
        CoachingOverlay.session = self.Sceneview.session
        CoachingOverlay.delegate = self
        
        CoachingOverlay.activatesAutomatically = true
        CoachingOverlay.goal = .horizontalPlane
    }
    // -----------------------------
    
    // parameter audio Shutter
    var Audio_Shutter : AVAudioPlayer!
    
    //State SingIn
    var State_SingIn = ""
    
    //sheet Controller
    var sheetController = SheetViewController()
    
    //Height View Sheet product
    var HeightViewSheet = CGFloat()
    
    
    // View Label Alert
    var View_AlertProcess : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgbAlpha(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.alpha = 0
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
    
    
    // Element menu button--------------------------------
    let Btn_exit: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "logout"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(exit_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Btn_NoAds: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "at"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(NoAds_Button_Clicked), for: .touchUpInside)
        
        return button
    }()
    
    let Btn_Undo: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "refresh"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(Event_ResetProcessAR), for: .touchUpInside)
        return button
    }()
    
    let Btn_capture: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.SecondaryColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(Capture_Button_Clicked), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    let Btn_Menu: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.SecondaryColor
        button.layer.cornerRadius = 25
        button.setImage(#imageLiteral(resourceName: "setup"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.2
        button.addTarget(self, action: #selector(menu_product), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    let viewTest: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    //Element Google Ads mob--------
    var Google_Ads_interstitial: GADInterstitial!
    //------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Layout Element in Page
        setting_Element()
        // Config AR Process
        Config_AR()
        
        //Set NotificationCenter when Singin google
        NotificationCenter.default.addObserver(self, selector: #selector(viewProductReSize(notification:)), name: NSNotification.Name(rawValue: "viewProductReSize"), object: nil)
        
        //Set NotificationCenter sheetController Dismiss when Select product
        NotificationCenter.default.addObserver(self, selector: #selector(sheetControllerSelect_Product(notification:)), name: NSNotification.Name(rawValue: "sheetControllerSelect_Product"), object: nil)
        
        //Set NotificationCenter sheetController Dismiss when Select Grout
        NotificationCenter.default.addObserver(self, selector: #selector(sheetControllerSelect_Grout(notification:)), name: NSNotification.Name(rawValue: "sheetControllerSelect_Grout"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Run AR Session
        self.Sceneview.session.run(configuration)
        
        // Check State Remove Ads
        // No remove Ads
        if Present_Page.State_RemoveAds == false {
            setting_GoogleAds()
            // Button Ads Apper
            Btn_NoAds.alpha = 1
        }
        // Remove Ads
        else {
            // Button Ads Apper
            Btn_NoAds.alpha = 0
        }
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Pause AR Session
        Sceneview.session.pause()
        
        
    }
    
    func setting_Element(){
        
        //Element AR SceneView-----------------------------------
        view.addSubview(Sceneview)
        Sceneview.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Element Coaching Overlay AR Process
        self.Sceneview.addSubview(CoachingOverlay)
        CoachingOverlay.anchor(Sceneview.topAnchor, left: Sceneview.leftAnchor, bottom: Sceneview.bottomAnchor, right: Sceneview.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        // Element View Alert AR Process And Label AR Process
        // View
        Sceneview.addSubview(View_AlertProcess)
        View_AlertProcess.anchor(CoachingOverlay.topAnchor, left: CoachingOverlay.leftAnchor, bottom: nil, right: CoachingOverlay.rightAnchor, topConstant: 150, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        // Label
        View_AlertProcess.addSubview(Lb_AlertProcess)
        Lb_AlertProcess.anchor(View_AlertProcess.topAnchor, left: View_AlertProcess.leftAnchor, bottom: View_AlertProcess.bottomAnchor, right: View_AlertProcess.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        
        // Element button menu top --------------------------------
        view.addSubview(Btn_exit)
        view.addSubview(Btn_NoAds)
        view.addSubview(Btn_Undo)
        
        Btn_Undo.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 0, rightConstant: 25, widthConstant: 30, heightConstant: 30)
        
        Btn_NoAds.anchor(Btn_Undo.topAnchor, left: nil, bottom: nil, right: Btn_Undo.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 18, widthConstant: 30, heightConstant: 30)

        Btn_exit.anchor(Btn_Undo.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 25, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        // Element button menu bottom --------------------------------
        view.addSubview(Btn_capture)
        view.addSubview(Btn_Menu)
        
        Btn_capture.anchorCenter(view.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Btn_capture.anchor(nil, left: nil, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 25, rightConstant: 0, widthConstant: 100, heightConstant: 50)
        
        Btn_Menu.anchor(nil, left: nil, bottom: Btn_capture.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 30, widthConstant: 50, heightConstant: 50)
        
        
    }
    
    func setting_GoogleAds(){
        
        Google_Ads_interstitial = GADInterstitial(adUnitID: String.GADInterstitial)
        
        //ca-app-pub-8252673033863069/5907139120
        
        let request = GADRequest()
        Google_Ads_interstitial.load(request)
        Google_Ads_interstitial.delegate = self
    }
    
    @objc func menu_product(){
    
        // Size Height SheetView
        let viewController = Sub_page_product()
        viewController.viewDidLoad()
        viewController.viewSize.layoutIfNeeded()
        HeightViewSheet = viewController.viewSize.frame.height
        
        //Setting SheetView
        let controller = Sub_page_product()
        sheetController = SheetViewController(controller: controller, sizes: [SheetSize.fixed(HeightViewSheet)])
        sheetController.overlayColor = .clear
        sheetController.topCornersRadius = 24
        sheetController.handleColor = .clear
        
        self.present(sheetController, animated: true, completion: nil)
        
    }
    
    @objc func sheetControllerSelect_Product(notification: NSNotification){
        
        // Check User Select Product ?
        guard AR_Page.Index_ProductSelect != nil else {return}
        
        Control_ViewAlertProcessAR(State: false, Text: Text_AlertProcessAR)
        
        // Manage Data Product for Create Material of Object
        let data = Present_Page.DataProduct[Present_Page.CategoryProid]![AR_Page.Index_ProductSelect!]
        
        // Image Product Tile
        var Pro_Image = Present_Page.imageProduct[AR_Page.Index_ProductSelect!]
        // Pro Pattern
        let Pro_Pattern = data[Head_GetProduct().ProPattern] as! Int
        // Pro Set Style
        let Pro_SetStyle = data[Head_GetProduct().SetStyle] as! String
        // Dimention of Product Tile
        let W = (data[Head_GetProduct().ProWidth] as! Float) / 100 // cm
        let H = (data[Head_GetProduct().ProHeight] as! Float) / 100 // cm
        var Pro_Size : CGSize = CGSize(width: CGFloat(W), height: CGFloat(H))
        // Check Pattern
        if Pro_Pattern == 1 && Pro_SetStyle == "Normal"{
            Pro_Size = CGSize(width: CGFloat(Pro_Size.width * 2), height: CGFloat(Pro_Size.height * 2))
        }
            
        
        // Manage Pro Image for Material Object
        Pro_Image = Manage_ImageProduct(Pro_Image: Pro_Image, SetStyle: Pro_SetStyle, Pattern: Pro_Pattern)
        // Find Plane Node Object Tile
        self.Sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "PlaneResult" {
                
                let W_Node = (node.boundingBox.max.x - node.boundingBox.min.x)
                let H_Node = (node.boundingBox.max.y - node.boundingBox.min.y)
                
                let scale_x = (Float(W_Node)/Float(Pro_Size.width)).rounded()
                let scale_y = (Float(H_Node)/Float(Pro_Size.height)).rounded()
                
                node.geometry?.materials.first?.diffuse.contents = Pro_Image
                node.geometry?.materials.first?.diffuse.contentsTransform = SCNMatrix4MakeScale(scale_x, scale_y, 0)
                node.geometry?.materials.first?.diffuse.wrapS = .repeat
                node.geometry?.materials.first?.diffuse.wrapT = .repeat
                
            }
        }
        
        
        sheetController.closeSheet()
        
        //
    }
    
    @objc func sheetControllerSelect_Grout(notification: NSNotification){
        sheetController.closeSheet()
        
        //
    }
    
    @objc func exit_Button_Clicked(){
        
        let alert = UIAlertController(title: "Sign Out", message: "You want to Sign Out " + State_SingIn + "?", preferredStyle: UIAlertController.Style.alert)
        
        alert.setTitlet(font: UIFont.FredokaOneRegular(size: 20), color: UIColor.ErrorColor)
        alert.setMessage(font: UIFont.LatoLight(size: 16), color: .black)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (acton) in
            
            switch self.State_SingIn {
            case "facebook":
                
                //logOut facebook
                let login = LoginManager()
                login.logOut()
                
            case "Google":
                
                //logOut Google
                GIDSignIn.sharedInstance()?.signOut()
            case "Apple":
                
                let defaults = UserDefaults.standard
                defaults.set(false, forKey: "SignInApple")
            default:break
            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    @objc func Capture_Button_Clicked(){
        
        // Check State Confirm for Capture Image
        // Capture Event
        if State_Confirm == true && State_SelectPlane == false{
            
            // Create Process Select Tile
            guard AR_Page.Index_ProductSelect != nil else {
                Control_ViewAlertProcessAR(State: true, Text: "Please select product before take photo")
                return
            }
            
            // Play Sound Shutter
            // Play Sound Shutter
            let Alertshutter = Bundle.main.url(forResource: "Sound/shutter", withExtension: "mp3")
            
            do{
                Audio_Shutter = try AVAudioPlayer(contentsOf: Alertshutter!)
            }
            catch{
                print(error)
            }
            Audio_Shutter.play()
            
            // Check State Remove Ads
            if Present_Page.State_RemoveAds == true{
                
                // Record Data Product to Data Center
                Record_DetialProduct()
                
                
                let viewPresent = Image_Detail_Page()
                Image_Detail_Page.DataCenter_ProductCopy = AR_Page.DataCenter_Product
                let image : UIImage = Sceneview.snapshot()
                viewPresent.Image_capture.image = image
                self.navigationController?.pushViewController(viewPresent, animated: true)
                
            }else {
                if Google_Ads_interstitial.isReady {
                    
                    Google_Ads_interstitial.present(fromRootViewController: self)
                    
                } else {
                    
                    // Record Data Product to Data Center
                    Record_DetialProduct()
                    
                    
                    let viewPresent = Image_Detail_Page()
                    Image_Detail_Page.DataCenter_ProductCopy = AR_Page.DataCenter_Product
                    let image : UIImage = Sceneview.snapshot()
                    viewPresent.Image_capture.image = image
                    self.navigationController?.pushViewController(viewPresent, animated: true)
                }
            }
            
        }
        // Select Plane
        else if State_Confirm == false && State_SelectPlane == true {
            
            // Create Node Mark
            self.Sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            
            // Change State Plane Select to false
            State_SelectPlane = false
            
            // Show View Alert Process AR
            Control_ViewAlertProcessAR(State: true, Text: Text_AlertProcessAR)
            
            // Record Position Y of Plane Select
            let hit = self.Sceneview.hitTest(self.view.center, types: .estimatedHorizontalPlane)
            guard hit.first != nil else {return}
            Position_PlaneSelect = CGFloat((hit.first?.worldTransform.columns.3.y)!)
            
            // Reset AR Session
            self.Sceneview.session.run(configuration, options: [.removeExistingAnchors])
            
        }
        // Confirm
        else if State_Confirm == false && State_SelectPlane == false {
            
            // Find PLane Node Create
            var count = 0
            var PlaneNode = SCNNode() // PlaneNode Result
            self.Sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
                if node.name == "PlaneCreate" {
                    // Record
                    PlaneNode = node
                    // Set New Position Relate WorldPosition Becouse node.position of Node not Compare WorldOrigin
                    PlaneNode.transform = node.worldTransform
                    //Remove node
                    node.removeFromParentNode()
                    count += 1
                }
            }
            print(count)
            // Set New Name of Node
            PlaneNode.name = "PlaneResult"
            // Add Node to Sceneview
            self.Sceneview.scene.rootNode.addChildNode(PlaneNode)
            
            // Close View Alert AR Process
            Control_ViewAlertProcessAR(State: false, Text: Text_AlertProcessAR)
            
            // Change State Confirm
            State_Confirm = !State_Confirm
        }
        
        
    }
    
    @objc func viewProductReSize(notification: NSNotification) {
        
        sheetController.setSizes([SheetSize.fixed(HeightViewSheet + 100)], animated: true)
        
    }
    
    @objc func NoAds_Button_Clicked(){
        let viewPresent = RemoveAds_Detail()
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }
    
    @objc func Event_ResetProcessAR(){
        
        // Close CoachingOverlay Process AR
        if CoachingOverlay.isActive == true {
            CoachingOverlay.setActive(false, animated: false)
        }
        
        
        // Clear Node in Process AR
        Sceneview.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        //Sceneview.scene.rootNode.removeFromParentNode()
        
        // Reset State to Default
        State_Prepare = true
        State_SelectPlane = true
        State_PlaneCreate = false
        State_Confirm = false
        
        // Reset Index Product Select
        AR_Page.Index_ProductSelect = nil
        
        // Reset Area Plane for didUpdate New Area plane Detect
        Area_PlaneAnchor = 0
        
        // Close View ALert Process AR
        Control_ViewAlertProcessAR(State: false, Text: Text_AlertProcessAR)
        
        // button cature hide
        Btn_capture.alpha = 0
        
        
        
        // Reset AR Session
        self.Sceneview.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        // Open CoachingOverlay Process AR
        CoachingOverlay.setActive(true, animated: true)
        
        
    }
    
    
    // MARK: Normal Func
    // Func Control View Alert Process AR
    func Control_ViewAlertProcessAR(State : Bool, Text : String){
        
        // Set Text Show
        self.Lb_AlertProcess.text = Text
        
        // Open View Process AR
        if State {
            self.View_AlertProcess.alpha = 1
        }
        // Close View Process AR
        else {
            self.View_AlertProcess.alpha = 0
        }
        
        
        /*DispatchQueue.main.async {
            // Set Text Show
            self.Lb_AlertProcess.text = Text
            
            // Open View Process AR
            if State {
                self.View_AlertProcess.alpha = 1
            }
            // Close View Process AR
            else {
                self.View_AlertProcess.alpha = 0
            }
        }*/
        
    }
    
    // Func Record Detial Product to Data Center
    func Record_DetialProduct(){
        // Manage Data Product for Create Material of Object
        let data = Present_Page.DataProduct[Present_Page.CategoryProid]![AR_Page.Index_ProductSelect!]
        
        // Image Product Tile
        let Pro_Image = Present_Page.imageProduct[AR_Page.Index_ProductSelect!]
        // Name Product
        let Pro_Name = data[Head_GetProduct().ProName] as! String
        // Price Per Unit Product
        let Pro_Price = data[Head_GetProduct().ProPrice] as! Double

        // Dimention of Product Tile
        let W = Double(data[Head_GetProduct().ProWidth] as! Float)// cm
        let H = Double(data[Head_GetProduct().ProHeight] as! Float)
        // Cal Area
        var Area : Double = 0
        var Dimension_Plane : CGSize = CGSize(width: 0, height: 0)
        self.Sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
        if node.name == "PlaneResult" {
            
            let W_Node = (node.boundingBox.max.x - node.boundingBox.min.x)
            let H_Node = (node.boundingBox.max.y - node.boundingBox.min.y)
            
            Area = Double(W_Node * H_Node)
            Dimension_Plane = CGSize(width: Double(W_Node), height: Double(H_Node))
            
            }
        }
        
        // Cal Total Price
        let Spare = Area * (5/100) // Spare Tile = 5% of All Area
        let Total_Price = (Area + Spare) * Pro_Price
        
        AR_Page.DataCenter_Product = Detial_Product(Product_Image: Pro_Image, Product_Name: Pro_Name, Product_Price: Pro_Price, Product_Size_W: W, Product_Size_H: H, Product_Area: Area, Product_Dimension_L: Double(Dimension_Plane.height), Product_Dimension_W: Double(Dimension_Plane.width), Product_Spare: 5, Product_TotalPrice: Total_Price, Index_TypeDimension: 0, Index_Spare: 0)
        
    }
    
    
}

// Extension AR Process
extension AR_Page : ARSCNViewDelegate {
    
    // func render realtime
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        DispatchQueue.main.async { [self] in
            
            // Check State Select plane
            if self.State_SelectPlane == true && self.State_Prepare == false {
                
                print(self.Sceneview.session.currentFrame?.camera.trackingState)
                
                let hit = self.Sceneview.hitTest(self.view.center, types: .estimatedHorizontalPlane)
                
                // Reset Node from Node Parent
                self.Sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
                    node.removeFromParentNode()
                }
                
                guard hit.first != nil else {return}
                // Get Position hit Test
                let PositionMarker = hit.first!.worldTransform.columns.3
                
                // Create Marker Node
                let MarkerNode = self.Create_Marker(Position: PositionMarker)
                
                self.Sceneview.scene.rootNode.addChildNode(MarkerNode)
                
            }
            
        }
        
    }
    
    // Func Create Marker
    func Create_Marker(Position : simd_float4) -> SCNNode {
        
        let MarkerNode = SCNNode()
        
        guard let pointofView = Sceneview.pointOfView else {return MarkerNode}
        let q = pointofView.orientation
        let alpha = Float.pi - atan2f( (2*q.y*q.w)-(2*q.x*q.z), 1-(2*pow(q.y,2))-(2*pow(q.z,2)) )
        
        // Create Center Circle
        let Center = SCNSphere(radius: 0.005) // radius  1 cm
        Center.materials.first?.diffuse.contents = UIColor.SecondaryColor
        let CenterNode = SCNNode(geometry: Center)
        
        // Create Ring
        let Ring = SCNTorus(ringRadius: 0.03, pipeRadius: 0.005)
        Ring.materials.first?.diffuse.contents = UIColor.SecondaryColor
        let RingNode = SCNNode(geometry: Ring)
        // Add RingNode into CenterNode
        CenterNode.addChildNode(RingNode)
        
        // Create Text Node
        // Get  Current Position of Camera
        let transform = pointofView.transform
        let Device_Location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let DevicePosition_Y = abs(Device_Location.y - Position.y)
        // Add Text width Plane
        let LabelW_Text = String(format: "%.2f", Float(DevicePosition_Y)) + " m"
        let Text_W = SCNText(string: LabelW_Text, extrusionDepth: 0.001)
        Text_W.font = UIFont.FredokaOneRegular(size: 2)
        Text_W.firstMaterial?.diffuse.contents = UIColor.white
        let Text_W_Node = SCNNode(geometry: Text_W)
        //Text_W_Node.position.y -= Float((PlaneHeight / 2) + 0.1)
        let min_W = Text_W_Node.boundingBox.min
        let max_W = Text_W_Node.boundingBox.max
        let w_W = CGFloat(max_W.x - min_W.x)
        Text_W_Node.position.x -= Float(((w_W/100) / 2)) + 0.01
        Text_W_Node.eulerAngles = SCNVector3(90.degreesToRadians, 0, .pi)
        Text_W_Node.scale = SCNVector3(0.01, 0.01, 0.01)
        Text_W_Node.name = "TextWidth"
        
        // Add Text
        RingNode.addChildNode(Text_W_Node)
        // Add RingNode into CenterNode
        CenterNode.addChildNode(RingNode)
        
        // Add to MainNode (MarkerNode)
        MarkerNode.addChildNode(CenterNode)
        MarkerNode.position = SCNVector3(CGFloat(Position.x), CGFloat(Position.y), CGFloat(Position.z))
        MarkerNode.eulerAngles = SCNVector3(0, -Double(alpha), 0)
        
        return MarkerNode
        
    }

    // Func Add Node
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Check Process AR (Not Confirm Process)
        if State_Confirm == false && State_SelectPlane == false && State_PlaneCreate == false {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            // Check Position Plane Select < 0.05
            let dif_Plane = abs(CGFloat(self.Position_PlaneSelect) - CGFloat(planeAnchor.transform.columns.3.y))
            print(dif_Plane)
            if dif_Plane < 0.05 {
                // Change State Plane Create for Disable Event AR Session Create New Plane Repeat ***
                State_PlaneCreate = true
                // Record Area PlaneAnchor
                Area_PlaneAnchor = Float(planeAnchor.extent.x * planeAnchor.extent.z)
                // Create Plane AR
                let PlaneNode = Create_PlaneNode(anchor: planeAnchor)
                // Add Node AR
                node.addChildNode(PlaneNode)
            }
        }
        
    }
    
    // Func Update Node
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if State_Confirm == false && State_SelectPlane == false {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            // Check Position Plane Select < 0.05
            let dif_Plane = abs(CGFloat(self.Position_PlaneSelect) - CGFloat(planeAnchor.transform.columns.3.y))
            if dif_Plane < 0.05 {
                
                // Check Current Plane
                let AreaExtent = Float(planeAnchor.extent.x * planeAnchor.extent.z)
                guard AreaExtent >= Area_PlaneAnchor else {return}
                // Remove existing plane nodes
                node.enumerateChildNodes {
                    (childNode, _) in
                    childNode.removeFromParentNode()
                }
                // Record Area PlaneAnchor
                Area_PlaneAnchor = Float(planeAnchor.extent.x * planeAnchor.extent.z)
                // Create Plane AR
                let PlaneNode = Create_PlaneNode(anchor: planeAnchor)
                // Add Node AR
                node.addChildNode(PlaneNode)
            }
        }
        
    }
    
    // Func Remove Node
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        
        // Remove existing plane nodes
        node.enumerateChildNodes {
            (childNode, _) in
            childNode.removeFromParentNode()
        }
        
    }
    
    // Func Create Object Tile
    func Create_PlaneNode(anchor : ARPlaneAnchor) -> SCNNode {
        
        var PlaneNode = SCNNode()
        let Plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        // Set Size of Grid in Plane
        let scalex = (Float(anchor.extent.x) / 0.05).rounded()
        let scaley = (Float(anchor.extent.z) / 0.05).rounded()
        
        let ImageGrid = #imageLiteral(resourceName: "blur")
        Plane.materials.first?.diffuse.contents = ImageGrid //UIColor.rgbAlpha(red: 255, green: 255, blue: 255, alpha: 0.8)
        Plane.materials.first?.diffuse.contentsTransform = SCNMatrix4MakeScale(scalex, scaley, 0)
        Plane.materials.first?.diffuse.wrapS = .repeat
        Plane.materials.first?.diffuse.wrapT = .repeat
        
        PlaneNode = SCNNode(geometry: Plane)
        // Set Position
        let x = CGFloat(anchor.center.x)
        let y = CGFloat(-0.02)//CGFloat(anchor.center.y)
        let z = CGFloat(anchor.center.z)
        
        
        PlaneNode.position = SCNVector3(x, y, z)
        PlaneNode.eulerAngles.x = -.pi / 2
        PlaneNode.name = "PlaneCreate"
        
        return PlaneNode

    }
    
    // Func Manage and Create Meterial for PlaneNode for SetStyle and Tile Pattern
    func Manage_ImageProduct(Pro_Image : UIImage, SetStyle : String, Pattern : Int) -> UIImage {
        
        // Normal Sty
        if SetStyle == "Normal" {
            
            var Image_Result = addGroutToimage(ImageTile_Ori: Pro_Image, Color_grout: AR_Page.Color_Grout)
            
            // Check Pattern Product Tile (4 Complement = 1 Pattern)?
            if Pattern == 1 {
                // Adapter Image Product (4 Complement)
                Image_Result = image_complementTile(image: Image_Result)
            }
            
            return Image_Result
            
        }
        // Overlap Style
        else if SetStyle == "Overlap" {
            
            let Image_Result = addGroutToimage_Wood(ImageTile_Ori: Pro_Image, Color_grout: AR_Page.Color_Grout)
            return Image_Result
            
        }
        // Hexagon Style
        else {
            
            let Image_Result = addGroutToimage_Hex(ImageTile_Ori: Pro_Image, Color_grout: AR_Page.Color_Grout)
            return Image_Result
            
        }
        
        
    }
    
    //MARK: Func Custom Image Tile add grout
    func addGroutToimage(ImageTile_Ori : UIImage, Color_grout : UIColor) -> UIImage {
        
        // Create Bg of Image
        let path_grout = UIBezierPath(rect: CGRect(x: 0, y: 0, width: (ImageTile_Ori.size.width * 1.01438), height: (ImageTile_Ori.size.height * 1.01438)))
        
        // Find Position Image Tile for Bg
        let size_im_w = ImageTile_Ori.size.width
        let size_im_h = ImageTile_Ori.size.height
        let Position_Tile_x = (path_grout.bounds.size.width/2) - (size_im_w/2)
        let Position_Tile_y = (path_grout.bounds.size.height/2) - (size_im_h/2)
        
        UIGraphicsBeginImageContextWithOptions(path_grout.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setFillColor(Color_grout.cgColor)
        context?.draw(ImageTile_Ori.cgImage!, in: CGRect(x: 0, y: 0, width: ImageTile_Ori.size.width, height: ImageTile_Ori.size.height))
        
        // Add Path Bg to Context
        path_grout.fill()
        
        //Add Image Tileto Context
        ImageTile_Ori.draw(in: CGRectMake( Position_Tile_x, Position_Tile_y, ImageTile_Ori.size.width, ImageTile_Ori.size.height))
        
        // Create Image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //MARK: Func Custom Image Tile add grout For Wood Tile
    func addGroutToimage_Wood(ImageTile_Ori : UIImage, Color_grout : UIColor) -> UIImage {
        
        // Create Bg of Image
        let path_grout = UIBezierPath(rect: CGRect(x: 0, y: 0, width: (ImageTile_Ori.size.width + 2), height: ImageTile_Ori.size.height))
        
        // Find Position Image Tile for Bg
        let size_im_w = ImageTile_Ori.size.width
        let Position_Tile_x = (path_grout.bounds.size.width/2) - (size_im_w/2)
        
        UIGraphicsBeginImageContextWithOptions(path_grout.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.setFillColor(Color_grout.cgColor)
        context?.draw(ImageTile_Ori.cgImage!, in: CGRect(x: 0, y: 0, width: ImageTile_Ori.size.width, height: ImageTile_Ori.size.height))
        
        // Add Path Bg to Context
        path_grout.fill()
        
        //Add Image Tileto Context
        ImageTile_Ori.draw(in: CGRectMake( Position_Tile_x, 0, ImageTile_Ori.size.width, ImageTile_Ori.size.height))
        
        // Create Image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //MARK: Func Custom Image Tile add grout For Hex Tile
    func addGroutToimage_Hex(ImageTile_Ori : UIImage, Color_grout : UIColor) -> UIImage {
        
        // Create Bg of Image
        let path_grout = UIBezierPath(rect: CGRect(x: 0, y: 0, width: ImageTile_Ori.size.width, height: ImageTile_Ori.size.height))
        
        UIGraphicsBeginImageContextWithOptions(path_grout.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(Color_grout.cgColor)
        context?.draw(ImageTile_Ori.cgImage!, in: CGRect(x: 0, y: 0, width: ImageTile_Ori.size.width, height: ImageTile_Ori.size.height))
        
        // Add Path Bg to Context
        path_grout.fill()
        
        //Add Image Tile to Context
        ImageTile_Ori.draw(in: CGRectMake( 0, 0, ImageTile_Ori.size.width, ImageTile_Ori.size.height))
        
        // Create Image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // MARK: complementary image Tile Type 4 plane
    func image_complementTile(image: UIImage) -> UIImage {
        
        let size_imagetotal = CGSize(width: (image.size.width * 2), height: (image.size.height * 2))
        // set position complement image Tile
        let position_pull : [[Float]] = [[Float(size_imagetotal.width/2),0], [Float(size_imagetotal.width/2),Float(size_imagetotal.height/2)], [0,Float(size_imagetotal.height/2)], [0,0]]
        let degree_rotate = [90,180,270,360]
        UIGraphicsBeginImageContext(size_imagetotal)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        
        for count in 1...4 {
            let image_rotate = imageRotatedByDegrees(oldImage: image, deg: CGFloat(degree_rotate[count-1]))
            bitmap.draw(image_rotate.cgImage!, in: CGRect(x: CGFloat(position_pull[count - 1][0]), y: CGFloat(position_pull[count - 1][1]), width: CGFloat(image.size.width), height: CGFloat(image.size.height)))
            
        }
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
        
    }
    
    // MARK: Rotate IMage follow degree
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (-degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // Func CGRectMake
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
}
extension AR_Page : ARCoachingOverlayViewDelegate {
    
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
        
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        
        // Change State Prepare
        if State_Confirm == false {
            State_Prepare = false
        }
        
        // button capture hide
        Btn_capture.alpha = 1
        
        // Open Alert Process AR (Select Plane Simulation)
        Control_ViewAlertProcessAR(State: true, Text: Text_AlertProcessAR)
        
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        print("Reset")
    }
    
    
}


// Extension View Expend (Category View)
extension AR_Page : GADInterstitialDelegate{

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        // Record Detial Product to Data Center
        Record_DetialProduct()
        
        let viewPresent = Image_Detail_Page()
        Image_Detail_Page.DataCenter_ProductCopy = AR_Page.DataCenter_Product
        let image : UIImage = Sceneview.snapshot()
        viewPresent.Image_capture.image = image
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

// Data Structure of Detail Product
struct Detial_Product {
    
    var Product_Image : UIImage
    var Product_Name : String
    var Product_Price : Double
    var Product_Size_W : Double
    var Product_Size_H : Double
    
    var Product_Area : Double
    var Product_Dimension_L : Double
    var Product_Dimension_W : Double
    
    var Product_Spare : Int
    var Product_TotalPrice : Double
    
    var Index_TypeDimension : Int
    var Index_Spare : Int
    
}
