//
//  InterfaceController.swift
//  watch Extension
//
//  Created by 西田祥子 on 2021/01/03.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var listTableView: WKInterfaceTable!
    
    var items = ["aa","bb","cc","dd","ee","ff"]
    
    func setupTable() {
        listTableView.setNumberOfRows(items.count, withRowType: "ItemRow")
        for i in 0..<items.count {
            if let row = listTableView.rowController(at: i) as? ItemRow {
                row.Name.setText(items[i])
            }
        }
    }
        
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        setupTable()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
