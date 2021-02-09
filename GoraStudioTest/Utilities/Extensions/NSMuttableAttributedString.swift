//
//  NSMuttableAttributedString.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

// MARK: - Used by set bold and normal attributes for string
extension NSMutableAttributedString {
    
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        return self
    }

    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        return self
    }
    
    static func getAttributedText(bold: String, normal: String) -> NSMutableAttributedString {
        let resultString = NSMutableAttributedString()
        resultString.bold(bold)
        resultString.normal(normal)
        return resultString
    }
}
