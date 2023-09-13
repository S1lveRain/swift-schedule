import SwiftUI

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
                    SubjectCardView(
                        teacherName: "Алексей Иванов",
                        subjectName: "Математический анализ",
                        roomNumber: "Кабинет 404",
                        lectureType: "Лекция",
                        startTime: "09:00",
                        endTime: "10:30"
                    )
                    
                    SubjectCardView(
                        teacherName: "Марина Петрова",
                        subjectName: "Линейная алгебра",
                        roomNumber: "Кабинет 301",
                        lectureType: "Семинар",
                        startTime: "10:45",
                        endTime: "12:15"
                    )
                    
                    SubjectCardView(
                        teacherName: "Иван Сидоров",
                        subjectName: "Физика",
                        roomNumber: "Кабинет 202",
                        lectureType: "Лабораторная работа",
                        startTime: "12:30",
                        endTime: "14:00"
                    )
                    
                    SubjectCardView(
                        teacherName: "Елена Волкова",
                        subjectName: "Программирование",
                        roomNumber: "Кабинет 103",
                        lectureType: "Лекция",
                        startTime: "14:15",
                        endTime: "15:45"
                    )
                }
                .padding()
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
