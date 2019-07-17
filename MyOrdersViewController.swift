//
//  MyOrdersViewController.swift
//  FlowerShopIos
//
//  Created by Irina Ivanovska on 5/6/19.
//  Copyright © 2019 Anastasija Nikolovska. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var tableOutletView: UITableView!
    
    var Orders : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("BuyOnline").observe(.childAdded) { (snapshot) in
            //if let ordersDictionary = snapshot.value as? [String:AnyObject] {
            //if let emailDatabase = ordersDictionary["email"] as? String {
            // if emailDatabase == email {
            self.Orders.append(snapshot)
            self.tableOutletView.reloadData()
        }
    }
    
    @IBAction func checkTapped(_ sender: Any) {
            Database.database().reference().child("BuyOnline").observe(.childAdded) { (snapshot) in
                //if let ordersDictionary = snapshot.value as? [String:AnyObject] {
                    //if let emailDatabase = ordersDictionary["email"] as? String {
                        // if emailDatabase == email {
                            self.Orders.append(snapshot)
                            self.tableOutletView.reloadData()
                      //  }
                    //}
              //  }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOutletView.dequeueReusableCell(withIdentifier: "myOrdersCell", for: indexPath)
        let snapshot = Orders[indexPath.row]
        if let ordersDictionary = snapshot.value as? [String:AnyObject] {
            if let address = ordersDictionary["address"] as? String {
                if let phone = ordersDictionary["phone"] as? String {
                    if let date = ordersDictionary["date"] as? String {
                        if let order = ordersDictionary["order"] as? String {
                            cell.textLabel?.text = " Your order: \(order) should be delivered on the \(date) at this \(address). Your contact number is \(phone) "
                        }
                    }
                }
            }
        }
      return cell
    }
}

