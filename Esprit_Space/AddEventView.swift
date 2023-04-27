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



/*
struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var date = ""
    @State private var organizer = ""
    @State private var description = ""
    @State private var price = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Name", text: $name)
                    TextField("Date", text: $date)
                    TextField("Organizer", text: $organizer)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                }
                
                Section(header: Text("Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button("Select Image") {
                        showingImagePicker = true
                    }
                }
                
                Section {
                    Button("Save") {
                        guard let image = image else {
                            print("Error: Image not selected")
                            return
                        }
                        
                        addEvent(name: name, image: image, date: date, organizer: organizer, description: description, price: price, iduser: "644a41000e704acac2c6a765")
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Event")
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePicker(image: $image)
                    .edgesIgnoringSafeArea(.all)
            })
        }
    }
}*/










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
                Section(header: Text("Event Details")) {
                    TextField("Name", text: $name)
                    TextField("Date", text: $date)
                    TextField("Organizer", text: $organizer)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                }
                
                Section(header: Text("Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button("Select Image") {
                        showingImagePicker = true
                    }
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









/*
struct AddEventView: View {
    @ObservedObject var viewModel = EventViewModel()
    @State private var name = ""
    @State private var image = ""
    @State private var date = ""    //Date()
    @State private var organizer = ""
    @State private var description = ""
    @State private var price = ""
    @State private var iduser = ""
    
    
    //@State private var image: URL?
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Event Information")) {
                    TextField("Name", text: $name)
                    TextField("Image URL", text: $image)
                    TextField("Date", text: $date)  ///CHANGE to DatePicker
                    TextField("Organizer", text: $organizer)
                    TextField("Description", text: $description)
                    TextField("Price", text: $price)
                    TextField("User ID", text: $iduser)
                }
                
            }
            .navigationBarTitle(Text("Add Event"))
            ///Users/safahathroubi/Downloads
            
            
            Button(action: {
                viewModel.addEvent(name: name, image: image, date: date, organizer: organizer, description: description, price: price, iduser: iduser)
            }) {
                Text("Add Event")
            }
            
        }}
}*/
    
    
    
    
    
   /*
    var body: some View {
        Form {
            Section(header: Text("Event Information")) {
                TextField("Name", text: $name)
                Button("Choose Image") {
                    let importer = FileImporter(allowedContentTypes: [.image])
                    importer.onCompletion = { result in
                        do {
                            let file = try result.get()
                            imageURL = file.url
                        } catch {
                            print("Error selecting image: \(error.localizedDescription)")
                        }
                    }
                    importer.present()
                }
                if imageURL != nil {
                    Image(nsImage: NSImage(contentsOf: imageURL!)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Organizer", text: $organizer)
                TextField("Description", text: $description)
                TextField("Price", text: $price)
                TextField("User ID", text: $iduser)
            }
            Button(action: {
                viewModel.addEvent(name: name, image: imageURL?.absoluteString ?? "", date: date, organizer: organizer, description: description, price: price, iduser: iduser)
            }) {
                Text("Add Event")
            }
        }
    }*/

