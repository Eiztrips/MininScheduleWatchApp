//
//  Models.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import Foundation

struct Lesson: Codable, Identifiable {
    var id = UUID()
    let date: String
    let couple_number: String
    let start_time: String
    let end_time: String
    let discipline: String
    let teacher: String
    let place: String
    let lesson_type: String

    enum CodingKeys: String, CodingKey {
        case date, couple_number, start_time, end_time, discipline, teacher, place, lesson_type
    }

    init(
        date: String,
        couple_number: String,
        start_time: String,
        end_time: String,
        discipline: String,
        teacher: String,
        place: String,
        lesson_type: String
    ) {
        self.date = date
        self.couple_number = couple_number
        self.start_time = start_time
        self.end_time = end_time
        self.discipline = discipline
        self.teacher = teacher
        self.place = place
        self.lesson_type = lesson_type
    }
}

struct ScheduleResponse: Codable {
    let ok: Bool
    let date: String
    let schedule: [Lesson]
}

struct ErrorResponse: Codable {
    let ok: Bool
    let details: String
}
