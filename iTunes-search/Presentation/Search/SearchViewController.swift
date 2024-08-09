//
//  SearchViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit

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
        view.backgroundColor = .lightGray
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
        let input = SearchViewModel.Input(tableSelected: tableView.rx.modelSelected([String].self))
        let output = viewModel.transform(input: input)
        
        output.searchList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appName.text = element
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
