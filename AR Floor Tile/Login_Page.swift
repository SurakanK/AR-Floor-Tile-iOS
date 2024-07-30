//
//  Login_Page.swift
//  AR Floor Tile
//
//  Created by Surakan Kasurong on 13/8/2563 BE.
//  Copyright © 2563 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import AuthenticationServices

class Login_Page: UIViewController {
   
    let ratioY = UIScreen.main.bounds.size.height / 812
    //let ratioX = UIScreen.main.bounds.size.width / 375
    
    //State show View in sub page product
    //static var StateView : String = "Category"
    
    //static var idSubCategory : Int = 0
    
    var State_CheckBox = false
    
    //data user
    var Token = ""
    var Email = ""
    var Name = ""
    
    //Data user singin google
    static var DataUserSingInGoogle : [String:String]?
    
    var Btn_Sing_Apple : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(login_Apple_Button_Clicked), for: .touchUpInside)
        button.cornerRadius = 25
        return button
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
    
    let Btn_Sign_Facebook: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.FacebookColor
        button.layer.cornerRadius = 25
        button.setTitle("SIGN IN WITH FACEBOOK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 14)
        button.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 30)
        button.addTarget(self, action: #selector(login_FaceBook_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Btn_Sign_Gmail: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.ErrorColor
        button.layer.cornerRadius = 25
        button.setTitle("SIGN IN WITH GMAIL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 14)
        button.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "Google"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: 30)
        button.addTarget(self, action: #selector(login_Google_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Btn_Skip: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("SKIP", for: .normal)
        button.setTitleColor(UIColor.NautralBlack, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 14)
        button.addTarget(self, action: #selector(SKIP_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let Btn_About_Contact: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("ABOUT & CONTACT US", for: .normal)
        button.setTitleColor(UIColor.NautralBlack, for: .normal)
        button.titleLabel?.font = UIFont.FredokaOneRegular(size: 14)
        button.addTarget(self, action: #selector(About_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    //Element view permission--------------------------------------
    let View_Permission: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let Btn_SheckBox: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.NautralBlack
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(SheckBox_Button_Clicked), for: .touchUpInside)
        return button
    }()
    
    let title_Permission: UILabel = {
        let label = UILabel()
        label.text = "Yes, Please keep me update on AR Floor Tile new, Event and offer"
        label.textColor = UIColor.NautralBlack
        label.font = UIFont.LatoLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        
        setting_Element()
        
        Process_login_FaceBook()
        Process_login_Google()
        Process_login_Apple()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                
        Present_Page.StateView = "Category"
    }
    
    //Setting Element in view
    func setting_Element(){
        
        view.addSubview(Image_background)
        view.addSubview(Image_Logo)
        view.addSubview(title_Name)
        view.addSubview(Btn_Sign_Facebook)
        view.addSubview(Btn_Sign_Gmail)
        view.addSubview(Btn_Sing_Apple)
        view.addSubview(Btn_Skip)
        view.addSubview(Btn_About_Contact)
        
        view.addSubview(View_Permission)
        view.addSubview(Btn_SheckBox)
        view.addSubview(title_Permission)

        //set element background app--------------------------------
        Image_background.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set element logo and name app--------------------------------
        Image_Logo.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 200, heightConstant: 200)
        Image_Logo.anchor(Image_background.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 50 * ratioY, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        title_Name.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        title_Name.anchor(Image_Logo.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set element button login--------------------------------
        Btn_Sign_Facebook.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 300, heightConstant: 50)
        Btn_Sign_Facebook.anchor(nil, left: nil, bottom: Btn_Sign_Gmail.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Btn_Sign_Gmail.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 300, heightConstant: 50)
        Btn_Sign_Gmail.anchor(nil, left: nil, bottom: Btn_Sing_Apple.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Btn_Sing_Apple.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 300, heightConstant: 50)
        Btn_Sing_Apple.anchor(nil, left: nil, bottom: View_Permission.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 15 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set element permission----------------------------------
        View_Permission.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 270, heightConstant: 0)
        View_Permission.anchor(nil, left: nil, bottom: Btn_Skip.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 75 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Btn_SheckBox.anchor(View_Permission.topAnchor, left: View_Permission.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        title_Permission.anchor(View_Permission.topAnchor, left: Btn_SheckBox.rightAnchor, bottom: nil, right: View_Permission.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //set event touch in title Permission
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SheckBox_Button_Clicked(tapGestureRecognizer:)))
        title_Permission.isUserInteractionEnabled = true
        title_Permission.addGestureRecognizer(tapGestureRecognizer)
        
        //set element button buttom page--------------------------------
        Btn_Skip.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Btn_Skip.anchor(nil, left: nil, bottom: Btn_About_Contact.topAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 20 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        Btn_About_Contact.anchorCenter(Image_background.centerXAnchor, AxisY: nil, ConstantAxisX: 0, ConstantAxisY: 0, widthConstant: 0, heightConstant: 0)
        Btn_About_Contact.anchor(nil, left: nil, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 20 * ratioY, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    @objc func login_Google_Button_Clicked(){
        
        if State_CheckBox == false{
            Btn_SheckBox.tintColor = UIColor.ErrorColor
            title_Permission.textColor = UIColor.ErrorColor
        }else{
            GIDSignIn.sharedInstance()?.signIn()
        }
    }
    
    @objc func SingInGoogle(notification: NSNotification) {
        //Manage Data sing in with Google
        //let Token = Login_Page.DataUserSingInGoogle!["idToken"]!
        let Email = Login_Page.DataUserSingInGoogle!["email"]!
        let Name = Login_Page.DataUserSingInGoogle!["fullName"]!
        
        //Insert new User
        InsertUser(TokenID: Email, Email: Email, Name: Name,
                   Age: 0, Gender: "",
                   Type: "Google", Subscribe: BoolToInt(Bool: Present_Page.State_RemoveAds))
        
        String.UserTokenID = Email
        
        NextTo_AR_Page(State: "Google")
    }
    
    //Event Clicked login facebook
    @objc func login_FaceBook_Button_Clicked(){
        
        if State_CheckBox == false{
            Btn_SheckBox.tintColor = UIColor.ErrorColor
            title_Permission.textColor = UIColor.ErrorColor
        }else{
            
            let login = LoginManager()
            
            //Set permissions Request Data
            login.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if error != nil {
                    print("Process error")
                } else if result?.isCancelled ?? false {
                    print("Cancelled")
                } else {
                    print("Logged in")
                }
            }
        }
        
    }
    
    //Event Clicked login Apple
    @objc func login_Apple_Button_Clicked(){
       
        if State_CheckBox == false{
            Btn_SheckBox.tintColor = UIColor.ErrorColor
            title_Permission.textColor = UIColor.ErrorColor
        }else{
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
    
    func Process_login_Apple(){
        let defaults = UserDefaults.standard
        
        if (defaults.bool(forKey: "SignInApple")) {
            NextTo_AR_Page(State: "Apple")
        }
    }
    
    func Process_login_Google(){
        //Set NotificationCenter when Singin google
        NotificationCenter.default.addObserver(self, selector: #selector(SingInGoogle(notification:)), name: NSNotification.Name(rawValue: "SingInGoogle"), object: nil)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    func Process_login_FaceBook(){
        // This will trigger after successfully login / logout
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
            
            // request Data user in SDKFacebook
            self.requestDatauserSDKFacebook()
            
            //Next page
            if AccessToken.current?.tokenString != nil{
                self.NextTo_AR_Page(State: "facebook")
            }
            
        }
        
        if let token = AccessToken.current, !token.isExpired {
            // request Data user in SDKFacebook
            requestDatauserSDKFacebook()
            NextTo_AR_Page(State: "facebook")
        }
        
    }
    
    func requestDatauserSDKFacebook(){
        // request Data user in SDKFacebook
        let request = GraphRequest(graphPath: "/me", parameters: ["fields": "id,name,email"], httpMethod: HTTPMethod(rawValue: "GET"))
        
        //result request Data header
        request.start(completionHandler: { connection, result, error in
                  
            if let err = error {
                print("Facebook graph request error: \(err)")
            } else {
                print("Facebook graph request successful!")

                //Manage Data sing in with facebook
                //self.Token = AccessToken.current?.tokenString as! String
                
                guard let json = result as? NSDictionary else { return }
                if let email = json["email"] as? String {
                    self.Email = email
                }
                if let firstName = json["name"] as? String {
                    self.Name = firstName
                }
                if let id = json["id"] as? String {
                    print("\(id)")
                }
                
                //Insert new User
                self.InsertUser(TokenID: self.Email, Email: self.Email,
                                Name: self.Name, Age: 0, Gender: "",
                                Type: "Facebook", Subscribe: self.BoolToInt(Bool: Present_Page.State_RemoveAds))
               
                String.UserTokenID = self.Email
            }

        })
    }
    
    @objc func SKIP_Button_Clicked(){
        
        let UUid = UIDevice.current.identifierForVendor?.uuidString
        
        InsertUser(TokenID: UUid!, Email: "", Name: "",
                   Age: 0, Gender: "",
                   Type: "SKIP", Subscribe: BoolToInt(Bool: Present_Page.State_RemoveAds))
        
        String.UserTokenID = UUid!

        NextTo_AR_Page(State: "")
    }
    
    func BoolToInt(Bool:Bool) -> Int {
        if Bool == true{
            return 1
        }else{
            return 0
        }
    }
    
    @objc func SheckBox_Button_Clicked(tapGestureRecognizer: UITapGestureRecognizer){

        if State_CheckBox == false{
            State_CheckBox = true
            Btn_SheckBox.setImage(#imageLiteral(resourceName: "check"), for: .normal)
            
            Btn_SheckBox.tintColor = UIColor.NautralBlack
            title_Permission.textColor = UIColor.NautralBlack

        }else{
            State_CheckBox = false
            Btn_SheckBox.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }
    }
    
    @objc func About_Button_Clicked(){
        
        let viewPresent = Contact_Wisdom_Chain()
        self.navigationController?.pushViewController(viewPresent, animated: true)
        
    }
    
    func NextTo_AR_Page(State : String){
        let viewPresent = AR_Page()
        viewPresent.State_SingIn = State
        self.navigationController?.pushViewController(viewPresent, animated: true)
    }
 
    func InsertUser(TokenID:String, Email:String, Name:String, Age:Int, Gender:String, Type:String, Subscribe:Int){
        
        let Header : HTTPHeaders = [.contentType("application/json")]
        let Url : String = .Url_InsertUser
        
        let parameters = ["TokenID":TokenID,
                          "Email":Email,
                          "Name":Name,
                          "Age":Age,
                          "Gender":Gender,
                          "Type":Type,
                          "Subscribe":Subscribe] as [String : Any]
        
        AF.request(Url, method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: Header).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                
                let JSON = value as? [String : Any]
    
                if JSON!["results"] != nil{
                    print("Insert User")
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

extension Login_Page: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}

extension Login_Page: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
       
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "Wisdom.AR-Floor-Tile", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "SignInApple")
        
        if (email != nil) {
            let firstName = fullName?.givenName!
            let lastName = fullName?.familyName!
            let fullName = firstName! + " " + lastName!
            let email = email!
            
            //Insert new User
            InsertUser(TokenID: email, Email: email, Name: fullName,
                       Age: 0, Gender: "",
                       Type: "Apple", Subscribe: BoolToInt(Bool: Present_Page.State_RemoveAds))
            
            String.UserTokenID = Email
            defaults.set(Email, forKey: "AppleToken")

            NextTo_AR_Page(State: "Apple")
        } else {
            
            String.UserTokenID = defaults.string(forKey: "AppleToken")!
            NextTo_AR_Page(State: "Apple")
        }
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
