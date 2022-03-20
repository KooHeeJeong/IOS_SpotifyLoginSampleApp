//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 구희정 on 2022/03/17.
//

import UIKit
import FirebaseAuth

class MainViewController : UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        //welcome text
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        //해당 값이 password면 email,password로 로그인 했다는 뜻
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    @IBAction func logoutButtonTap(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do{
            //firebaseAuth를 이용한 로그아웃
            try firebaseAuth.signOut()
            //버튼을 눌렀을 때 RootViewController 화면으로 가진다.
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            
            showAlert(message: signOutError.localizedDescription.description)
            
        }
        
    }
    @IBAction func resetPassWordButtonTap(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    //Alert UI 보여지도록 하는 func
    func showAlert(message : String ) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
