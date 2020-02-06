//
//  InputValidator.swift
//  ReactiveLogin
//
//  Created by Song Zixin on 2020/1/30.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import Foundation

class InputValidator {
    
    class func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

    class func isValidEmail(_ email: String) -> Bool {
        let re = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .caseInsensitive)
        
        if let re = re {
            let range = NSMakeRange(0, email.lengthOfBytes(using: String.Encoding.utf8))
            let result = re.matches(in: email, options: .reportProgress, range: range)
            return result.count > 0
        }
        return false
    }
    
    class func isValidDate(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let compare = calendar.compare(date, to: Date(), toGranularity: .day)
        
        return compare == .orderedAscending
    }
}

