//
//  ScrollContentFrameTracker.swift
//  Sample_SnsApp
//
//  Created by ウルトラ深瀬 on 25/11/24.
//

import SwiftUI

struct ContentFrameTrackableScrollView<Content: View>: View {
    let scrollDirections: Axis.Set
    let content: Content
    let onScroll: ((CGRect) -> Void)
    
    init(
        scrollDirections: Axis.Set,
        @ViewBuilder content: () -> Content,
        onScroll: @escaping ((CGRect) -> Void)
    ) {
        self.scrollDirections = scrollDirections
        self.content = content()
        self.onScroll = onScroll
    }
    
    var body: some View {
        return ScrollView(scrollDirections) {
            content.background {
                GeometryReader { geometry in
                    Color.clear.onChange(of: geometry.frame(in: .global), { _, newFrame in
                        onScroll(newFrame)
                    })
                }
            }
        }
    }
}
