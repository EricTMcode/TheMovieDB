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
        VStack {
            ForEach(vm.tvTopRated) { tv in
                Text(tv.name ?? "n/a")
            }
        }
        .task {
            await vm.populateTV()
        }
    }
}

#Preview {
    TVListView()
}
