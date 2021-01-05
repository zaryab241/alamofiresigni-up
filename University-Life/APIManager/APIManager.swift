//
//  APIManager.swift
//  University-Life
//
//  Created by Zaryab on 1/5/21.
//

import Foundation
import Alamofire



class APIManger{
    
    static let shareInstance = APIManger()
    
//    func callingRegisterAPI(register: registerModel, completionHandler: @escaping (Bool)->()){
//        let headers: HTTPHeaders = [.contentType("application/json")]
//        
//        AF.request(register_URL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers) .response { response in
//             
//            switch response.result{
//            case .success(let data):
//                do{
//                let json =  try JSONSerialization.jsonObject(with: data!, options: [])
//                print(json)
//                    
//                    if response.response?.statusCode == 200{
//                        completionHandler(true)
//                    }
//                    else{
//                        completionHandler(false)
//                    }
//                    
//                    
//            }catch{
//                    
//                    
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//            
//  }
// }//func ends here
}//class ends here


    
    

