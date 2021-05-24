//
//  HomeMovieTableViewCell.swift
//  globoplay-desafio
//
//  Created by Wagner Junior  on 02/05/21.
//

import UIKit
import Kingfisher

protocol HomeViewMovieDelegate: class {
    func movieSelected(withMovie movie: Movie)
}

class HomeMovieTableViewCell: UITableViewCell {

    @IBOutlet var sectionTitleLabel: UILabel!
    @IBOutlet var moviesCV: UICollectionView!
    
    weak var viewDelegate: HomeViewMovieDelegate?
    var moviesData: [Movie] = [Movie]()
    public var tableIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        moviesCV.delegate = self
        moviesCV.dataSource = self
        moviesCV.register(UINib(nibName: "HomeMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviePoster")
        // Configure the view for the selected state
    }
    
    func setup(sectionTitle: String, sectionMovies: [Movie], tableIndex: Int) {
        sectionTitleLabel.text = sectionTitle
        self.tableIndex = tableIndex
        self.moviesData.append(contentsOf: sectionMovies)
        if !sectionMovies.isEmpty {
            self.moviesCV.reloadData()
        }
    }
    
}

extension HomeMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.moviesData.count)
        return self.moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePoster", for: indexPath) as? HomeMovieCollectionViewCell else { return UICollectionViewCell() }
        let movieData = self.moviesData[indexPath.row]
        let imageURL = URL(string: Service.baseImageURL + movieData.poster_path)
        cell.moviePoster.kf.setImage(with: imageURL)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewDelegate?.movieSelected(withMovie: moviesData[indexPath.row])
    }
}
