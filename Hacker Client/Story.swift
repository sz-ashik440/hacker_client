//
//  Story.swift
//  Hacker Client
//
//  Created by Admin on 7/6/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Story{
    var id: Int?
    var title: String?
    var by: String?
    var time: Double?
    var url: String?
    var score: Int?
    var kids: [Int]?
    var descendants: Int?
    var type: String?
    
    required init(json: JSON){
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.by = json["by"].stringValue
        self.time = json["time"].doubleValue
        self.url = json["url"].stringValue
        self.score = json["score"].intValue
        self.kids = json["kids"].arrayValue.map({$0.intValue})
        self.descendants = json["descendants"].intValue
        self.type = json["type"].stringValue
    }
    
    class func getStoryID(complition: @escaping ([Int]) -> Void){
        
        Alamofire.request(Constant.topStoryURL.rawValue).response { response in
            if response.error != nil {
                print(response.error!.localizedDescription)
                return
            }
            
            guard let rawData = response.data else{
                return
                
            }
            let json = JSON(data: rawData)
            let storyIDs = json.arrayValue.map({$0.intValue})
            
            DispatchQueue.main.async {
                complition(storyIDs)
            }
        }
    }
    
    class func getStories(storyIDs: [Int], complition: @escaping ([Story]) -> Void){
        var stories: [Story] = []
        let group = DispatchGroup()
        
        for id in storyIDs{
            group.enter()
            Alamofire.request(Constant.itemURL.rawValue+"\(id).json").response { response in
                if let error = response.error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = response.data else{
                    return
                }
                
                let json = JSON(data: data)
                let storyObj = Story(json: json)
                stories.append(storyObj)
                group.leave()
                //print(storyObj.title ?? "Title is missing")
            }
        }
        //group.wait()
        
        group.notify(queue: DispatchQueue.main){
            //print(stories.count)
            complition(stories)
        }
    }
}
