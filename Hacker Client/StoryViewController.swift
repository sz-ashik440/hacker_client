//
//  ViewController.swift
//  Hacker Client
//
//  Created by Admin on 7/6/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StoryViewController: UITableViewController {
    
    var stories: [Story] = []
    let storyToWebSegue = "gotoWeb"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 240
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        
        Story.getStoryID(){ (storyIDs) in
            // print("Total Stories: \(storyIDs.count)")
            let idToSend = Array(storyIDs[0..<20])
            Story.getStories(storyIDs: idToSend){ recivedStories in
                self.stories = recivedStories
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StoryTableViewCell
        let storyObj = stories[indexPath.row]
        
        guard let title = storyObj.title,
            let score = storyObj.score,
            let postedBy = storyObj.by,
            let postedTime = storyObj.time else {
                print("Something is wrong")
                return cell
        }
        guard let descendants = storyObj.descendants else {
            print("Bomb in descendants")
            return cell
        }
        
        cell.titleLabel.text = title

        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.sizeToFit()
        
        cell.scoreLabel.text = "\(score)"
        cell.postedByLabel.text = postedBy
        cell.timeLabel.text = Date().offset(from: postedTime)
        cell.urlLabel.text = storyObj.url != nil ? "\(storyObj.url!)" : ""
        
        cell.commentButton.titleLabel?.textAlignment = .center
        cell.commentButton.titleLabel?.lineBreakMode = .byWordWrapping
        cell.commentButton.setTitle("💬\n\(descendants)", for: .normal)
        
        
        cell.tapComments = { [weak self] (cell) in
            print(descendants)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyToWebSegue {
            if let webviewVC = segue.destination as? UrlStoryViewController,
                let cell = sender as? StoryTableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                    let storyObj = stories[indexPath.row]
                    webviewVC.storyURL = storyObj.url
            }
        }
    }
}
