//
//  SearchViewController.swift
//  store-search
//
//  Created by Erika Carlson on 9/30/18.
//  Copyright © 2018 Erika Carlson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    var isLoading = false
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: Identifier.searchResultCell.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifier.searchResultCell.rawValue)
        
        cellNib = UINib(nibName: Identifier.noResultCell.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifier.noResultCell.rawValue)
        
        cellNib = UINib(nibName: Identifier.loadingCell.rawValue, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifier.loadingCell.rawValue)
        
        searchBar.becomeFirstResponder()
    }
}

// MARK: UISearchBarDelegate Protocol Methods

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hasSearched = true
        searchBar.resignFirstResponder()
        searchResults = []
        
        if searchBar.text! != "" {
            for i in 0...2 {
                let result = SearchResult()
                result.name = String(format: "Fake result for %d for", i)
                result.artistName = searchBar.text!
                searchResults.append(result)
            }
        }
        tableView.reloadData()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource Protocol Methods

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchResults.count == 0 && hasSearched) || isLoading {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.loadingCell.rawValue, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }
        
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: Identifier.noResultCell.rawValue, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.searchResultCell.rawValue, for: indexPath) as! SearchResultCell
        
            let result = searchResults[indexPath.row]
            cell.nameLabel!.text = result.name
            cell.artistNameLabel!.text = result.artistName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
}
