//
//  LessonView.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    // todo: make styles more beautiful
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(lesson.couple_number) пара")
                .font(.headline)

            Text(lesson.discipline)
                .font(.subheadline)

            Text("\(lesson.start_time) - \(lesson.end_time)")
                .font(.caption)

            Text(lesson.place)
                .font(.caption2)

            Text(lesson.teacher)
                .font(.caption2)
        }
    }
}
