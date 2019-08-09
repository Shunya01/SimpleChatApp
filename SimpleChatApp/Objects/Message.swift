//
//  Message.swift
//  SimpleChatApp
//
//  Created by 渡邉舜也 on 09/08/2019.
//  Copyright © 2019 渡邉舜也. All rights reserved.
//

import Foundation

struct Message {
    
    //メッセージのID(Firestoreで使用するキーを入れる）
    let documentId: String
    
    //送信されたメッセージ
    let text: String
    
    
}
