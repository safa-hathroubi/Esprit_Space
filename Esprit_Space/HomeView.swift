//
//  HomeView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 22/3/2023.
//
//
//  HomeView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 22/3/2023.
//

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



import SwiftUI

struct Event: Identifiable {
    var id = UUID()
    var name: String
    var date: String
}

let events = [
    Event(name: "Event 1", date: "Mon, Mar 28"),
    Event(name: "Event 2", date: "Tue, Mar 29"),
    Event(name: "Event 3", date: "Wed, Mar 30"),
    Event(name: "Event 4", date: "Thu, Mar 31"),
    Event(name: "Event 5", date: "Fri, Apr 1"),
    Event(name: "Event 6", date: "Sat, Apr 2"),
    Event(name: "Event 7", date: "Sun, Apr 3")
]

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(events) { event in
                        EventRow(event: event)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Events")
        }
    }
}

struct EventRow: View {
    var event: Event
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text(event.name)
                    .font(.headline)
                Text(event.date)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}
*/



import BottomBar_SwiftUI

import SwiftUI
/*
import BottomBar_SwiftUI


// array of items for the bottom bar
let items: [BottomBarItem] = [
    BottomBarItem(icon: "house.fill", title: "Home", color: .purple),
    BottomBarItem(icon: "heart", title: "Likes", color: .pink),
    BottomBarItem(icon: "magnifyingglass", title: "Search", color: .orange),
    BottomBarItem(icon: "person.fill", title: "Profile", color: .blue)
]

struct BasiccView: View {
    let item: BottomBarItem
    
    var detailText: String {
        "\(item.title) Detail"
    }
    
    */
    

    
    
    
    
    struct Event: Identifiable {
        let id = UUID()
        let name: String
        let image: String
        let date: Date
        let organizer: String
        let description: String
        let price: Double
        //let PS: String
    }
    
    struct HomeView: View {
        
        /////////////////////////////////// navigation --> homeview
        //var dismiss: () -> Void
        let events = [        Event(name: "Ramadhan Iftar", image: "ramadan-iftar", date: Date(), organizer: "Esprit Engineering", description: "Celebrate the start of Ramadhan with a delicious iftar shared together with your friends. PS: Hot mean + dessert included in the menu!", price: 10.00),        Event(name: "Charityyy Run", image: "Marathon_mock_poster", date: Date(), organizer: "Esprit IEEE Club", description: "Join us for a 5k run to raise money for local charities. All ages and skill levels welcome! ", price: 5.00)    ]
        
        var body: some View {
            NavigationView {
                List(events) { event in
                    NavigationLink(destination: EventDetail(event: event)) {
                        EventRow(event: event)
                    }
                }
                //.navigationTitle("Home/Events")
            }
        }
    }
    
    struct EventRow: View {
        let event: Event
        
        var body: some View {
            HStack {
                Image(event.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(event.name)
                        .font(.headline)
                    Text(event.organizer)
                        .font(.subheadline)
                    Text(event.date, style: .date)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    struct EventDetail: View {
        let event: Event
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Image(event.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Text(event.name)
                        .font(.title)
                        .padding()
                    
                    HStack {
                        Text("Organizer:")
                            .font(.headline)
                        Text(event.organizer)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Date:")
                            .font(.headline)
                        Text(event.date, style: .date)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        Text("$\(event.price, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    Text(event.description)
                        .padding()
                    
                    Spacer()
                }
            }
            .navigationBarTitle(event.name)
        }
    }
    
    
  
    
    
    
    
    
    
    
    struct HomeView_Previews: PreviewProvider {
        /////////////////////////////////// navigation --> homeview
        static var previews: some View {
            HomeView(/*dismiss: {
                isShowingHomeView = false
            }*/)
        }
    }
//}
