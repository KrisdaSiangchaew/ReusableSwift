//
//  main.swift
//  StringInterpolation
//
//  Created by Krisda on 16/6/2564 BE.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(signed value: Int) {
        let stringForm = String(value)
        
        if value > 0 {
            appendLiteral("+\(stringForm)")
        } else {
            appendLiteral("\(stringForm)")
        }
    }
    
    mutating func appendInterpolation(joined values: [String]) {
        let joined = ListFormatter.localizedString(byJoining: values)
        appendLiteral(joined)
    }
    
    mutating func appendInterpolation(
        _ date: Date,
        dateStyle: DateFormatter.Style = .short,
        timeStyle: DateFormatter.Style = .none
    ) {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        appendLiteral(formatter.string(from: date))
    }
    
    mutating func appendInterpolation(_ function: @autoclosure () -> CustomStringConvertible, count: Int, separator: String = ",") {
        let result = (0..<count).map { _ in function().description }
        
        appendLiteral(result.joined(separator: separator))
    }
    
    mutating func appendInterpolation<T: Encodable>(_ object: T) {
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(object) {
            let string = String(decoding: data, as: UTF8.self)
            appendLiteral(string)
        }
    }
    
    mutating func appendInterpolation(_ url: URL) {
        let address = url.absoluteString
        
        let string = "<a href: http://\(address)> \(address) </a>"
        
        appendLiteral(string)
    }
}

print(-5)

print("\(signed: 3)")

print("\(joined: ["Kris", "Fon", "Kad"])")

print("\(Date(), dateStyle: .short, timeStyle: .long)")

print("\("Luv", count: 3, separator: "😘")")

struct Group: Encodable {
    var users: [User]
}
struct User: Encodable {
    let name: String
    let age: Int
}

let kris = User(name: "Kris", age: 52)
let kad = User(name: "Kad", age: 32)
let fon = User(name: "Fon", age: 49)

var users = Group(users: [kris, kad, fon])

print("\(users)")

let url = URL(string: "www.krisda.com")!

print("\(url)")

