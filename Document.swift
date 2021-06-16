//
//  Document.swift
//  CustomPropertyWrapper
//
//  Created by Kris Siangchaew on 15/10/2563 BE.
//

import SwiftUI

@propertyWrapper struct Document: DynamicProperty {
    @State private var value = ""
    private let url: URL
    
    var wrappedValue: String {
        get {
            value
        }
        
        nonmutating set {
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch {
                print("Failed to write output")
            }
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    init(_ filename: String) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        url = paths[0].appendingPathComponent(filename)
        
        let initialText = (try? String(contentsOf: url)) ?? ""
        _value = State(wrappedValue: initialText)
    }
}
