//
//  TVListView.swift
//  TheMovieDB
//
//  Created by Eric on 01/07/2023.
//

import SwiftUI

struct TVListView: View {
    @StateObject var vm = TVListViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    MediaBackdropCarouselView(content: vm.airingToday)
                        .padding(.bottom, 10)
                    MediaPosterCarouselView(title: "Top Rated", content: vm.tvTopRated)
                    MediaPosterCarouselView(title: "On The Air", content: vm.onTheAir)
                    MediaPosterCarouselView(title: "Popular", content: vm.popular)
                }
            }
            .navigationTitle("TV Shows")
            .task {
                if !vm.hasAppeared {
                    await vm.populateTV()
                    vm.hasAppeared = true
                }
            }
            .refreshable {
                Task {
                    await vm.populateTV()
                }
            }
            .overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("Application Error", isPresented: $vm.hasError, presenting: vm.error) { _ in
                Button("Retry") {
                    Task {
                        await vm.populateTV()
                    }
                }
            } message: { error in
                Text(error.errorDescription ?? "Try again later")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await vm.populateTV()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundStyle(.orange)
                    }
                }
            }
            .navigationDestination(for: Media.self) { tv in
                TVDetailView(id: tv.id)
            }
        }
    }
}

#Preview {
    TVListView()
}
