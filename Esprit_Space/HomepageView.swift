//
//  HomepageView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 13/4/2023.
//


//
//  HomepageView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 12/4/2023.
//




struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}



import SwiftUI
import BottomBar_SwiftUI

let items: [BottomBarItem] = [
    BottomBarItem(icon: "star.fill", title: "Events", color: .pink),
    BottomBarItem(icon: "list.bullet", title: "Notes", color: .purple),
    BottomBarItem(icon: "house.fill", title: "", color: .blue),
    BottomBarItem(icon: "square", title: "Timetable", color: .green),
    BottomBarItem(icon: "person.fill", title: "Profile", color: .orange)
]

struct BasicView: View {
    let item: BottomBarItem

    var detailText: String {
    "\(item.title) Detail"
}



var destination: some View {
    Text(detailText)
        .navigationBarTitle(Text(detailText))
}

var navigateButton: some View {
    NavigationLink(destination: destination) {
        ZStack {
            Rectangle()
                .fill(item.color)
                .cornerRadius(8)
                .frame(height: 52)
                .padding(.horizontal)

            Text("Navigate")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}



var body: some View {
    VStack {
        Spacer()


        Spacer()

        navigateButton
        }
    }
}

struct HomepageView : View {
    @State private var selectedIndex: Int = 0

    var selectedItem: BottomBarItem {
        items[selectedIndex]
    }

    
    var destinationView: AnyView {
        switch selectedItem.title {
        case "Events":
            return AnyView(HomeView())
        case "Notes":
            return AnyView(NotesView())
        case "Timetable":
            return AnyView(TimetableView())
        case "Profile":
            return AnyView(StudentProfileView())
        default:
            return AnyView(HomeView())
        }
    }

    
var body: some View {
        NavigationView {
            VStack {
                destinationView
                    .navigationBarTitle(Text(selectedItem.title))
                BottomBar(selectedIndex: $selectedIndex, items: items)
            }
        }
    }
}
