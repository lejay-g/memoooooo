//
//  RealmUtil.swift
//  memoooooo
//
//  Created by 西田祥子 on 2021/01/03.
//

import Foundation
import RealmSwift

func realm_mig() {
    var config = Realm.Configuration()
    config.migrationBlock = { migration, oldSchemaVersion in
        // 設定していなければ oldSchemaVersion はゼロがデフォルトです
        if oldSchemaVersion < 1 {
            //マイグレーション処理
        }
    }
    // 現在のRealmファイルの schemaVersion と、下記で設定した schemaVersion が違うと、マイグレーションが実行される
    config.schemaVersion = 1
    Realm.Configuration.defaultConfiguration = config
}

func realm_create() -> Realm {
    do {
        return try Realm()
    } catch let error as NSError {
        print("gogogo:realm catch:\(error)")
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        return try! Realm(configuration: config)
    }
}
