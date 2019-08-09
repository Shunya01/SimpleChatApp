//
//  Room.swift
//  SimpleChatApp
//
//  Created by 渡邉舜也 on 09/08/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

// struck：構造体
//チャットの部屋の情報を持つ構造体
struct Room {
    
    //部屋の名前
    let name: String
    
    //部屋のID(Firestoreで使用するキーを入れる)
    let documentID: String
}
