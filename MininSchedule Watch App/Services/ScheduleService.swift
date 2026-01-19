//
//  ScheduleService.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import Foundation

final class ScheduleService {
    func fetchSchedule(group: String, date: String) async throws -> [Lesson] {
        let urlString = "https://eiztrips.dev/api/schedule/\(group)/\(date)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        // print(String(data: data, encoding: .utf8) ?? "no response")
        
        let decoded = try JSONDecoder().decode(ScheduleResponse.self, from: data)

        if decoded.ok {
            if let firstLesson = decoded.schedule.first {
                UserDefaults.standard.set(try? JSONEncoder().encode(decoded), forKey: "schedule\(firstLesson.date)")
                }
                return decoded.schedule
            } else {
                return []
        }
    }
    
    func getCachedSchedule(date: String) throws -> [Lesson] {
        guard let data = UserDefaults.standard.data(forKey: "schedule\(date)") else {
            throw URLError(.badServerResponse)
        }
    
        let decoded = try JSONDecoder().decode(ScheduleResponse.self, from: data)
        return decoded.schedule
    }
}
