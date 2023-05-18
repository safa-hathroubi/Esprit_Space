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
        guard let url = URL(string: "http://172.17.10.95:5000/news/getAllNews") else {
            fatalError("Invalid URL")
        }
        print("checkpoint1")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("checkpoint2")

                print("Error fetching news posts: \(error?.localizedDescription ?? "Unknown error")")
                return

            }
            print("checkpoint3")

            if let decodedData = try? JSONDecoder().decode([NewsPost].self, from: data) {
                print("checkpoint4")

                DispatchQueue.main.async {
                    print("checkpoint5")

                    self.newsPosts = decodedData
                }
                print("checkpoint6")

            }
        }.resume()
    }
    
    
    
    
    
    
    
    func addNews(title: String, description: String, content: String, author: String, iduser: String, imageUrl: UIImage) {
        print("checkpoint 1")
           let url = URL(string: "http://172.17.10.95:5000/news/createNews")!
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
    
    
    
    
    
    
    
    func addComment(to post: NewsPost, comment: NewsPost.Comment) {
        // Create the request URL
        let urlString = "http://172.17.10.95:5000/news/getComment/64552540422e1636e350e4fb\(post.id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        // Create the request body
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(comment) else {
            print("Failed to encode comment")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error adding comment: \(error!)")
                return
            }
            
            // Parse the response
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                // Comment was added successfully
                print("Comment added successfully")
            } else {
                print("Failed to add comment")
            }
        }.resume()
    }




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }


