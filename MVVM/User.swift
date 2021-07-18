//
//  User.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 17/7/21.
//

import Foundation
import CoreVideo

struct User {
    
    private(set) var username: String = ""
    let usernameValidator = UsernameValidator()
    
    mutating func update(toPossibleUserName possibleUserName: String) -> Bool {
        guard usernameValidator.isValid(text: possibleUserName) else {
            return false
        }
        
        username = possibleUserName
        return true
    }
    
}


struct UsernameValidator {
    func isValid(text: String) -> Bool {
        let result = text.range(of: emailPattern, options: .regularExpression)
        return (result != nil)
    }
    
    private let emailPattern = #"^\S+@\S+\.\S+$"#

}
