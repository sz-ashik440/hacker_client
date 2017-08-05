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
    
    @IBOutlet weak var tableViewFooter: LoadingFooter!
    
    var stories: [Story] = []
    var storyIDs: [Int] = []
    let storyToWebSegue = "gotoWeb"
    let storySize = 10
    
    var arrayLoaded = false
    var loading = false {
        didSet {
            tableViewFooter.isHidden = !loading
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 340
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.showsVerticalScrollIndicator = false
        
        Story.getStoryID(){ (storyIDs) in
            self.storyIDs = storyIDs
            self.arrayLoaded = true

            self.loadStories(offset: 0, size: self.storySize)
        }
    }
    
    func loadStories(offset: Int, size: Int){
        if (!loading) {
            loading = true
            
            let idToSend = Array(storyIDs[offset..<size])
            
            Story.getStories(storyIDs: idToSend){ recivedStories in
                
                for story in recivedStories {
                    self.stories.append(story)
                }
                
                self.tableView.reloadData()
                self.loading = false
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
            let postedTime = storyObj.time,
            let postURL = storyObj.url,
            let descendants = storyObj.descendants else {
                print("Something is wrong")
                return cell
        }
        
        cell.titleLabel.text = title

        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.sizeToFit()
        
        cell.scoreLabel.text = "\(score)"
        cell.postedByLabel.text = postedBy
        cell.timeLabel.text = Date().offset(from: postedTime)
        cell.urlLabel.text = postURL
        
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if (maximumOffset - currentOffset) <= 10 {
            if arrayLoaded {
                loadStories(offset: stories.count, size: (stories.count + storySize))
            }
        }
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
