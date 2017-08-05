//
//  Comment.swift
//  Hacker Client
//
//  Created by Admin on 8/5/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Comment{
    var id: Int?
    var by: String?
    var kids: [Int]?
    var parent: Int?
    var text: String?
    var time: Double?
    var type: String?
    
    required init(json: JSON){
        self.id = json["id"].intValue
        self.by = json["by"].stringValue
        self.kids = json["kids"].arrayValue.map({$0.intValue})
        self.parent = json["parent"].intValue
        self.text = json["text"].stringValue
        self.time = json["time"].doubleValue
        self.type = json["type"].stringValue
    }
    
    class func getComments(commentIDs: [Int], complition: @escaping ([Comment]) -> Void){
        var comments: [Comment] = []
        
        let group = DispatchGroup()
        
        for id in commentIDs{
            group.enter()
            Alamofire.request(Constant.itemURL.rawValue + "\(id).json").response{ response in
                if let error = response.error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = response.data else{
                    return
                }
                
                let json = JSON(data: data)
                
                let commentObj = Comment(json: json)
                comments.append(commentObj)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main){
            complition(comments)
        }
        
    }
    
}
