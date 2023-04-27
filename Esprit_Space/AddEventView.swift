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
}
