//
//  ViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 20/07/22.
//

import UIKit

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let classModel = ViewModel()
    var valueOfId : Int?
    var login : Bool?
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var loginButton :UIButton!
    @IBOutlet weak var registerButton :UIButton!
    @IBOutlet weak var forgetButton :UIButton!
    @IBOutlet weak var nameTxt :UITextField!
    @IBOutlet weak var passwordTxt :UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func tappedOnButton(_ sender : Any)
    {
        guard let  secondVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")else
        {
            return
        }
        navigationController?.pushViewController(secondVc, animated: true)
        
    }
    @IBAction func tappedButton(_ sender : Any)
    {
    

        if nameTxt.text == ""
        {
            
            displayAlert(message: "mailid is empty")
            
        }
        if passwordTxt.text == ""
        {
            displayAlert(message: "password is empty")
            
        }
        if passwordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "password must be greater than 8")
            
        }
        else{
            
            classModel.loginPassing(mail: nameTxt.text ?? "", userPassword: passwordTxt.text ?? "") { result in
                let data = Data(result.utf8)
                
                let model = try? JSONDecoder().decode(LoginResponse.self, from: data)
                let errorModel = try? JSONDecoder().decode(LoginError.self, from: data)
                DispatchQueue.main.async {
                    self.valueOfId = model?.data.userId
                    self.login = model?.data.loginStatus
                    UserDefaults.standard.set(self.valueOfId, forKey: "keyId")
                    if errorModel?.errorCode != nil {
                        self.displayAlert(message: errorModel?.message ?? "")
                    }
                    else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                        self.navigationController?.pushViewController(tabBarVC, animated: true)
                    }
                    
                   
                
                }
            
        }
        
            
           
        }
    
}
  
        func displayAlert(message : String)
        {
            let messageVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
            present(messageVC, animated: true) {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (_) in
                    messageVC.dismiss(animated: true, completion: nil)})
                
            }
        }
    
    
    
    
        
}

