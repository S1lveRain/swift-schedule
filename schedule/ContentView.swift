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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
