//
//  PlayingViewController.swift
//  MusiCorreria
//
//  Created by Eduardo Lopes de Carvalho on 02/09/20.
//  Copyright © 2020 Eduardo Lopes de Carvalho. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation


class PlayerViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    var item: Item?
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var statusLabel: UILabel!
    var auth = SPTAuth.defaultInstance()!
    var player : SPTAudioStreamingController?
    var loginURL: URL?
    var session: SPTSession!

    
    @IBAction func botaoCansei(_ sender: Any) {
        self.player?.setIsPlaying(false, callback: nil)

    }
    
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            initializePlayer(authsession: session)
            
        }

        
        if CMMotionActivityManager.isActivityAvailable(){
            self.activityManager.startActivityUpdates(to: OperationQueue.main){ (data) in
                
                DispatchQueue.main.async {
                    
                    if let activity = data {
                        
                        if activity.walking == true{
                            self.statusLabel.text = "Continue a se movimentar..."
                            self.player?.setIsPlaying(true, callback: nil)
                            
                        }else if activity.running == true{
                            self.statusLabel.text = "Tô gostando de ver!"
                            self.player?.setIsPlaying(true, callback: nil)
                            
                        }else {self.statusLabel.text = "Bora, se movimenta!"
                            self.player?.setIsPlaying(false, callback: nil)
                            
                        }
                    }
                }
            }
        }
    }
    
    func initializePlayer(authsession:SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player?.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authsession.accessToken)
        }
        
    }
    
    //    @objc func updateAfterFirstLogin () {
    //        let userDefaults = UserDefaults.standard
    //  //      print("ta chamando")
    //
    //        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
    //            let sessionDataObj = sessionObj as! Data
    //            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
    //            self.session = firstTimeSession
    //            initializePlayer(authsession: session)
    //        }
    //    }
    
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        self.load()
        self.player?.playSpotifyURI("spotify:playlist:\(item!.id))", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    //    func setup(){
    //        let redirectURL = "MusiCorreria://returnAfterLogin" //botar url
    //        let clientID = "c4a4ff6139ac4bcc8a37c10877f2a05f" //botar clientid
    //        auth.redirectURL = URL(string: redirectURL)
    //        auth.clientID = "c4a4ff6139ac4bcc8a37c10877f2a05f" //ja sabe
    //        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistReadPrivateScope]
    //        loginURL = auth.spotifyAppAuthenticationURL()
    //    }
    
    
    //    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
    //        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
    //        print("logged in")
    //        self.player?.playSpotifyURI("spotify:playlist:1DlCdZw3R40mnygN3qy81u", startingWith: 0, startingWithPosition: 0, callback: { (error) in
    //            if (error != nil) {
    //                print("playing!")
    //            }
    //        })
    //    }
    
    func load () {
        
        //    let Url = String(format: "https://accounts.spotify.com/api/token")
        //        guard let serviceUrl = URL(string: Url) else { return }
        //        let spotifycode = userDefaults.object(forKey: "SpotifyCode")
        //        print(spotifycode)
        //        let parameters = [
        //            "grant_type":"authorization_code",
        //            "code": "\(spotifycode!)",
        //            "redirect_uri":"MusiCorreria://returnAfterLogin",
        //            "client_id":"c4a4ff6139ac4bcc8a37c10877f2a05f",
        //            "client_secret":"6bb5207b63ce4f85a0dea9b9ec874532"]
        ////        print("LA VAI\n")
        //        print(parameters)
        //        var request = URLRequest(url: serviceUrl)
        //        request.httpMethod = "POST"
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //  //      let postData =  parameters.data(using: .utf8)
        //
        //
        //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        //            return
        //        }
        //        print(httpBody)
        //        request.httpBody = httpBody
        //        request.timeoutInterval = 20
        //        let session = URLSession.shared
        //        print(request)
        //        session.dataTask(with: request) { (data, response, error) in
        //            if let response = response {
        //                print(response)
        //            }
        //            if let data = data {
        //                do {
        //                    let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                    print(json)
        //                } catch {
        //                    print(error)
        //                }
        //            }
        //        }.resume()
        
        
        var semaphore = DispatchSemaphore (value: 0)
        let spotifycode = userDefaults.object(forKey: "SpotifyCode")
        
        let parameters = "grant_type=authorization_code&code=\(spotifycode!)&redirect_uri=MusiCorreria%3A//returnAfterLogin"
        let postData =  parameters.data(using: .utf8)
        print(spotifycode!)
        
        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/authorize")!,timeoutInterval: Double.infinity)
        request.addValue("Basic YzRhNGZmNjEzOWFjNGJjYzhhMzdjMTA4NzdmMmEwNWY6NmJiNTIwN2I2M2NlNGY4NWEwZGVhOWI5ZWM4NzQ1MzI=", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        
    }
    
    
}


