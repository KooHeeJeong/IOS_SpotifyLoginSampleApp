//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 구희정 on 2022/03/16.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.layer.cornerRadius = 30
        self.nextButton.isEnabled = false
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //화면이 넘어왔을때 emailTextFiled에 커서가 들어가도록
        emailTextField.becomeFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func nextButtonTap(_ sender: UIButton) {
        //FireBase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default :
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        }
        
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email : String , password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] signResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
            
        }
    }
    
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    //이메일 비밀번호 입력이 끝나고, 리턴버튼을 눌렀을 때 키보드가 내려가도록 하는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return false
    }
    //이메일 비밀번호에 값이 입력되었으면, 버튼이 isEnabled 되도록
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = self.emailTextField.text == ""
        let isPasswordEmpty = self.passwordTextField.text == ""
        
        self.nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
