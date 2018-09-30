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
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchResults = []
        for i in 0...2 {
            let result = SearchResult()
            result.name = String(format: "Fake result for %d for", i)
            result.artistName = searchBar.text!
            searchResults.append(result)
        }
        tableView.reloadData()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        let result = searchResults[indexPath.row]
        cell.textLabel!.text = result.name
        cell.detailTextLabel!.text = result.artistName
        
        return cell
    }
}
