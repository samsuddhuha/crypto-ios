//
//  ControllerExtension.swift
//  crypto
//
//  Created by Samsud Dhuha on 28/07/21.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController{
    
    func showLoadingView(_ message:String? = nil){
        startAnimating(CGSize(width: 40, height: 40), message: message, messageFont: UIFont.boldSystemFont(ofSize: 18), type: .ballPulse)
    }
    
    func showLoadingView(state:Bool,_ message: String? = nil){
        if state{
             startAnimating(CGSize(width: 40, height: 40), message: message, messageFont: UIFont.boldSystemFont(ofSize: 18), type: .ballPulse)
        }else{
            stopAnimating()
        }
    }
    
    func hideLoadingView() {
        stopAnimating()
    }
    
}

extension UIViewController:NVActivityIndicatorViewable{
    
}
