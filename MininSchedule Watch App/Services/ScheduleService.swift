//
//  ScheduleService.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import Foundation

final class ScheduleService {
    func fetchSchedule(group: String, date: String) async throws -> [Lesson] {
        guard
            let apiPassword = Bundle.main.object(forInfoDictionaryKey: "API_PASSWORD") as? String,
            let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String
        else {
            throw URLError(.userAuthenticationRequired)
        }

        guard var components = URLComponents(string: "https://\(apiBaseURL)/api/schedule/\(group)/\(date)") else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: "password", value: apiPassword)
        ]

        guard let url = components.url else {
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

