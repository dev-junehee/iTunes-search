//
//  StorageViewController.swift
//  iTunes-search
//
//  Created by junehee on 8/10/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class StorageViewController: BaseViewController {
    
    private let tableView = {
        let view = UITableView()
        view.rowHeight = 80
        view.register(LikeMusicTableViewCell.self, forCellReuseIdentifier: LikeMusicTableViewCell.id)
        return view
    }()
    
    private let viewModel = StorageViewModel()
    private let disposeBag = DisposeBag()
    
    // private let viewWillAppearTrigger = PublishRelay<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.repo.getFileURL()
        bind()
    }
    
    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    //     viewWillAppearTrigger.accept(())
    //     
    // }
    
    override func configureViewController() {
        navigationItem.title = Constant.Title.storage
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        let cancelButtonTap = PublishSubject<LikeMusic>()
        
        let input = StorageViewModel.Input(viewWillAppearTrigger: self.rx.methodInvoked(#selector(self.viewWillAppear(_:))),
                                           cancelButtonTap: cancelButtonTap)
        let output = viewModel.transform(input: input)
        
        output.likeMusicList
            .bind(to: tableView.rx.items(cellIdentifier: LikeMusicTableViewCell.id, cellType: LikeMusicTableViewCell.self)) { (row, element, cell) in
                cell.albumNameLabel.text = element.trackName
                cell.artistNameLabel.text = element.artistName
                cell.albumImage.kf.setImage(with: URL(string: element.artworkUrl100))
                
                cell.cancelButton.rx.tap
                    .subscribe { _ in
                        cancelButtonTap.onNext(element)
                    }
                    .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        
        
        
        
    }
    
    
}
