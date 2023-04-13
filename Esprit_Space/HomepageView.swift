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
    BottomBarItem(icon: "house.fill", title: "Home", color: .purple),
    BottomBarItem(icon: "heart", title: "Likes", color: .pink),
    BottomBarItem(icon: "magnifyingglass", title: "Search", color: .orange),
    BottomBarItem(icon: "person.fill", title: "Profile", color: .blue)
]

struct BasicView: View {
    let item: BottomBarItem

    var detailText: String {
    "\(item.title) Detail"
}

var followButton: some View {
    Button(action: openTwitter) {
        VStack {
            Text("Developed by Bezhan Odinaev")
                .font(.headline)
                .foregroundColor(item.color)

            Text("@smartvipere75")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
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

func openTwitter() {
    guard let url = URL(string: "https://twitter.com/smartvipere75") else {
        return
    }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
}

var body: some View {
    VStack {
        Spacer()

        followButton

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
        case "Home":
            return AnyView(HomeView())
        case "Likes":
            return AnyView(NotesView())
        case "Profile":
            return AnyView(StudentProfileView())
        default:
            return AnyView(TimetableView())
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
