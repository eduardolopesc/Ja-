//
//  ViewController.swift
//  ConsumirAPIs
//
//  Created by Francisco Soares Neto on 20/08/20.
//  Copyright © 2020 Francisco Soares Neto. All rights reserved.
//

import UIKit

class PlaylistsViewController: UITableViewController {
    
    var selectedItem: Int = -1
    var playlists: [Item] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        self.load()
        
        
        
    }
    
    
    func load() {
        var semaphore = DispatchSemaphore (value: 0)
        let userDefaults = UserDefaults.standard
        var spotifycode = userDefaults.object(forKey: "SpotifyCode") as! String
        var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/me/playlists")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(spotifycode)
        request.addValue("Bearer \(spotifycode)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                //           let playlists = try JSONSerialization.jsonObject(with: data, options: [])
                let playlists = try decoder.decode(Playlists.self, from: data!)
                
                DispatchQueue.main.async {
                    //           print(playlists)
                    self.playlists = playlists.items
                    self.tableView.reloadData()
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            print(self.playlists)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    //    func load2 () {
    //
    //    let Url = String(format: "http://10.10.10.53:8080/sahambl/rest/sahamblsrv/userlogin")
    //        guard let serviceUrl = URL(string: Url) else { return }
    //        let parameters: [String: Any] = [
    //            "request": [
    //                    "xusercode" : "YOUR USERCODE HERE",
    //                    "xpassword": "YOUR PASSWORD HERE"
    //            ]
    //        ]
    //        var request = URLRequest(url: serviceUrl)
    //        request.httpMethod = "POST"
    //        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
    //            return
    //        }
    //        request.httpBody = httpBody
    //        request.timeoutInterval = 20
    //        let session = URLSession.shared
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
    //    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Qual a sua preferida?"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! PlaylistsTableViewCell
        
        cell.textLabel?.text = playlists[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaylistsToPlayer", case let nextVC = segue.destination as? PlayerViewController {
            nextVC?.item = playlists[self.selectedItem]
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedItem = indexPath.row
        
        return indexPath
        
    }
}

