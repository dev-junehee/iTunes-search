//
//  SearchViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift
import SnapKit

final class SearchViewController: BaseViewController {
    
    private let searchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = Constant.Placeholder.search
        return controller
    }()
    private let tableView = {
        let view = UITableView()
        view.rowHeight = 80
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        return view
    }()
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureViewController() {
        navigationItem.title = Constant.Title.search
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        let input = SearchViewModel.Input(searchText: searchController.searchBar.rx.text.orEmpty,
                                          searchTab: searchController.searchBar.rx.searchButtonClicked,
                                          tableSelected: tableView.rx.modelSelected([String].self))
        let output = viewModel.transform(input: input)
        
        output.searchList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.artistNameLabel.text = element.artistName
                cell.appImage.kf.setImage(with: URL(string: element.artworkUrl100))
            }
            .disposed(by: disposeBag)
        
        // output.tableSelected
        //     .bind(with: self) { owner, data in
        //         let detail = SearchDetailViewController()
        //         owner.navigationController?.pushViewController(detail, animated: true)
        //     }
        //     .disposed(by: disposeBag)
        
    }
    
    
}
