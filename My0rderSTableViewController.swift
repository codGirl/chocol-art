//
//  My0rderSTableViewController.swift
//  FlowerShopIos
//
//  Created by Irina Ivanovska on 5/9/19.
//  Copyright © 2019 Irina Ivanovska. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class My0rderSTableViewController: UITableViewController {
    var orders : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("BuyOnline").observe(.childAdded) { (snapshot) in
            if (snapshot.value as? [String:AnyObject]) != nil {
                if let ordersDictionary = snapshot.value as? [String:AnyObject] {
                    if let emailDatabase = ordersDictionary["email"] as? String {
                        if emailDatabase == Auth.auth().currentUser?.email {
                            self.orders.append(snapshot)
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myOrdersCell", for: indexPath)
        let snapshot = orders[indexPath.row]
        if let ordersDictionary = snapshot.value as? [String:AnyObject] {
            if let address = ordersDictionary["address"] as? String {
                if let phone = ordersDictionary["phone"] as? String {
                    if let date = ordersDictionary["date"] as? String {
                        if let order = ordersDictionary["order"] as? String {
                                    cell.textLabel?.text = " You have ordered: \(order). It should be delivered on the \(date) at this \(address). Your contact number is \(phone) "
                                }
                            }
                }
            }
        }
        return cell
    }  
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
