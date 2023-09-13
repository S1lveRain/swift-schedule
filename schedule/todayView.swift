import SwiftUI

import Foundation

struct Subject: Codable {
    let title: String
    let type: String?
}

struct Teacher: Codable {
    let name: String
    let degree: String?
    let photo_url: String?
    let fullName: String?
    let cathedra: String?
    let additional: String?
}

struct LessonDataGroup: Codable {
    let subject: Subject
    let teacher: Teacher
    let cabinet: String
}

struct Time: Codable {
    let from: String
    let to: String
}

enum WeekData: Codable {
    case lessonDataGroup(LessonDataGroup)
    case none(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let lessonDataGroup = try? container.decode(LessonDataGroup.self) {
            self = .lessonDataGroup(lessonDataGroup)
        } else if let none = try? container.decode(String.self) {
            self = .none(none)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Mismatched Types")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .lessonDataGroup(let lessonDataGroup):
            try container.encode(lessonDataGroup)
        case .none(let none):
            try container.encode(none)
        }
    }
}

struct DataGroup: Codable {
    let topWeek: WeekData?
    let lowerWeek: WeekData?
}



struct LessonGroup: Codable {
    let id: String
    let count: String
    let time: Time
    let data: DataGroup
}

struct DayGroup: Codable {
    let dayOfWeek: String
    let isWeekend: Bool?
    let lessons: [LessonGroup]
}

struct ScheduleResponse: Codable {
    let result: ResultScheduleByGroup
}

typealias ResultScheduleByGroup = [DayGroup]



class ScheduleViewModel: ObservableObject {
    @Published var schedule: ResultScheduleByGroup?
    
    func fetchSchedule() {
        guard var urlComponents = URLComponents(string: "https://back-my-ati.anto-mshk.ru/schedule/group") else { return print("Wrong url components") }

        urlComponents.queryItems = [
            URLQueryItem(name: "name", value: "ВИС31")
        ]

        guard let url = urlComponents.url else { return print("Wrong url") }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(String(describing: error))")
                return
            }

            do {
                let scheduleResponse = try JSONDecoder().decode(ScheduleResponse.self, from: data)
                DispatchQueue.main.async {
                    self.schedule = scheduleResponse.result
                    print("Data fetched successfully: \(scheduleResponse.result)")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }

        task.resume()
    }
}



struct TodayView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    
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
                    if let todaySchedule = viewModel.schedule?.first(where: { $0.dayOfWeek == "2" }) {
                        ForEach(todaySchedule.lessons, id: \.id) { lesson in
                            if case .lessonDataGroup(let lowerWeekData) = lesson.data.topWeek {
                                SubjectCardView(
                                    teacherName: lowerWeekData.teacher.name,
                                    subjectName: lowerWeekData.subject.title,
                                    roomNumber: "Кабинет \(lowerWeekData.cabinet)",
                                    lectureType: lowerWeekData.subject.type ?? "Не указано",
                                    startTime: lesson.time.from,
                                    endTime: lesson.time.to
                                )
                                .padding(.bottom, 8)
                            }
                        }
                    } else {
                        Text("Нет данных для отображения")
                            .foregroundColor(.gray)
                    }

                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchSchedule()
        }
    }
}



struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
