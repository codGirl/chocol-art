import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var customerLabel: UILabel!
    
    @IBOutlet weak var vendorLabel: UILabel!
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func displayAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func topButton(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            displayAlert(title: "Missing Information", message: "You must provide both an email and password")
        } else {
            if let email = emailField.text {
                if let password = passwordField.text {
                    if signUpMode {
                        //SIGN UP
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                if self.switchOutlet.isOn {
                                    // VENDOR
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    req?.displayName = "Vendor"
                                    req?.commitChanges(completion: nil)
                                    self.performSegue(withIdentifier: "vendorSegue", sender: nil)
                                } else {
                                    // CUSTOMER
                                    let req = Auth.auth().currentUser?.createProfileChangeRequest()
                                    req?.displayName = "Customer"
                                    req?.commitChanges(completion: nil)
                                    self.performSegue(withIdentifier: "customerSegue", sender: nil)
                                }
                            }
                        })
                    } else {
                        //LOG IN
                        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                if error != nil {
                                    self.displayAlert(title: "Error", message: error!.localizedDescription)
                            } else {
                                let user2 = Auth.auth().currentUser?.displayName
                                if user2 == "Vendor" {
                                    // VENDOR
                                    self.performSegue(withIdentifier: "vendorSegue", sender: nil)
                                } else {
                                    // CUSTOMER
                                    self.performSegue(withIdentifier: "customerSegue", sender: nil)
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    @IBAction func bottomButton(_ sender: Any) {
        
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            customerLabel.isHidden = true
            vendorLabel.isHidden = true
            switchOutlet.isHidden = true
            signUpMode = false
        } else {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            customerLabel.isHidden = false
            vendorLabel.isHidden = false
            switchOutlet.isHidden = false
            signUpMode = true
        }
    }
    

}

