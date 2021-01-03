//
//  mainViewController.swift
//  memoooooo
//
//  Created by 西田祥子 on 2021/01/03.
//

import UIKit

class mainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.register(UINib(nibName: "listTableViewCell",
                                          bundle: Bundle.main),
                                    forCellReuseIdentifier: "listTableViewCell")
        self.listTableView.estimatedRowHeight = 50
        self.listTableView.tableFooterView = UIView(frame: .zero)
        UITableView.appearance().separatorInset = UIEdgeInsets.zero //ボーダーの左側の謎の隙間
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell") as! listTableViewCell
        cell.itemLabel.text = String(indexPath.row)
        
        return cell
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
