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


/*EVENT ROW WITHOUT IMAGE
 struct EventRowView: View {
    let event: Evenement
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.name)
                .font(.headline)
            Text(event.description)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: "calendar.circle")
                Text(event.date)
                Text(event.price)
            }
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}*/


//EVENT ROW WITH IMAGE
struct EventRowView: View {
    let event: Evenement
   
    var body: some View {
        HStack {
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
            .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(event.name)
                    .font(.headline)
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack {
                    Image(systemName: "calendar.circle")
                    Text(event.date)
                }
                .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}




struct EventsUIView: View {
    @ObservedObject var viewModel = EventViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.events, id: \.name) { event in
                        EventRowView(event: event)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("All Events")
        }
        .onAppear {
            viewModel.retrieveEvents() /*{ result in
                                switch result {
                                case .success: break
                                    self.viewModel.events = events
                                    // Handle successful retrieval of events
                                case .failure(let error): break
                                    // Handle error
                                }
                            }*/
        }
    }
}







