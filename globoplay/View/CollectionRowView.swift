//
//  CategoryRow.swift
//  globoplay
//
//  Created by Marcos Curvello on 15/04/20.
//  Copyright © 2020 Marcos Curvello. All rights reserved.
//

import SwiftUI

struct CollectionRowView: View {
    var title: String
    var movies: [MovieList]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text(title)
                    .fontWeight(.bold)
                    .padding([.leading, .top], 15)
                Spacer()
            }
            .foregroundColor(.white)
            .frame(height: 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination:
                            LazyView(DetailView(movie: movie))
                        ) {
                            CollectionRowItem(movie: movie)
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
            }
            .frame(height: 200)
        }
    }
}

struct CollectionRowItem: View {
    @Environment(\.imageCache) var cache: ImageCache
    var movie: MovieList
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: .image(size: "w200", path: movie.posterPath ?? "N/A"),
                cache: self.cache,
                placeholder: ImagePlaceholder(),
                configuration: { $0.renderingMode(.original).resizable() }
            )
            .frame(width: 108, height: 160)
        }
        .padding([.leading, .trailing], 3.8)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRowView(title: "Thriller", movies: sampleMovies)
    }
}
