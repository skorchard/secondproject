//
//  Utility.swift
//  MvvmSample
//
//  Created by M1086289 on 07/06/22.
//

import Foundation
struct Utility {
    
    static func isValidEmail(_ inputText: String) -> Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: inputText)
    }
    static func isValidPassword(_ inputText: String) -> Bool {
        let regularExpressionForPassword = "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$"
        let testPassword = NSPredicate(format: "SELF MATCHES %@", regularExpressionForPassword)
        return testPassword.evaluate(with: inputText)
    }
}
