//
//  ContentView.swift
//  schedule
//
//  Created by Raindesu on 13.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Сегодня", systemImage: "house.fill")
                }
            
            ScheduleView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            
            TeachersView()
                .tabItem {
                    Label("Преподаватели", systemImage: "person.2.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}

struct TodayView: View {
    let currentDate: String = {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }()
        
        var body: some View {
            VStack {
                Text(currentDate)
                    .font(.title)
                    .padding()
                
                ScrollView {
                    VStack {
                        SubjectCardView(teacherName: "Алексей Иванов", subjectName: "Математический анализ", roomNumber: "Кабинет 404", lectureType: "Лекция")
                        SubjectCardView(teacherName: "Марина Петрова", subjectName: "Линейная алгебра", roomNumber: "Кабинет 301", lectureType: "Семинар")
                        SubjectCardView(teacherName: "Иван Сидоров", subjectName: "Физика", roomNumber: "Кабинет 202", lectureType: "Лабораторная работа")
                        SubjectCardView(teacherName: "Елена Волкова", subjectName: "Программирование", roomNumber: "Кабинет 103", lectureType: "Лекция")
                    }
                    .padding()
                }
            }
        }
    
}

struct ScheduleView: View {
    var body: some View {
        VStack {
            Text("Расписание")
                .padding()
        }
    }
}

struct TeachersView: View {
    var body: some View {
        VStack {
            Text("Преподаватели")
                .padding()
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Настройки")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
