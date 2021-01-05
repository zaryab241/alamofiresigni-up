//
//  signUpViewController.swift
//  University-Life
//
//  Created by Zaryab on 1/3/21.
//

import UIKit
import Alamofire
struct jsonStruct: Decodable{

    let message: String

}

class signUpViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    //MARK:- Properties
    
//    private var arr = [jsonStruct]()
//    let str = "{\"message"]"
    
    //MARK:- lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backgroundColor = UIColor(named: "1")
        mainView.layer.cornerRadius = 30
        signUp.backgroundColor = UIColor(named: "logincolor")
        signUp.layer.cornerRadius = 10
        view2.layer.cornerRadius = 25
        view2.backgroundColor = UIColor(named: "view2color")
        setUp()
       
    }
    //MARK:- IBActions
    
    @IBAction func leftArrowBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        if (firstNameField.text?.isEmpty)! ||
                   (lastNameField.text?.isEmpty)! ||
                   (emailField.text?.isEmpty)! ||
                   (passField.text?.isEmpty)!
               {
                   displayMessage(userMessage: "All fields are quired to fill in")
                   return


        }
        else{
//            register()
            let fname = firstNameField.text!
            let lname = lastNameField.text!
            let email = emailField.text!
            let password = passField.text!
            let register = registerModel(FirstName: fname, LastName: lname, Email: email, Password: password)
//            APIManger.shareInstance.callingRegisterAPI(register: register) {
            callingRegisterAPI(register: register)
//            (isSuccess) in
//                if isSuccess{
//                    self.displayMessage(userMessage: "User Registered. Please confirm email and move to login page")
////                    self.navigationController?.popViewController(animated: true)
//                }
//                else{
//                    self.displayMessage(userMessage: "There is a error")
//                }
            
             }
    }
    //MARK:- Customs
    
    func setUp(){
        
        textField.styleTextField(firstNameField, Width: view)
        textField.styleTextField(lastNameField, Width: view)
        textField.styleTextField(emailField, Width: view)
        textField.styleTextField(passField, Width: view)
        
    }
   
    func register(){
        
        let myUrl = URL(string: "https://university.events/universityeventsstagingevnvironment/api/saveregistration")
                var request = URLRequest(url:myUrl!)
                request.httpMethod = "POST"// Compose a query string
                request.addValue("application/json", forHTTPHeaderField: "content-type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let postString = ["FirstName": firstNameField.text!,
                                  "LastName": lastNameField.text!,
                                  "Email": emailField.text!,
                                  "Password": passField.text!,
                                  ] as [String: String]
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                    displayMessage(userMessage: "Something went wrong. Try again.")
                    return
                }
                
             let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                  
                if error != nil
                {
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    print("error=\(String(describing: error))")
                    return
                }
                
                
                //Let's convert response sent from a server side code to a NSDictionary object:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        
                        let userId = parseJSON["userId"] as? String
                        print("User id: \(String(describing: userId!))")
                        
                        if (userId?.isEmpty)!
                        {
                            // Display an Alert dialog with a friendly error message
                            self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                            return
                        } else {
                            self.displayMessage(userMessage: "Successfully Registered a New Account. Please proceed to Sign in")
                        }
                        
                    } else {
                        //Display an Alert dialog with a friendly error message
                        self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    }
                } catch {
                    
                    // Display an Alert dialog with a friendly error message
                    self.displayMessage(userMessage: "Could not successfully perform this request. Please try again later")
                    print(error)
                }
                }
                
                task.resume()
                
            }
            
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
        
    }//func ends here
    
    func callingRegisterAPI(register: registerModel){
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        AF.request(register_URL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers) .response { response in
             
            switch response.result{
            case .success(let data):
                do{
                let json =  try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
//                    let message = (json as! jsonStruct).message
//                    self.displayMessage(userMessage: "\(message)")
       
//                    self.arr = try JSONDecoder().decode([jsonStruct].self, from: data!)
//                    let i = self.arr.first
//                    self.displayMessage(userMessage: "\(i)")
            }catch{
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
  }
 }//func ends here
}


    

