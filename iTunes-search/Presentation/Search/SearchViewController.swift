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
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let tableView = {
        let view = UITableView()
        view.rowHeight = 80
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        return view
    }()
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 40)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // UserDefaultsManager.deleteAllRecentSearchList()
        print("UD CHECK", UserDefaultsManager.recentSearch)
        
    }
    
    override func configureViewController() {
        navigationItem.title = Constant.Title.search
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.id)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        let input = SearchViewModel.Input(searchText: searchController.searchBar.rx.text,
                                          searchTab: searchController.searchBar.rx.searchButtonClicked,
                                          tableSelected: tableView.rx.modelSelected(SearchResults.self))
        let output = viewModel.transform(input: input)
        
        // 최근검색
        output.recentList
            .bind(to: collectionView.rx.items(cellIdentifier: RecentCollectionViewCell.id, cellType: RecentCollectionViewCell.self)) { (row, element, cell) in
                cell.label.text = element
        }
        .disposed(by: disposeBag)
        
        // 검색결과
        output.searchList
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.id, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.albumNameLabel.text = element.trackName
                cell.artistNameLabel.text = element.artistName
                cell.albumImage.kf.setImage(with: URL(string: element.artworkUrl100))
            }
            .disposed(by: disposeBag)
        
        // 검색결과 셀 클릭
        output.tableSelected
            .bind(with: self) { owner, value in
                let detailVC = SearchDetailViewController()
                detailVC.searchData = value
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
