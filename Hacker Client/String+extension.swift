//
//  String+extension.swift
//  Hacker Client
//
//  Created by Admin on 8/8/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    init?(htmlEncodedString: String){
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributeString = try NSAttributedString(data: data,
                                                         options: options,
                                                         documentAttributes: nil)
            self = attributeString.string
        } catch {
            print("Error: \(error)")
            self =  htmlEncodedString
        }
    }
}
