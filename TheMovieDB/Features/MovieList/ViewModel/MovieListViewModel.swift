//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var trending = [Movie]()
    @Published var nowPlaying = [Movie]()
    @Published var upcoming = [Movie]()
    @Published var topRated = [Movie]()
    @Published var popular = [Movie]()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var hasAppeared = false
    
    func fetchMovies(from endpoint: Endpoint) async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
        isLoading = true
        do {
            let movieResponse: MovieResponse = try await apiService.getJSON()
            isLoading = false
            
            switch endpoint {
            case .nowPlaying:
                self.nowPlaying = movieResponse.results
            case .upcoming:
                self.upcoming = movieResponse.results
            case .topRated:
                self.topRated = movieResponse.results
            case .popular:
                self.popular = movieResponse.results
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    
    func fetchTrending() async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/trending/movie/day", params: nil)
        isLoading = true
        do {
            let movieTrending: MovieTrending = try await apiService.getJSON()
            isLoading = false
            trending = movieTrending.results
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func populateMovies() async {
        await fetchMovies(from: .nowPlaying)
        await fetchMovies(from: .upcoming)
        await fetchMovies(from: .topRated)
        await fetchMovies(from: .popular)
    }
}
