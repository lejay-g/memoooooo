//
//  memoObject.swift
//  memoooooo
//
//  Created by 西田祥子 on 2021/01/03.
//

import Foundation
import RealmSwift

public class Memo: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var item:String = ""
}
