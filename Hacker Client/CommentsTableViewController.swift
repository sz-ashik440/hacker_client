//
//  CommentsTableViewController.swift
//  Hacker Client
//
//  Created by Admin on 8/6/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit
import Alamofire

class CommentsTableViewController: UITableViewController {
    
    var loadingView = UIView()
    var spinner = UIActivityIndicatorView()
    
    var recivedStory: Story?
    var comments: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingScreen()
        
        guard let story = recivedStory,
            let commentsID = story.kids else {
                print("Story could not recive")
                return
        }
        Comment.getComments(commentIDs: commentsID){ recivedComments in
            for comment in recivedComments{
                self.comments.append(comment)
            }
            self.tableView.reloadData()
            self.removeLoadingScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 340
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentTableViewCell
        
        let commentObj = comments[indexPath.row]
        
        guard let comment = commentObj.text,
            let user = commentObj.by,
            let time = commentObj.time,
            let kids = commentObj.kids else{
            return cell
        }
        cell.commentLabel.text = String(htmlEncodedString: comment)
        
        cell.userLabel.text = user
        cell.timeLabel.text = Date().offset(from: time)
        
        cell.replyButton.setTitle("▿\(kids.count) Reply", for: .normal)
//        cell.replyButton.contentHorizontalAlignment = .right
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let story = recivedStory,
            let comment = story.kids?.count else {
            print("Story could not recive")
            return 1
        }
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("CommentHeaderCell", owner: self, options: nil)?.first as! CommentHeaderCell
        
        guard let storyObj = recivedStory else {
            print("Story could not recive")
            return UIView()
        }
        
        guard let title = storyObj.title,
            let score = storyObj.score,
            let postedBy = storyObj.by,
            let postedTime = storyObj.time,
            let postURL = storyObj.url,
            let descendants = storyObj.descendants else {
                print("Something is wrong")
                return UIView()
        }
        
        headerView.storyTitleLabel.text = title
        headerView.scoresLabel.text = "\(score) points"
        headerView.userNameLabel.text = "by \(postedBy)"
        headerView.timeLabel.text = Date().offset(from: postedTime)
        headerView.numberOFCommentsLabel.text = "\(descendants) comments"
        return headerView
    }
}

extension CommentsTableViewController{
    func setLoadingScreen() {
        let width: CGFloat = 120
        let height: CGFloat = 30
        
        let x = (tableView.frame.width/2)
        let y = (tableView.frame.height/2) - (navigationController?.navigationBar.frame.height)!
        
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        loadingView.addSubview(spinner)
        
        tableView.addSubview(loadingView)
    }
    
    func removeLoadingScreen() {
        spinner.startAnimating()
        spinner.isHidden = true
    }
}
