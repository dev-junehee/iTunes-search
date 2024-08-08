//
//  UIView+.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit

extension UIView: Reusable {
    
    static var id: String {
        return String(describing: self)
    }
    
}
