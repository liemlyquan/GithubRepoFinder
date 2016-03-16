//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    
    var starLimit = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.dataSource = self
      tableView.delegate = self
      tableView.estimatedRowHeight = 200
      tableView.rowHeight = UITableViewAutomaticDimension

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    private func doSearch() {

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            self.repos = newRepos
            self.tableView.reloadData()
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingVC = (segue.destinationViewController as! UINavigationController).viewControllers[0] as! SettingViewController
        settingVC.starLimit = self.starLimit
    }
    
    @IBAction func saveUnwind(sender: UIStoryboardSegue) {
        let sourceVC = sender.sourceViewController as! SettingViewController
        
        if sourceVC.starLimit != self.starLimit {
            self.starLimit = sourceVC.starLimit
            self.searchSettings.minStars = self.starLimit
            print(self.searchSettings.minStars)
            self.doSearch()
        }
    }
    
    @IBAction func cancelUnwind(sender: UIStoryboardSegue) {
        // nothing
    }
    
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let repos = repos {
      return repos.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("GithubRepoCell", forIndexPath: indexPath) as! GithubRepoCell
    let repo = repos[indexPath.row]
    cell.repoNameLabel.text = repo.name!
    cell.starCountLabel.text = "\(repo.stars!)"
    cell.forkCountLabel.text = "\(repo.forks!)"
    cell.ownerNameLabel.text = "by \(repo.ownerHandle!)"
    cell.avatarImageView.setImageWithURL(NSURL(string: repo.ownerAvatarURL!)!)
    cell.descriptionLabel.text = repo.repoDescription!
    return cell
  }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}