//
//  NewsUIView.swift
//  Esprit_Space
//
//  Created by safa on 5/5/2023.
//




struct NewsUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewsUIView()
    }
}




import SwiftUI

struct NewsUIView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var showAddNewsView = false

  
    
    var body: some View {
        
        NavigationView {
            VStack{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.newsPosts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.title)
                                .font(.headline)
                                .bold()
                                .lineLimit(nil)
                                .padding(.top,15)
                            AsyncImage(url: URL(string: post.imageUrl)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: 300)
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                            Text("By: \(post.author)")
                                .font(.caption)
                            Text(post.description)
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(.gray)
                            NavigationLink(destination: NewsDetailView(post: post)) {
                                HStack {
                                    Spacer()
                                    Text("See more")
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 10)
                            
                        }
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .shadow(radius: 5)
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Esprit News")
                
            
            

        }
        .navigationBarItems(trailing: AddNewsButton())
        .onAppear {
            viewModel.fetchNews()
        }
       
    }
}

    
    struct AddNewsButton: View {
        @State private var showAddNewsView = false
        //@State private var height = UIScreen.main.bounds.height
        var body: some View {
            Button(action: {
                self.showAddNewsView = true
            }) {
                Label("Add News", systemImage: "plus")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            } .sheet(isPresented: $showAddNewsView) {
                AddNewsView()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            //.offset(y: height / 1.4)//end button
        }
           
        }
    }
    


struct NewsDetailView: View {
    var post: NewsPost

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Display the image
                AsyncImage(url: URL(string: post.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(post.description)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                Text(post.content)
                    .font(.body)
                    .padding(.bottom, 5)
                Text(post.author)
                    .font(.footnote)
                    .padding(.bottom, 5)
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle(post.title)
    }
}

