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
    
    struct Input {
        
    }
    
    struct Output {
        let likeMusicList: BehaviorSubject<[LikeMusic]>
        
    }
    
    func transform(input: Input) -> Output {
        let likeMusicList = BehaviorSubject(value: repo.getAllLikePhoto() ?? [])
        
        return Output(likeMusicList: likeMusicList)
    }
    
}
