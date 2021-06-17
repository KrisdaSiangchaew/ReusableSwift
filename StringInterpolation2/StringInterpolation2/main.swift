//
//  main.swift
//  StringInterpolation2
//
//  Created by Krisda on 17/6/2564 BE.
//
// Building whole type from scratch using interpolation

import Foundation

// Create HTML type that can be created entirely from a string.
// This will act a bit like a templating engine in that we'll
// be able to mix plain HTML string with specific Swift types,
// adding custom interpolations for each value as needed.
struct HTML: ExpressibleByStringInterpolation {
    private(set) public var content: String
    
    init(stringInterpolation: StringInterpolation) {
        content = stringInterpolation.html
    }
    
    init(stringLiteral value: String) {
        content = value
    }
    
    struct StringInterpolation: StringInterpolationProtocol {
        var html = ""
        
        init(literalCapacity: Int, interpolationCount: Int) {
            let estimatedSize = literalCapacity + interpolationCount * 16
            html.reserveCapacity(estimatedSize)
        }
        
        mutating func appendLiteral(_ literal: String) {
            html.append(literal)
        }
        
        mutating func escapeAppend(_ content: String) {
            var replaced = content.replacingOccurrences(of: "&", with: "&amp")
            replaced = replaced.replacingOccurrences(of: "<", with: "&lt;")
            replaced = replaced.replacingOccurrences(of: ">", with: "&gt;")
            replaced = replaced.replacingOccurrences(of: "\"", with: "&quot;")
            html.append(replaced)
        }
        
        mutating func appendInterpolation(_ url: URL, content: String) {
            html.append("<a href=\"\(url.absoluteString)\">")
            escapeAppend(content)
            html.append("</a>")
        }
        
        mutating func appendInterpolation(code: String) {
            if code.contains("\n") {
                html.append("<pre><code>")
                escapeAppend(code)
                html.append("</code></pre>")
            } else {
                html.append("<code>")
                escapeAppend(code)
                html.append("</code>")
            }
        }
        
        mutating func appendInterpolation(_ date: Date, dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            html.append(formatter.string(from: date))
        }
    }
}

let url = URL(string: "www.krisda.com")!
let code = """
struct Student<Class>: Equatable {
    var name: String
}
"""
let date = Date()

let html: HTML = """
<html>
<body>
\(url, content: "Krisda Classroom")
\(code: code)
Class start date: \(date, timeStyle: .long)
</body>
</html>
"""

print(html.content)
