//
//  SignUpViewController.swift
//  Mock
//
//  Created by DungHM on 15/11/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpInBtn :UIButton!
    @IBOutlet weak var skipBtn :UIButton!
    @IBOutlet weak var forgerPWBtn :UIButton!
    @IBOutlet weak var signUpNavBtn :UIButton!
    @IBOutlet weak var signInNavBtn :UIButton!
    @IBOutlet weak var nameView :UIView!
    @IBOutlet weak var nameLB :UILabel!
    @IBOutlet weak var nameTF :UITextField!
    @IBOutlet weak var emailView :UIView!
    @IBOutlet weak var emailLB :UILabel!
    @IBOutlet weak var emailTF :UITextField!
    @IBOutlet weak var passwordView :UIView!
    @IBOutlet weak var passwordLB :UILabel!
    @IBOutlet weak var passwordTF :UITextField!
    @IBOutlet weak var signInUnderscore : UIView!
    @IBOutlet weak var signUpUnderscore : UIView!
    
    let userdefault = UserDefaults.standard
    struct User : Codable {
        let name: String
        let email: String
        let password: String
    }

    
    var modeSignUp: Bool = true {
        didSet {
            signInUnderscore.isHidden = modeSignUp
            signUpUnderscore.isHidden = !modeSignUp
            signUpNavBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeSignUp == true ? .bold : .light)
            signInNavBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: modeSignUp == false ? .bold : .light)
            forgerPWBtn.isHidden = modeSignUp
            nameView.isHidden = !modeSignUp
            signUpInBtn.setTitle(modeSignUp == true ? "ĐĂNG KÝ" : "ĐĂNG NHẬP", for: .normal)
            passwordTF.endEditing(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSignUp = true
        signUpInBtn.roundEachCorners(corners: [.topLeft , .topRight], radius: 30)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
        
    @IBAction func signUpTab(_ 	sender: UIButton) {
        modeSignUp = true
    }
    
    @IBAction func signInTab(_ sender: UIButton) {
        modeSignUp  = false
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if modeSignUp {
            if signUpValidate() {
                
                userdefault.set(nameTF.text, forKey: "name")
                userdefault.set(emailTF.text, forKey: "email")
                userdefault.set(passwordTF.text, forKey: "password")
                modeSignUp = false
                presentAlert(title: "Thành công", message: "Đăng ký thành công")
            }
        } else {
            if signUpValidate() {
                if emailTF.text == userdefault.string(forKey: "email") && passwordTF.text == userdefault.string(forKey: "password") {
                    presentAlert(title: "Thành công", message: "Đăng nhập thành công")
                } else {
                    presentAlert(title: "Thất bại ", message: "Email (mật khẩu) không chính xác")
                }
            }
        }
    }
    
    @IBAction func forgetPassword(_ sender: UIButton){
        let forgetPasswordVC = storyboard?.instantiateViewController(withIdentifier: "ForgetPassword") as? ForgetPassword
        if let VC = forgetPasswordVC {
            self.navigationController?.pushViewController(VC, animated: true)	
        }
        
    }


    
    @IBAction func signUpSkip(_ sender: UIButton) {
        if modeSignUp {
            modeSignUp = false
        } else {
            let tabBar = UITabBarController()
            let homeVC = UINavigationController(rootViewController: HomeVC())
            homeVC.title = "Trang chủ"
            homeVC.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "icon-home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon-home-filled")?.withRenderingMode(.alwaysOriginal))
            
            let mapVC = UINavigationController(rootViewController: MapVC())
            mapVC.title = "Gần tôi"
            mapVC.tabBarItem = UITabBarItem(title: "Gần tôi", image: UIImage(named: "icon-located")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon-located-filled")?.withRenderingMode(.alwaysOriginal))
            
            let categoryVC = UINavigationController(rootViewController: CategoryVC())
            categoryVC.title = "Danh mục"
            categoryVC.tabBarItem = UITabBarItem(title: "Danh mục", image: UIImage(named: "icon-browse")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon-browse-filled")?.withRenderingMode(.alwaysOriginal))	
            
            let profileVC = UINavigationController(rootViewController: ProfileVC())
            profileVC.title = "Cá nhân"
            profileVC.tabBarItem = UITabBarItem(title: "Cá nhân", image: UIImage(named: "icon-profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icon-profile-filled")?.withRenderingMode(.alwaysOriginal))
            tabBar.viewControllers = [homeVC, mapVC , categoryVC, profileVC]
            
//            self.navigationController?.pushViewController(tabBar, animated: true)
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)
            

        }
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func emailValidate(email: String) -> Bool{
        let regex = try? NSRegularExpression(pattern: "[A-Za-z0-9]+@rikkeisoft.com")
        let range = NSRange(location: 0 , length: email.utf16.count )
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func passwordValidate(password : String) -> Bool {
        let pwLen = password.count
        if (pwLen>16) || (pwLen<6) {
            return false
        }
        return true
    }
    
    func presentAlert(title: String , message: String) {
        let al = UIAlertController(title: title, message: message, preferredStyle: .alert)
        al.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(al, animated: true)
    }
    
    func signUpValidate() -> Bool {
        if nameTF.text!.isEmpty && modeSignUp {
            presentAlert(title: "Thiếu thông tin" , message: "Vui lòng bổ sung thông tin")
            return false
        }
        else if emailTF.text!.isEmpty || passwordTF.text!.isEmpty {
            presentAlert(title: "Thiếu thông tin" , message: "Vui lòng bổ sung thông tin")
            return false
        }
        else {
            if !emailValidate(email: emailTF.text!) {
                presentAlert(title: "Sai định dạng ", message: "Vui lòng điền email đúng định dạng")
                return false
            }
            else if !passwordValidate(password: passwordTF.text!){
                presentAlert(title: "Sai định dạng", message: "Mật khẩu có độ dài từ 6-16 ký tự")
                return false
            }
            else {
                return true
            }
        }
        
        
    }
    
    //comment nè
}

extension UIView {
    
    func roundEachCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 4.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }

    
    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
     
     
}

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad() 
        view.backgroundColor = .systemBlue 
        title = "First"
    }
}
class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        title = "second"
    }
}



