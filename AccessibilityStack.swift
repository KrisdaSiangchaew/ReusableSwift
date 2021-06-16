//
//  AccessibilityStack.swift
//  TipRemake
//
//  Created by Krisda on 15/6/2564 BE.
//

import SwiftUI

struct AccessibilityStack<Content: View>: View {
    @Environment(\.sizeCategory) var size
    
    var spacing: Optional<CGFloat>
    var horizontalAlignment: HorizontalAlignment
    var verticalAlignment: VerticalAlignment
    var verticalStartSize: ContentSizeCategory
    let content: () -> Content
    
    init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        verticalStartSize: ContentSizeCategory = .medium,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.verticalStartSize = verticalStartSize
        self.content = content
    }
    
    var body: some View {
        if size >= verticalStartSize {
            VStack(alignment: horizontalAlignment, spacing: spacing, content: content) }
        else {
            HStack(alignment: verticalAlignment, spacing: spacing, content: content)
        }
    }
}
