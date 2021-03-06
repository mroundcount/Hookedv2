//
//  MessageAPI.swift
//  Hooked
//
//  Created by Michael Roundcount on 4/30/20.
//  Copyright © 2020 Michael Roundcount. All rights reserved.
//

/*
import Foundation
import Firebase


class MessageApi {

    func sendMessage(from: String, /*to: String,*/ value: Dictionary<String, Any>) {
        let ref = Ref().databaseMessageSendTo(from: from/*, to: to*/)
        ref.childByAutoId().updateChildValues(value)
    }
    
    func receiveMessage(from: String, /*to: String,*/ onSuccess: @escaping(Message) -> Void) {
        let ref = Ref().databaseMessageSendTo(from: from/*, to: to*/)
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key) {
                    onSuccess(message)
                }
            }
        }
    }
}
*/
