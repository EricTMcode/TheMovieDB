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
        .overlay {
            if vm.isLoading {
                ProgressView()
            }
        }
        .alert("Application Error", isPresented: $vm.showAlert) {
            Button("OK") { }
        } message: {
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
            }
        }
//        .navigationBarBackButtonHidden()
        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.title3)
//                        .foregroundColor(.orange)
//                        .shadow(radius: 10)
//                }
//            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "star")
                        .foregroundColor(.orange)
                }
            }
        }
    }
}



struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MovieDetailView(id: Movie.localMovie.id, title: "Black Adam")
        }
    }
}
