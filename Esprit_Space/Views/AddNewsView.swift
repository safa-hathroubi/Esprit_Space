//
//  AddNewsView.swift
//  Esprit_Space
//
//  Created by safa on 5/5/2023.
//

import SwiftUI
import UniformTypeIdentifiers


struct AddNewsView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewsView()
    }
}


struct AddNewsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var description = ""
    @State private var content = ""
    @State private var author = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @ObservedObject var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("News Image")) {
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

                Section(header: Text("News Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Content", text: $content)
                    TextField("Author", text: $author)
                }

                Section {
                    Button("Save") {
                        guard let image = image else {
                            print("Error: Image not selected")
                            return
                        }

                        viewModel.addNews(title: title, image: image, description: description, content: content, author: author, iduser: "6453f693c32d95e7b953678a")

                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add News")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }
}
