//
//  SettingsViewController.swift
//  ETTVenues_swift
//
//  Created by Alexander Snigurskyi on 2017-04-18.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    
    //Lifecycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
        slider.value = Float(LocationManager.sharedInstance.distanceFilter)
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        LocationManager.sharedInstance.distanceFilter = Double(slider.value)
        self.updateLabel()
    }
    
    
    //MARK: Internal Logic
    
    
    private func updateLabel() {
        label.text = String(format: "Distance Filter: %.1f m", LocationManager.sharedInstance.distanceFilter)
    }
}
