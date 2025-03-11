//
//  ColorTransformer.swift
//  RoomSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import Foundation
import SwiftUI

class ColorTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? Color else { return nil }
        
        let components = extractColorComponents(from: color)
        return try? JSONEncoder().encode(components)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data,
                let components = try? JSONDecoder().decode(ColorComponents.self, from: data) else {
            return nil
        }
        
        return Color(red: components.red, green: components.green, blue: components.blue, opacity: components.opacity)
    }
    
    // Helper methods and structures
    private func extractColorComponents(from color: Color) -> ColorComponents {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // This only works for colors in the RGB color space
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return ColorComponents(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
    
    private struct ColorComponents: Codable {
        let red, green, blue, opacity: Double
    }
}
