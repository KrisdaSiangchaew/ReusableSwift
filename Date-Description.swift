//
//  Date-Description.swift
//  WorkingWithDates
//
//  Created by Kris Siangchaew on 2/11/2563 BE.
//

import Foundation

extension Date {
    func description(
        relativeTo referenceDate: Date,
        dateStyle: DateFormatter.Style,
        timeStyle: DateFormatter.Style,
        locale: String? = nil) -> String {
        
        let twoDaysAgo: Double = -180_001
        let timeSince = self.timeIntervalSince(referenceDate)
        
        if timeSince < twoDaysAgo {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            formatter.timeStyle = timeStyle
            if let localeIdentifier = locale { formatter.locale = Locale(identifier: localeIdentifier)}
            return formatter.string(from: self)
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            if let localeIdentifier = locale { formatter.locale = Locale(identifier: localeIdentifier)}
            return formatter.localizedString(for: self, relativeTo: referenceDate)
        }
    }
}
