//
//  ViewController.swift
//  SimpleChatApp
//
//  Created by 渡邉舜也 on 08/08/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

import UIKit
import Firebase

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
        
        //Firestoreへ接続
        let db = Firestore.firestore()
        
        //コレクションroomが変更されたか検知するリスナーを登録
        db.collection("room").addSnapshotListener { (querySnapshot, error) in
            
            //querySnapshot.documents: room内の全件を取得
            guard let documents = querySnapshot?.documents
                else{
                    //roomの中に何もない場合処理を中断
                    return
            }
            //変数documentsにroomの全データがあるのでそれを元に配列を作成し画面を更新する
            var results: [Room] = []
            
            //documentsを全件取り出してfor文を回す
            for document in documents{
                //documentの中からnameを取得
                let roomName = document.get("name") as! String
                
                //structのRoomを新たに作り出す
                let room = Room(name: roomName, documentID: document.documentID)
                
                results.append(room)
            }
            
            //変数roomsを書き換える
            self.rooms = results
        }
    }

    // ルーム作成のボタンがクリックされた時
    @IBAction func didClickButton(_ sender: UIButton) {
        if roomNameTextField.text!.isEmpty {
            // テキストフィールドが空文字の場合
            // 処理中断
            return
        }
        
        // 部屋の名前を変数に保存
        let roomName = roomNameTextField.text!
        
        // Firestoreの接続情報取得
        let db = Firestore.firestore()
        
        // Firestoreに"room"という新しい部屋を追加
        db.collection("room").addDocument(data: [
            "name": roomName,
            "createdAt": FieldValue.serverTimestamp()
        ]) { err in
            
            if let err = err {
                print("チャットルームの作成に失敗しました")
                print(err)
            } else {
                print("チャットルームを作成しました：\(roomName)")
            }
        }
        
        roomNameTextField.text = ""
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

