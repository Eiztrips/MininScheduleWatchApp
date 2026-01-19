//
//  LessonView.swift
//  MininSchedule
//
//  Created by Eiztrips on 18.01.2026.
//

import SwiftUI

struct LessonView: View {
    let lesson: Lesson

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(lesson.couple_number)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(8)
                    .background(Color.blue.opacity(0.3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(lesson.start_time)
                    Text(lesson.end_time)
                        .foregroundStyle(.secondary)
                }
                .font(.caption2)
                
                Spacer()
                
                Text(lesson.place)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
            }
            
            Divider()
            
            Text(lesson.discipline)
                .font(.headline)
                .lineLimit(nil)
            
            HStack {
                Image(systemName: "person.fill")
                    .font(.caption2)
                Text(lesson.teacher)
                    .font(.caption)
            }
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12) 
    }
}
