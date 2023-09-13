import SwiftUI

struct SubjectCardView: View {
    
    var teacherName: String
    var subjectName: String
    var roomNumber: String
    var lectureType: String
    var startTime: String
    var endTime: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(subjectName)
                    .font(.headline)
                    .fontWeight(.medium)
                Spacer()
                Text("\(startTime) - \(endTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack {
                Text("Преподаватель:")
                    .font(.subheadline)
                Spacer()
                Text(teacherName)
                    .font(.subheadline)
            }
            
            HStack {
                Text("Кабинет:")
                    .font(.subheadline)
                Spacer()
                Text(roomNumber)
                    .font(.subheadline)
            }
            
            HStack {
                Text("Тип лекции:")
                    .font(.subheadline)
                Spacer()
                Text(lectureType)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding([.horizontal, .bottom])
    }
}

struct SubjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectCardView(
            teacherName: "Алексей Иванов",
            subjectName: "Математический анализ",
            roomNumber: "Кабинет 404",
            lectureType: "Лекция",
            startTime: "09:00",
            endTime: "10:30"
        )
    }
}
