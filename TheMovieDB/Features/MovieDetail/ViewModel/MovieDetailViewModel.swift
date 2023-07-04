//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Eric on 04/07/2023.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    
    var id: Int?
    
    @MainActor
    func loadMovie(id: Int) async {
        let apiSerivce = APIService(urlString: "\(Constants.apiUrl)/movie/\(id)", params: ["append_to_response": "videos,credits,similar"])
        isLoading = true
        do {
            let movie: Movie = try await apiSerivce.getJSON()
            isLoading = false
            self.movie = movie
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
