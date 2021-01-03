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
        
        self.set_toolbar()
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
        
        let realm_data = realm_create()
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
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = self.item_list![indexPath.row]
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let realm = realm_create()
            //uuidからアイテムを探して削除
            let results = realm.objects(Memo.self).filter("id == '\(item.id)'")
            try! realm.write {
                realm.delete(results)
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
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
            
            let realm = realm_create()
            try! realm.write {
                realm.add(memo_item)
            }
            
            self.inputTextField.text = ""
            self.listTableView.reloadData()
        }
    }
    
    ///キーボードの完了ボタン設定
    func set_toolbar(){
        // ツールバー生成(サイズはsizeToFitメソッドで自動で調整される)
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        // サイズの自動調整(あえて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さないこと）
        toolBar.sizeToFit()
        // 左側のBarButtonItemはflexibleSpace ※これがないと右に寄らない
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                     target: self,
                                     action: nil)
        // Doneボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                           target: self,
                                           action: #selector(commitButtonTapped))
        // BarButtonItemの配置
        toolBar.items = [spacer, commitButton]
        // キーボードにツールバーを設定
        self.inputTextField.inputAccessoryView = toolBar
    }
    
    /// キーボード用doneボタンで入力完了
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
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
