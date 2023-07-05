//
//  TextViews.swift
//  TheMovieDB
//
//  Created by Eric on 05/07/2023.
//

import SwiftUI

struct MovieDetailTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
    }
}

struct MovieDetailTitle_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailTitle(text: "Hello")
    }
}
