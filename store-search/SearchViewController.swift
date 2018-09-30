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
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("The search text is: '\(searchBar.text!)'")
    }
}

