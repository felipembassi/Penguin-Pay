//
//  NSObject.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    public class var className: String {
        return String(describing: self)
    }
}
