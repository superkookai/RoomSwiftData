//
//  UIColorValueTransformer.swift
//  RoomSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import Foundation
import SwiftUI

@objc(UIColorValueTransformer)
class UIColorValueTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        UIColor.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        true
    }
    
    //return data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    //return UIColor
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data as Data)
            return color
        } catch {
            return nil
        }
    }
}

extension UIColorValueTransformer {
    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: UIColorValueTransformer.self))

    /// Registers the value transformer with `ValueTransformer`.
    public static func register() {
        let transformer = UIColorValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
