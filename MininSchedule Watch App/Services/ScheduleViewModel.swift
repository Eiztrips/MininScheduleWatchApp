//
//  ScheduleViewModel.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import Foundation
import Combine

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var isLoading = false
    @Published var errorText: String?

    let service = ScheduleService()

    func load(group: String, date: String) async {
        // print("Загрузка расписания для группы: \(group), дата: \(date)")
        isLoading = true
        errorText = nil

        do {
            lessons = try await service.fetchSchedule(group: group, date: date)
            // print("Загружено пар: \(lessons.count)")
        } catch {
            // print("Ошибка загрузки: \(error.localizedDescription)")
            errorText = "Used cached data"
            do {
                lessons = try service.getCachedSchedule(date: date)
            } catch {
                errorText = "Failed to load schedule"
            }
        }

        isLoading = false
    }
}
