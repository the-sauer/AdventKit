//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//
//  Copyright 2025 Hendrik Sauer

import SwiftUI

public struct CalendarView<DayView: View>: View {
    @ViewBuilder let contentForDay: (Int) -> DayView

    private let firstOfDecember: Date
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    public init(_ year: Int, _ contentForDay: @escaping (Int) -> DayView) {
        self.contentForDay = contentForDay
        self.firstOfDecember = Calendar(identifier: .gregorian)
            .date(from: DateComponents(year: year, month: 12, day: 1))!
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...24, id: \.self) { day in
                        DoorNavigationLink(day, contentForDay(day))
                            .disabled(Date.now < firstOfDecember.addingTimeInterval(Double((day - 1) * 24 * 60 * 60)))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CalendarView(2025) { day in
        Text("Hello its day \(day)")
    }
}
