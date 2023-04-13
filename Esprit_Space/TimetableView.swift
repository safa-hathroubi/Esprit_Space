//
//  TimetableView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 13/4/2023.
//


struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}



import SwiftUI

struct TimetableView: View {
    let daysOfWeek = ["M", "Tu", "W", "Th", "F"]
    let timesOfDay = ["9:00 AM", "10:30 AM", "10:45 AM", "12:00 AM",  "1:30 PM", "2:45 PM", "3:00 PM", "4:45 PM"]
    
    let timetable = [
        ["", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", ""],
        ["", "", "", "", "", "", "", "", "", ""]
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Time")
                    .font(.headline)
                    .frame(width: 60)
                
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Divider()
            
            ScrollView(.vertical) {
                ForEach(0..<timesOfDay.count, id: \.self) { timeIndex in
                    HStack {
                        Text(timesOfDay[timeIndex])
                            .frame(width: 60)
                        
                        ForEach(0..<daysOfWeek.count, id: \.self) { dayIndex in
                            Text(timetable[dayIndex][timeIndex])
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
