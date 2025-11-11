//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright 2025 Hendrik Sauer

import SwiftUI

struct DoorNavigationLink<V>: View where V: View {
    let day: Int
    let puzzleView: V

    init(_ day: Int, _ puzzleView: V) {
        self.day = day
        self.puzzleView = puzzleView
    }

    var body: some View {
        if #available(macOS 26.0, *), #available(iOS 26.0, *) {
            NavigationLink(destination: puzzleView) {
                Text("\(day)")
                    .font(.custom("Academy Engraved LET Plain:1.0", size: 80))
                    .buttonStyle(.plain)
            }
            .padding()
            .glassEffect(in: .rect(cornerRadius: 16.0))
            .padding()
        } else {
            NavigationLink(destination: puzzleView) {
                Text("\(day)")
                    .font(.custom("Academy Engraved LET Plain:1.0", size: 80))
                    .buttonStyle(.plain)
            }
            .padding()
        }
    }
}
