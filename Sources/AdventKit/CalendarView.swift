//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright 2025 Hendrik Sauer

import SwiftUI

public struct CalendarView<DayView: View>: View {
    @ViewBuilder let contentForDay: (Int) -> DayView

    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...24, id: \.self) { day in
                        DoorNavigationLink(day, contentForDay(day))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CalendarView(contentForDay: { day in Text("Hello its day \(day)")})
}
