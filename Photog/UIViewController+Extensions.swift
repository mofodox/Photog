//
//  UIViewController+Extensions.swift
//  Photog
//
//  Created by Khairul Akmal on 12/06/2015.
//  Copyright (c) 2015 Khairul Akmal. All rights reserved.
//

import Foundation

extension UIViewController {
    func showAlert(message: String) {
        self.showAlert(titleForAlert: "Uh oh!", messageForAlert: message)
    }
    
    func showAlert(titleForAlert title: String, messageForAlert message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        var alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
