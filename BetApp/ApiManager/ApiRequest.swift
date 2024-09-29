//
//  ApiRequest.swift
//  BetApp
//
//  Created by Deniz Otlu on 24.09.2024.
//

import Foundation
import UIKit

// GET https://newsapi.org/v2/top-headlines?country=us&apiKey=005c40c044124db48ecf2a26ae4389f6

class NewsService {
    
    let baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    let apiKey = "005c40c044124db48ecf2a26ae4389f6"

    func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(apiKey)") else {
            print("URL error")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
                
                do {
                 /*   let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase */
                    let newsResponse = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                    completion(.success(newsResponse.articles))
                } catch {
                    print("ManşetCatchError")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


