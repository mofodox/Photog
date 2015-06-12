//
//  String+Extensions.swift
//  Photog
//
//  Created by Khairul Akmal on 12/06/2015.
//  Copyright (c) 2015 Khairul Akmal. All rights reserved.
//

import Foundation

extension String {
    func isEmailAddress() -> Bool {
        var predicate = self.predicateForEmail()
        
        return predicate.evaluateWithObject(self)
    }
    
    func predicateForEmail() -> NSPredicate {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression)
    }
}
