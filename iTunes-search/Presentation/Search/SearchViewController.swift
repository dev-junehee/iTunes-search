//
//  SearchViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    private let searchBar = {
        let controller = UISearchController()
        controller.searchBar.placeholder = Constant.Placeholder.search
        return controller
    }()
    
    private let tableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewController() {
        navigationItem.title = Constant.Title.search
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchBar
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
}
