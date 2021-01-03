//
//  mainViewController.swift
//  memoooooo
//
//  Created by 西田祥子 on 2021/01/03.
//

import UIKit
import RealmSwift

class mainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    
    var item_list: Results<Memo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.register(UINib(nibName: "listTableViewCell",
                                          bundle: Bundle.main),
                                    forCellReuseIdentifier: "listTableViewCell")
        self.listTableView.estimatedRowHeight = 50
        self.listTableView.tableFooterView = UIView(frame: .zero) //空セル部分のボーダーをなくす
        UITableView.appearance().separatorInset = UIEdgeInsets.zero //ボーダーの左側の謎の隙間をなくす
        
        //realmの場所
        print("gogogo:realm:db:\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm_data = try! Realm()
        self.item_list = realm_data.objects(Memo.self)
        
        print("gogogo:\(self.item_list!.count)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.item_list != nil {
            return self.item_list!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell") as! listTableViewCell
        
        if self.item_list != nil {
            let item: Memo = self.item_list![(indexPath as NSIndexPath).row]
            cell.itemLabel.text = item.item
        }
        
        return cell
    }
    
    @IBAction func addButtonTouchUpInside(_ sender: Any) {
        var item_string:String! = ""
        
        item_string = self.inputTextField.text
        if item_string.count > 0 {
            let memo_item = Memo()
            memo_item.item = item_string
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(memo_item)
            }
            
            self.inputTextField.text = ""
            self.listTableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
