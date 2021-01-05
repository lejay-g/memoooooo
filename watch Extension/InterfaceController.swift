//
//  InterfaceController.swift
//  watch Extension
//
//  Created by 西田祥子 on 2021/01/03.
//

import WatchKit
import Foundation
import WatchConnectivity
import RealmSwift

class InterfaceController: WKInterfaceController,WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }

    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var listTableView: WKInterfaceTable!
    
//    var items = ["aa","bb","cc","dd","ee","ff"]
    
    var item_count :Int = 0
    
    func setupTable() {
        let realm = try! Realm()
        let items = realm.objects(Memo.self)

        self.titleLabel.setText("\(items.count)")

        listTableView.setNumberOfRows(items.count, withRowType: "ItemRow")
        for i in 0..<items.count {
            let item = items[i]
            if let row = listTableView.rowController(at: i) as? ItemRow {
                row.Name.setText(item.item)
            }
        }
    }
        
    override func awake(withContext context: Any?) {
        //sessionをアクティベート
        if WCSession.isSupported() {
          let session = WCSession.default
          session.delegate = self
          session.activate()
        }
        
        //テーブルの中身を設定
        setupTable()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    // When the file was received
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
        //set the recieved file to default Realm file
        var config = Realm.Configuration()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let realmURL = documentsDirectory.appendingPathComponent("data.realm")
        if FileManager.default.fileExists(atPath: realmURL.path){
            try! FileManager.default.removeItem(at: realmURL)
        }
        try! FileManager.default.copyItem(at: file.fileURL, to: realmURL)
        config.fileURL = realmURL
        Realm.Configuration.defaultConfiguration = config
                
        setupTable()
    }

}
