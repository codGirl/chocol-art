//
//  Custom3rTableViewController.swift
//  FlowerShopIos
//
//  Created by Irina Ivanovska on 5/8/19.
//  Copyright © 2019 Irina Ivanovska. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class Custom3rTableViewController: UITableViewController {

    
    var offers : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("Offers").observe(.childAdded) { (snapshot) in
            if (snapshot.value as? [String:AnyObject]) != nil {
                self.offers.append(snapshot)
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func logoutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(offers.count)
        return offers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! CustomerTableViewCell
        let snapshot = offers[indexPath.row]
        if let offersDictionary = snapshot.value as? [String:AnyObject]{
            if let img = offersDictionary["img_name"] as? String{
                if let text = offersDictionary["text_desc"] as? String{
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                    cell.textLabel?.text = "\(text)"
                    //cell.imageStorage.image = UIImage(named: "ch.jpg")
                    /*if let url = offersDictionary["img_url"] {
                        let httpsReference = Storage.reference(url)
                        
                    }*/
                }
            }
        }        /*
         
         */
       // cell.imageStorage.image = UIImage(named: "ch.jpg")
       // cell.textDesc.text = " geloooo"
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let snapshot = offers[indexPath.row]
       performSegue(withIdentifier: "orderSelectedSegue", sender: snapshot)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let buyOnlineVC = segue.destination as? BuyOnlineViewController {
            if let snapshot = sender as? DataSnapshot {
                if let orderDictionary = snapshot.value as? [String:AnyObject] {
                    if let img_name = orderDictionary["img_name"] as? String {
                       buyOnlineVC.ChocolateOrder = img_name
                        print(img_name)
                        print("hellou")
                        print(orderDictionary)
                    }
                }
            }
        }
    }
}
