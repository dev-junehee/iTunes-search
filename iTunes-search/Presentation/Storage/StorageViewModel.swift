//
//  StorageViewModel.swift
//  iTunes-search
//
//  Created by junehee on 8/11/24.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

final class StorageViewModel: BaseViewModel {
    
    let repo = LikeMusicRepository()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let cancelButtonTap: PublishSubject<LikeMusic>
    }
    
    struct Output {
        let likeMusicList: BehaviorSubject<[LikeMusic]>
        
    }
    
    func transform(input: Input) -> Output {
        let likeMusicList = BehaviorSubject(value: repo.getAllLikePhoto() ?? [])
        
        input.cancelButtonTap
            .bind(with: self) { owner, likeMusic in
                owner.repo.deleteLikeMusic(likeMusic)
                likeMusicList.onNext(owner.repo.getAllLikePhoto() ?? [])
            }
            .disposed(by: disposeBag)

        
        return Output(likeMusicList: likeMusicList)
    }
    
}
