//
//  EventsUIView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 26/4/2023.
//

import SwiftUI


struct EventsUIView_Previews: PreviewProvider {
    static var previews: some View {
        EventsUIView()
    }
}





struct EventRowView: View {
    let event: Evenement
    let dateFormatter = DateFormatter()

    var body: some View {
        NavigationLink(destination: EventDetailView(event: event)) {
            HStack(spacing: 10) { // set spacing between the image and text
                // Display the image
                AsyncImage(url: URL(string: event.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(event.name)
                        .font(.headline)
                        .lineLimit(1) // limit to one line to avoid text overflowing
                    Text(event.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2) // limit to two lines to avoid text overflowing
                    HStack {
                        Image(systemName: "calendar.circle")
                        Text(dateFormatter.string(from: Date())) // use the current date for now, you can update it later
                            .lineLimit(1) // limit to one line to avoid text overflowing
                    }
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // make text stretch to fill the remaining space
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height: 100) // set a fixed height for the row
        }
        .onAppear {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
    }
}





struct EventsUIView: View {
    @ObservedObject var viewModel = EventViewModel()
    @State private var showAddEventView = false
    
    var body: some View {
        NavigationView {
            VStack{
            ScrollView {
                
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.events, id: \.name) { event in
                        EventRowView(event: event)
                    }
                }
                .padding(.horizontal)
            }.padding(.top, 10)
                
            .navigationTitle("Top Events")
                 }.navigationBarItems(trailing: AddEventButton())        }
        .onAppear {
            viewModel.retrieveEvents()
        }
    }
}



struct AddEventButton: View {
    @State private var showAddEventView = false
    
    var body: some View {
        Button(action: {
            self.showAddEventView = true
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.red)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 5)
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .medium))
            }
        }
        .sheet(isPresented: $showAddEventView) {
            AddEventView()
        }
        .padding(.trailing, 20)
        .padding(.bottom, 0) // Add padding to adjust the button's position
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing) // Align the button to the bottom-right corner
    }
}






struct EventDetailView: View {
    let event: Evenement
    @State private var date = Date()

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AsyncImage(url: URL(string: event.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width)
                                .clipped()
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    Text(event.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(event.description)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "calendar.circle")
                        DatePicker(selection: $date, displayedComponents: [.date]) {
                            Text("Event Date")
                        }
                        .foregroundColor(.secondary)
                    }
                    .padding(.top, 10)
                    
                    // Add additional event details here, such as location, time, and so on
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle(event.name)
    }
}
