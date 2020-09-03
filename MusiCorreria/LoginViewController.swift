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

class LoginViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    var auth = SPTAuth.defaultInstance()!
    var loginURL: URL?
    var session: SPTSession!
    
    
    
    @IBOutlet var logButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    func setup(){
        let redirectURL = "MusiCorreria://returnAfterLogin" //botar url
        let clientID = "c4a4ff6139ac4bcc8a37c10877f2a05f" //botar clientid
        auth.redirectURL = URL(string: redirectURL)
        auth.clientID = "c4a4ff6139ac4bcc8a37c10877f2a05f" //ja sabe
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistReadPrivateScope]
        loginURL = auth.spotifyAppAuthenticationURL()
    }
    
    @objc func updateAfterFirstLogin () {
        let userDefaults = UserDefaults.standard
        //      print("ta chamando")
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            print("entrou updateafter")
            //AQUI TEM O SESSION

            //              initializePlayer(authsession: session)
            
            performSegue(withIdentifier: "LoginToPlaylists", sender: nil)
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        setup()
        print(loginURL)
        UIApplication.shared.open(loginURL! as URL, options: [ : ]) { (success) in
            if success{
                //     if UIApplication.shared.openURL(loginURL!) {
                if self.auth.canHandle(self.auth.redirectURL) {
                    print("dois")
                    
                }
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.updateAfterFirstLogin), name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
        
    }
    
}
