//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Shengyuan Lu on 2/7/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController {
    
    var posts = [PFObject]()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.allowsSelection = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Post")
        
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.feedTableView.reloadData()
            }
        }
        
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        
        cell.pictureView.af.setImage(withURL: url!)
        
        return cell
    }
    
}
