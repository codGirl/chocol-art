//
//  BuyOnlineViewController.swift
//  FlowerShopIos
//
//  Created by Irina Ivanovska on 5/8/19.
//  Copyright © 2019 Irina Ivanovska. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BuyOnlineViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var surnameField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var dateField: UIDatePicker!
    
    var ChocolateOrder = "Chocolate Truffles"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        self.performSegue(withIdentifier: "mainViewC", sender: nil)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if let name = nameField.text {
            if let surname = surnameField.text {
                if let address = addressField.text {
                    if let phone = phoneField.text {
                        let dateformater = DateFormatter()
                        dateformater.dateStyle = DateFormatter.Style.short
                        dateformater.timeStyle = DateFormatter.Style.short
                        let strDate = dateformater.string(from: dateField.date)
                        if name == "" || surname == "" || address == "" || phone == "" || strDate == "" {
                            
                            displayAlert(title: "Missing Information", message: "You must provide youe Name, Surname, Phone and Address")
                        } else {
                            if let email = Auth.auth().currentUser?.email {
                                let buyOnlineDictionary : [String:Any] = ["email":email,"name":name,"surname":surname,"phone":phone,"address":address,"date":strDate,"order":ChocolateOrder]
                            Database.database().reference().child("BuyOnline").childByAutoId().setValue(buyOnlineDictionary)
                                
                                displayAlert(title: "Purchase Completed", message: "Dear \(name) \(surname), you have successfully ordered sweets from Chocol'ART to \(address) on the \(strDate)!")
                            }
                    }
                }
            }
        }
    }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
