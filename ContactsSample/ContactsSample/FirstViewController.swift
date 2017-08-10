//
//  FirstViewController.swift
//  ContactsSample
//
//  Created by Prasad.d on 09/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableViewContacts: UITableView!
    @IBOutlet weak var headerView: UIView!
    var gcontactModel : ContactModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        header.frame = headerView.frame
        headerView.addSubview(header)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (gcontactModel != nil) {
             return gcontactModel.contactGroups.count
        }
        return 0
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        let contactParser = gcontactModel.contactGroups.object(at: indexPath.row) as! ContactParserModel
        contactCell.labelContactName.text = contactParser.contactName as String
        contactCell.labelContactNumber.text = ""
        if contactParser.contactName.length == 0 {
            contactCell.labelContactName.text = contactParser.contactNumber as String
        }
        else{
            contactCell.labelContactName.text = contactParser.contactName as String
                contactCell.labelContactNumber.text = contactParser.contactNumber as String
        }
        
        return contactCell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let phoneContactsVw = segue.destination as! ViewController
        phoneContactsVw.saveContact = { contactModel in
            self.gcontactModel = contactModel
            self.tableViewContacts.reloadData()
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
