//
//  DetailTab.swift
//  globoplay
//
//  Created by Marcos Curvello on 19/04/20.
//  Copyright © 2020 Marcos Curvello. All rights reserved.
//

import SwiftUI
import TinyNetworking

struct InfoStackView: View {
    @State var selection: Selection = .details
    @ObservedObject var resource: Resource<Discover<MovieList>>
    var relatedMovies: [MovieList]? { resource.value?.results.filter { $0.id != self.movie!.id } }
    var movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
        let query = Query(name: .genre, value: String(format: "%D", movie.genres.first?.id != nil ? movie.genres.first!.id : 12))
        let related: Request = .discover(movie: [query])
        self.resource = Resource<Discover<MovieList>>(endpoint: Endpoint(json: .get, url: related.url!, headers: related.auth))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Selection.allCases, id: \.self) { selection in
                    Button(action: {}) {
                        Text(selection.rawValue.uppercased())
                            .fontWeight(.bold)
                            .padding(20)
                            .background(self.selection == selection ?
                                Rectangle().fill(Color.black).padding(.bottom, 3.0).background(Color.white) :
                                Rectangle().fill(Color.black).padding(.bottom, 0.0).background(Color.black)
                        )
                    }
                    .animation(.easeOut)
                    .onTapGesture { self.selection = selection }
                }
                Spacer()
            }
            .font(.system(size: 12))
            .foregroundColor(.white)
            .background(Color.black)
            
            ZStack {
                VStack {
                    InfoView(information: movie!.information)
                }
                .frame(minHeight: 350)
                .zIndex(self.selection == .details ? 1 : 0)
                
                VStack {
                    Group {
                        if relatedMovies == nil {
                            Loader()
                        } else {
                            CollectionRowView(movies: self.relatedMovies!).padding(.top, 10)
                        }
                    }
                    Spacer()
                }
                .frame(minHeight: 300)
                .background(Color.backgroundGray)
                .zIndex(self.selection == .related ? 1 : 0)
            }
        }
    }
}

extension InfoStackView {
    enum Selection: String, CaseIterable {
        case related = "Assista Também"
        case details = "Detalhes"
    }
}

struct InfoStackView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InfoStackView(movie: sampleMovie)
                .environmentObject(Store())
                .frame(height: 300)
        }
        .previewLayout(.fixed(width: 380, height: 400))
    }
}
