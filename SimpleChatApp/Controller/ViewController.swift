//
//  ViewController.swift
//  SimpleChatApp
//
//  Created by 渡邉舜也 on 08/08/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roomNameTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //チャットの部屋一覧を保持する配列
    var rooms:[Room] = [] {
        //roomsが書き換わった時
        didSet{
            //テーブルを更新する
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func didClickButton(_ sender: UIButton) {
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let room = rooms[indexPath.row]
        
        cell.textLabel?.text = room.name
        
        //右矢印設定
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
}
