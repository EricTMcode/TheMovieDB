//
//  RectangleView.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import SwiftUI

struct RectangleView: View {
            
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .opacity(0.3)
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
