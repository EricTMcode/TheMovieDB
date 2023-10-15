//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    @Published private(set) var nowPlaying: [Media] = []
    @Published private(set) var upcoming: [Media] = []
    @Published private(set) var topRated: [Media] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    @Published var hasAppeared = false
    
    @Published var page = 1
    private var totalPages: Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    @MainActor
    func fetchMovies(from endpoint: Endpoint) async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint, type: MediaResponse.self)
            switch endpoint {
            case .nowPlaying(page: page):
                self.nowPlaying = response.results
            case .upcoming(page: page):
                self.upcoming = response.results
            case .topRated(page: page):
                self.topRated = response.results
            default:
                break
            }
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func populateMovies() async {
        await fetchMovies(from: .nowPlaying(page: page))
        await fetchMovies(from: .upcoming(page: page))
        await fetchMovies(from: .topRated(page: page))
    }
}

extension MovieListViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
