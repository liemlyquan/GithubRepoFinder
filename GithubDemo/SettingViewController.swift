//
//  SettingViewController.swift
//  GithubDemo
//
//  Created by Dam Vu Duy on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SliderCellDelegate {

    @IBOutlet weak var settingTableView: UITableView!
    
    var starLimit = 10
    var languageFilter: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SliderCell", forIndexPath: indexPath) as! SliderCell
        
        cell.sliderView.value = Float(self.starLimit)
        cell.valueLabel.text = "\(self.starLimit)"
        cell.delegate = self
        
        return cell
    }
    
    func onSliderValueChange(sender: SliderCell, slider: UISlider) {
        starLimit = Int(slider.value)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // nothing
    }
    
}
