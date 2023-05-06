//
//  NewsViewModel.swift
//  Esprit_Space
//
//  Created by safa on 5/5/2023.
//

import Foundation
import Combine
import Alamofire


class NewsViewModel: ObservableObject {
    @Published var newsPosts = [NewsPost]()

    func fetchNews() {
        // Make API call to fetch news posts and update newsPosts array
        // Here's an example using URLSession and Codable
        guard let url = URL(string: "http://localhost:5000/news/getAllNews") else {
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching news posts: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let decodedData = try? JSONDecoder().decode([NewsPost].self, from: data) {
                DispatchQueue.main.async {
                    self.newsPosts = decodedData
                }
            }
        }.resume()
    }
    
    
    
    
    
    
    
    func addNews(title: String, description: String, content: String, author: String, iduser: String, imageUrl: UIImage) {
        print("checkpoint 1")
           let url = URL(string: "http://localhost:5000/news/createNews")!
           let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        print("checkpoint 2")
           AF.upload(multipartFormData: { multipartFormData in
               multipartFormData.append(title.data(using: .utf8)!, withName: "title")
               multipartFormData.append(description.data(using: .utf8)!, withName: "description")
               multipartFormData.append(content.data(using: .utf8)!, withName: "content")
               multipartFormData.append(author.data(using: .utf8)!, withName: "author")
               multipartFormData.append(iduser.data(using: .utf8)!, withName: "iduser")
               print("checkpoint 3")
               if let imageData = imageUrl.jpegData(compressionQuality: 0.5) {
                   multipartFormData.append(imageData, withName: "imageUrl", fileName: "image.jpg", mimeType: "image/jpeg")
               }
               print("checkpoint 4")
           }, to: url, headers: headers)
           .validate()
           .responseDecodable(of: NewsPost.self) { response in
               switch response.result {
               case .success(let newsPost):
                   print("checkpoint 5")
                   let id = newsPost.id ?? "no id"
                   print("News added with ID: \(id)")
               case .failure(let error):
                   print("checkpoint 6")
                   print("Error adding news: \(error.localizedDescription)")
               }
           }
       }
    
    
}
