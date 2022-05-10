//
//  ViewController.swift
//  ViewControllerPrototype
//
//  Created by Alexander Jährling on 03.05.22.
//

import UIKit
import SwiftUI

func produceValues(prefix: String) -> [String] {
    (0..<30).map { "\(prefix) \($0) \(UUID().uuidString)" }
}

class SearchParameters: ObservableObject {
    @Published var filter: String
    @Published var values = produceValues(prefix: "Text")
    
    init(filter: String = "") {
        self.filter = filter
    }
}

protocol TestDataA {
    var textA: String { get }
}

class TestData: ObservableObject {
    var textA = "textA"
    var textB = "textB"
    var textC = "textC"
}

class ViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    let searchParameters = SearchParameters()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let hostingController = UIHostingController(rootView: DummyView(searchParameters: searchParameters)
            .environmentObject(TestData()))

        //let searchBar = searchController.searchBar
        //searchBar.sizeToFit()
        //self.navigationItem.titleView = searchBar
//        searchController.searchBar.
        let searchController = UISearchController()
        searchController.searchResultsUpdater = nil
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artists"
        searchController.searchBar.delegate = self
        searchController.automaticallyShowsSearchResultsController = true
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter"
        self.navigationItem.title = "Hello"
        self.navigationItem.searchController = searchController
        
        self.addChild(hostingController)
        let contentView : UIView = hostingController.view
        let frame = view.frame
        contentView.frame = frame
        self.view.addSubview(contentView)
        hostingController.didMove(toParent: self)

        //searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 320, height: 40)
        //view.addSubview(searchController.searchBar)

//        hostingController.view.frame = view.frame
//        view.addSubview(hostingController.view)
        // Do any additional setup after loading the view.
    }

    //MARK: search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchParameters.filter = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchParameters.filter = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        searchParameters.values = produceValues(prefix: searchParameters.filter)
    }
}

