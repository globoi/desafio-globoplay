//
//  MovieDetailViewController.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 05/05/21.
//

import UIKit


class MovieDetailViewController: UIViewController {

    //MARK:- IBOutlet properties
    @IBOutlet var moviePosterAgain: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieDescription: UILabel!
    @IBOutlet var watchMovieButton: UIButton!
    @IBOutlet var addFavoriteMovie: UIButton!
    @IBOutlet var movieOptionsCV: UICollectionView!
    
    let viewModel = MovieDetailViewModel()
    let optionsMovie = ["Assista também","Detalhes"]
    var detailMovie: Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMovieDetails()
        viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadMovieDetails(movieDetail: detailMovie)
    }
    
    func setupMovieDetails() {
        let imageURL = URL(string: Service.baseImageURL + detailMovie.poster_path)!
        moviePosterAgain.kf.setImage(with: imageURL)
        movieTitle.text = detailMovie.title
        movieDescription.text = detailMovie.overview

//        //watchbutton
        watchMovieButton.isEnabled = detailMovie.video
        
    }
}


extension MovieDetailViewController: MovieDetailDelegate {
    func detailMovieLoaded() {
        
    }
    
    func fetchDidFailed() {
        print("Error loading details")
    }
    
    
}
