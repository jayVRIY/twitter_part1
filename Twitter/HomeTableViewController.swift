//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jay on 2022/10/1.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var tweetArray = [NSDictionary]()
    var numberOfTweet:Int!
    func loadTweet(){
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myparams = [
            "count":10,
        ]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myparams, success: { (tweets:[NSDictionary] )in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { Error in
            print(Error)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(tweetArray)
        let cell  = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        let imageUrl = URL(string: user["profile_image_url_https"] as! String)
        let data = try? Data(contentsOf:imageUrl!)
        if let imageData = data{
            cell.profileImage.image = UIImage(data: imageData)
        }
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = (tweetArray[indexPath.row]["text"] as! String)
        return cell
    }

    @IBAction func tabToLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true)
        UserDefaults.standard.set(false, forKey: "loginToHome")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
}
