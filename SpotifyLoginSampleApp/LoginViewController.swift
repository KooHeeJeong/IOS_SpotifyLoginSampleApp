//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 구희정 on 2022/03/16.
//

import UIKit
import GoogleSignIn

class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //forEach 돌면서 버튼들의 디자인들 바꿔줌.
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //NavigationBar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign in
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    //구글 로그인 버튼 탭
    @IBAction func googleLoginButtonTap(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    //애플 로그인 버튼 탭
    @IBAction func appleLoginButtonTap(_ sender: UIButton) {
        
    }
}
