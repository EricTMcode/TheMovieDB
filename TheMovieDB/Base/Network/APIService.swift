//
//  APIService.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

struct APIService {
    let urlString: String
    let params: [String: String]?
    
    func getJSON<T: Codable>() async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        print(finalURL)
        
        do {
            let (data, response) = try await URLSession.shared.data(from: finalURL)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw APIError.invalidResponseStatus
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}
