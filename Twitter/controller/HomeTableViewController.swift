//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jay on 2022/10/1.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
//1WutbO9fgwZqq8RehxQq7PGzm
//WFHdB3SDg9yeFrFpDrkHtxhKBxzbzxhIE6xH0xR1JrtWKemDIM
class HomeTableViewController: UITableViewController {
    var tweetArray = [NSDictionary]()
    var twitterAPICaller = TwitterAPICaller()
    var numberOfTweet:Int!
    func loadTweet(){
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myparams = [
            "count":10
        ]
        twitterAPICaller.getDictionariesRequest(url: url, parameters: myparams, success: { (tweets:[NSDictionary] )in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweet()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(tweetArray)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableTableViewCell
        let tweet = tweetArray[indexPath.row]
        let user = tweet["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetTextLabel.text = tweet["text"] as? String
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!.replacingOccurrences(of: "_normal", with: "", options: NSString.CompareOptions.literal, range: nil))
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        cell.setFavorite(tweet["favorited"] as! Bool)
        cell.tweetId = tweet["id"] as! Int
        cell.setRetweet(tweet["retweeted"] as! Bool)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        return cell
    }

    @IBAction func tabToLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true,completion: nil)
        UserDefaults.standard.set(false, forKey: "userIsLogin")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
}
