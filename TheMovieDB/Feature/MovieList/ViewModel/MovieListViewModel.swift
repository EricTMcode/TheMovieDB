//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
//    @Published var movies = [Movie]()
    
    @Published var nowPlaying = [Movie]()
    @Published var upcoming = [Movie]()
    @Published var topRated = [Movie]()
    @Published var popular = [Movie]()
    
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    @Published var hasAppeared = false
    
//    func fetchMovies(from endpoint: Endpoint) async {
//        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
//        isLoading = true
//        do {
//            let movieResponse: MovieResponse = try await apiService.getJSON()
//            isLoading = false
//            movies = movieResponse.results
//        } catch {
//            showAlert = true
//            errorMessage = error.localizedDescription
//        }
//    }
    
    func fetchNowPlaying(from endpoint: Endpoint) async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
        isLoading = true
        do {
            let movieResponse: MovieResponse = try await apiService.getJSON()
            isLoading = false
            nowPlaying = movieResponse.results
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchUpcoming(from endpoint: Endpoint) async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
        isLoading = true
        do {
            let movieResponse: MovieResponse = try await apiService.getJSON()
            isLoading = false
            upcoming = movieResponse.results
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchTopRated(from endpoint: Endpoint) async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
        isLoading = true
        do {
            let movieResponse: MovieResponse = try await apiService.getJSON()
            isLoading = false
            topRated = movieResponse.results
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchPopular(from endpoint: Endpoint) async {
        let apiService = APIService(urlString: "\(Constant.apiUrl)/movie/\(endpoint.rawValue)", params: nil)
        isLoading = true
        do {
            let movieResponse: MovieResponse = try await apiService.getJSON()
            isLoading = false
            popular = movieResponse.results
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
}
