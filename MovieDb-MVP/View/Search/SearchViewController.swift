//
//  SearchViewController.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 20/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchView {

    var movieList = MovieList.init(movies: [])

    var query: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.searchResultCollectionView.delegate = self
        //self.searchResultCollectionView.dataSource = self
        print("Ok")
        // Do any additional setup after loading the view.
    }
    

    func updateQuery(query newQuery: String){
        self.query = newQuery
        print(query)
    }
    
    func getMovies(movieList: MovieList) {
        self.movieList = movieList
        print(movieList.moviesInList.count)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.moviesInList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
            else {
                fatalError()
        }
        cell.setUpCell(movieTitle: self.movieList.moviesInList[indexPath.row].title ?? "",
                       moviePosterURL: self.movieList.moviesInList[indexPath.row].poster_path ?? "", movieRating: String(describing: self.movieList.moviesInList[indexPath.row].vote_average) )
        return cell
    }
    
    
}
