//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Eric on 04/07/2023.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var vm = MovieDetailViewModel()
    
    let id: Int
    let title: String
    
    var body: some View {
        VStack {
            if vm.movie != nil {
                MovieDetailListView(movie: vm.movie!)
            }
        }
        .task {
            await vm.loadMovie(id: id)
        }
    }
}



struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(id: Movie.localMovie.id, title: "Black Adam")
    }
}
