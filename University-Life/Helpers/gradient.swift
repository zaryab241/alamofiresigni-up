//
//  gradient.swift
//  University-Life
//
//  Created by Zaryab on 1/2/21.
//

import Foundation
import UIKit

extension UIView{
    func setGradientColor(colorOne:UIColor, colorTwo:UIColor)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
 }
    
}
class textField:UIViewController
{
    
    static func styleTextField(_ textfield: UITextField, Width: UIView) {
    let bottomline = CALayer()
    bottomline.frame = CGRect(x: 0, y: textfield.frame.height - 10, width: Width.frame.size.width - 150, height: 1)
    bottomline.backgroundColor = UIColor.init(red: 169/255, green: 169/255, blue: 169/255, alpha: 1).cgColor
    textfield.borderStyle = .none
    textfield.layer.addSublayer(bottomline)
        
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
        
    }
   
}

