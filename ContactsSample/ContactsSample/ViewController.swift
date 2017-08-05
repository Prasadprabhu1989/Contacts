//
//  ViewController.swift
//  ContactsSample
//
//  Created by Prasad.d on 03/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableViewContacts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactManager.sharedManager.fetchAllContacts { (granted, contactModel) in
            guard granted  else{
                
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func showAlert(message: String,title: String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

