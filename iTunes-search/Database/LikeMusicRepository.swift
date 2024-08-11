//
//  LikeMusicRepository.swift
//  iTunes-search
//
//  Created by junehee on 8/11/24.
//

import Foundation
import RealmSwift

final class LikeMusicRepository {
    
    private let realm = try! Realm()
    
    // 음악 저장
    func createLikeMusic(_ music: LikeMusic) {
        do {
            try realm.write {
                realm.add(music)
                print("Succeed Create LikeMusic")
            }
        } catch (let error) {
            print("Fail Create LikeMusic", error)
        }
    }
    
    // 저장한 음악 삭제
    func deleteLikeMusic(_ music: LikeMusic) {
        do {
            try realm.write {
                realm.delete(music)
                print("Succeed Delete LikePhoto")
            }
        } catch (let error) {
            print("Failed Delete LikePhoto", error)
        }
    }
    
    
}
