//
//  SliderCell.swift
//  GithubDemo
//
//  Created by Dam Vu Duy on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol SliderCellDelegate {
    func onSliderValueChange(sender: SliderCell, slider: UISlider)
}

class SliderCell: UITableViewCell {
    
    var delegate: SliderCellDelegate?
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderView: UISlider!

    @IBAction func onSilderValueChanged(sender: UISlider) {
        valueLabel.text = "\(Int(sender.value))"
        self.delegate?.onSliderValueChange(self, slider: sender)
    }
}
