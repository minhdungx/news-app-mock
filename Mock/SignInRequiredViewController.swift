//
//  SignInRequiredViewController.swift
//  Mock
//
//  Created by DungHM on 21/11/24.
//

import UIKit



class SignInRequiredViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        signInBtn.roundEachCorners(corners: [.topLeft , .topRight], radius: 30)
        
    }
    
    @IBAction func signIn(_ sender: UIButton){
        let VC = storyboard?.instantiateViewController(identifier: "SignUpIn") as? SignUpViewController
        
        if let vc = VC{
            self.navigationController?.pushViewController(vc, animated: true)
            vc.modeSignUp = false
        }
    }
    
    @IBAction func signUp(_ sender: UIButton){
        let VC = storyboard?.instantiateViewController(identifier: "SignUpIn") as? SignUpViewController
        
        if let vc = VC{
            
            self.navigationController?.pushViewController(vc, animated: true)
            vc.modeSignUp = true
        }
    }
}
