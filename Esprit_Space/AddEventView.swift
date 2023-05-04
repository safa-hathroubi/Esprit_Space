//
//  AddEventView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 27/4/2023.
//

import SwiftUI
import UniformTypeIdentifiers



struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}


















struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var date = ""
    @State private var organizer = ""
    @State private var description = ""
    @State private var price = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @ObservedObject var viewModel = EventViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Poster")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button("Select Image") {
                        showingImagePicker = true
                    }
                    .padding()
                }

                Section(header: Text("Event Details")) {
                    TextField("Event Name", text: $name)
                    TextField("Event Date", text: $date)
                    TextField("Organizer", text: $organizer)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                }

                Section {
                    Button("Save") {
                        guard let image = image else {
                            print("Error: Image not selected")
                            return
                        }

                        viewModel.addEvent(name: name, image: image, date: date, organizer: organizer, description: description, price: price, iduser: "644a41000e704acac2c6a765")

                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Event")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }
}
