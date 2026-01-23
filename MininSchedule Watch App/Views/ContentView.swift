//
//  ContentView.swift
//  MininSchedule Watch App
//
//  Created by Eiztrips on 18.01.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ScheduleViewModel()
    @State private var selectedDate = Date()
    @State private var group = "ПИМ-24-1"

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Группа")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    TextField("ПИМ-24-1", text: $group)
                }

                HStack {
                    Button {
                        withAnimation {
                            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }

                    Spacer()

                    Text(selectedDate.formatted(.dateTime.day().month(.abbreviated).weekday(.short)))
                        .font(.headline)
                        .minimumScaleFactor(0.8)

                    Spacer()

                    Button {
                        withAnimation {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.vertical, 4)

                Button("Загрузить") {
                    Task {
                        await vm.load(
                            group: group,
                            date: formattedDate(selectedDate)
                        )
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                if vm.isLoading {
                    ProgressView()
                }

                if let error = vm.errorText {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                if !vm.lessons.isEmpty && vm.errorText == nil {
                    LazyVStack(spacing: 8) {
                        ForEach(vm.lessons) { lesson in
                            LessonView(lesson: lesson)
                        }
                    }
                } else if vm.lessons.isEmpty && !vm.isLoading && vm.errorText == nil {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("На этот день пар нет")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
            }
            .padding()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

// #Preview {
//    ContentView()
// }
