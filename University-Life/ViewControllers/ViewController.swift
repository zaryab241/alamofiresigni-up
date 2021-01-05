//
//  ViewController.swift
//  University-Life
//
//  Created by Zaryab on 1/2/21.
//

import UIKit
import Foundation
import Alamofire

typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void
class ViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var signUpOutlet: UIButton!
    //MARK:- Properties
//    var arr: String
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lable1.layer.borderColor = UIColor(named: "1")?.cgColor
        lable1.clipsToBounds = true
        mainView.backgroundColor = UIColor(named: "1")
        mainView.layer.cornerRadius = 30
        view2.layer.cornerRadius = 25
        view2.backgroundColor = UIColor(named: "view2color")
        emailField.clipsToBounds = false
        emailField.borderStyle = .none
        passwordField.clipsToBounds = false
        passwordField.borderStyle = .none
        loginBtnOutlet.backgroundColor = UIColor(named: "logincolor")
        loginBtnOutlet.layer.cornerRadius = 10
        
        
    }
    
    //MARK:- IBActions
    @IBAction func signUpBtn(_ sender: Any) {
        
        let i = storyboard?.instantiateViewController(withIdentifier: "signUpView")as! signUpViewController
        navigationController?.pushViewController(i, animated: true)
        
    }
    @IBAction func loginBtn(_ sender: Any) {
        if (emailField.text?.isEmpty)! ||
                   (passwordField.text?.isEmpty)!
               {
            displayMessage(userMessage: "All fields are required to fill in")
                   return
             }
        else{
            
            let email = emailField.text!
            let password = passwordField.text!
            let register = loginModel(txtEmailID: email, txtPassword: password)
            callingLoginAPI(register: register) { (Result) in
                switch Result{
                case .success(let json): break
                    let name = (json as! loginResponseModel).messagetype
                }
                
            }
             
        }
        
    }
    
   
    //MARK:- Customs
    
    func displayMessage(userMessage: String){
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                           // Code in this block will trigger when OK button tapped.
                           print("Ok button tapped")
                           DispatchQueue.main.async
                               {
                                   self.dismiss(animated: true, completion: nil)
                           }
                       }
                       alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
        
    }
    func callingLoginAPI(register: loginModel, completionHandler: @escaping (Bool, String) ->() ){
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(login_URL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers) .response { response in
             
            switch response.result{
            case .success(let data):
//                let value: AnyObject = response.result as AnyObject
//                print(value)
                do{
                    let json =  try JSONDecoder().decode(loginResponseModel.self, from: data!)
                    print(json)
                    
                    if response.response?.statusCode == 200{
//                        completionHandler(.success(json), <#String#>)
                    
                    

            }catch{
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
  }
 }//func ends her
}


