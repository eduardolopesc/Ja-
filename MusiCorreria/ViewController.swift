//
//  ViewController.swift
//  MusiCorreria
//
//  Created by Eduardo Lopes de Carvalho on 27/08/20.
//  Copyright © 2020 Eduardo Lopes de Carvalho. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class ViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    
    @IBOutlet var logButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "umParaDois", sender: nil)
print("apertou")
        

    
    }
    
}
