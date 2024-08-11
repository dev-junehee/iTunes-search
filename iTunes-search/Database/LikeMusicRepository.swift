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
                getFileURL()
                print("Succeed Create LikeMusic")
            }
        } catch (let error) {
            print("Fail Create LikeMusic", error)
        }
    }
    
    // 저장한 음악 전체 불러오기
    func getAllLikePhoto() -> [LikeMusic]? {
        let likePhotos = realm.objects(LikeMusic.self)
        return Array(likePhotos)
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
    
    // 스키마버전 확인
    func getSchemaVersion() {
        print(realm.configuration.schemaVersion)
    }

    // 저장 경로 확인
    func getFileURL() {
        print(realm.configuration.fileURL ?? "No fileURL")
        
    }
    
}
