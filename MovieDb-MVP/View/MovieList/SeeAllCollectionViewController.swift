//
//  SeeAllCollectionViewController.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 21/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SeeAllCollectionViewController: UICollectionViewController {
    var didRequestWasDone: Bool = true
    var presenter: MoviePresenter = MoviePresenter()
    var movieList: [Movie] = []
    var lastPageLoaded: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        presenter.popularMovies()
       
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return presenter.movieList.moviesInList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
            else {
                fatalError()
        }
        cell.setUpCell(movieTitle: String(presenter.movieList.moviesInList[indexPath.row].title!),
                       moviePosterURL: String(presenter.movieList.moviesInList[indexPath.row].poster_path!), movieRating: String(presenter.movieList.moviesInList[indexPath.row].vote_average!))
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath.row)
       // print(presenter.movieList.moviesInList.count)
        if indexPath.row == presenter.movieList.moviesInList.count-2 && didRequestWasDone {
            didRequestWasDone = false
            lastPageLoaded += 1
             presenter.seeAllMovies(lastPageLoaded)
            didRequestWasDone = true
//            sleep(2)
                DispatchQueue.main.async {
            self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
