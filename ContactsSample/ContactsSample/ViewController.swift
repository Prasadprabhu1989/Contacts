//
//  ViewController.swift
//  ContactsSample
//
//  Created by Prasad.d on 03/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit
typealias saveContact = (ContactModel) -> Void
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    @IBOutlet weak var searchBarContacts: UISearchBar!
    var gcontactModel = ContactModel()
    var selectedSection = NSInteger()
    var selectedRow = NSInteger()
    var saveContact : saveContact!

    @IBOutlet weak var tableViewContacts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        var person = Dictionary<String, ContactModel>()
        ContactManager.sharedManager.fetchAllContacts { (granted, contactModel) in
            guard granted  else{
                self.showAlert(message: "Please go to settings to enable access", title: "Message")
                return
            }
            self.gcontactModel = contactModel
            self.tableViewContacts.reloadData()
            
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showAlert(message: String,title: String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gcontactModel.contactList.allKeys.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let sectionTitles = (gcontactModel.contactList.allKeys as NSArray).object(at: section) as! NSString
        let sectionTitles = ((gcontactModel.contactList.allKeys as NSArray).sortedArray(using: #selector(NSString.compare(_:))) as NSArray).object(at: section)
        print("sectionTitle :\(sectionTitles)")
        
        
        return (gcontactModel.contactList.value(forKey: sectionTitles as! String) as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        let sectionTitles = ((gcontactModel.contactList.allKeys as NSArray).sortedArray(using: #selector(NSString.compare(_:))) as NSArray).object(at: indexPath.section)
        //        let contactParser = gcontactModel.contactList.value(forKey: (sectionTitles as! NSArray).object(at: indexPath.row) as! String) as! ContactParserModel
        let contactParser = (gcontactModel.contactList.value(forKey: sectionTitles as! String) as! NSArray).object(at: indexPath.row) as! ContactParserModel
        contactCell.buttonCheckUncheck.setImage(UIImage.init(named: "CheckNo"), for: .normal)
        contactCell.buttonCheckUncheck.setImage(UIImage.init(named: "Check"), for: .selected)
        contactCell.buttonCheckUncheck.isSelected = contactParser.isSelected
        contactCell.buttonCheckUncheck.tag =  indexPath.section*1000 + indexPath.row
        contactCell.buttonCheckUncheck.addTarget(self, action: #selector(checkUncheck(_:)), for: .touchUpInside)
        contactCell.buttonDisclosure.isHidden = true
        if contactParser.alternateNumbers.count > 1 {
            contactCell.buttonDisclosure.isHidden = false
        }
        contactCell.buttonDisclosure.addTarget(self, action: #selector(changeNumbers(_:)), for: .touchUpInside)
        contactCell.buttonDisclosure.tag =  indexPath.section*1000 + indexPath.row
        contactCell.labelContactNumber.text = ""
        if contactParser.contactName.length == 0 {
            contactCell.labelContactName.text = contactParser.contactNumber as String
        }
        else{
            contactCell.labelContactName.text = contactParser.contactName as String
//            contactCell.labelContactNumber.text = contactParser.contactNumber as String
        }
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ((gcontactModel.contactList.allKeys as NSArray).sortedArray(using: #selector(NSString.compare(_:))) as NSArray).object(at: section) as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkUncheck(_ button : UIButton) {
        selectedSection = (button.tag)/1000;
        selectedRow = (button.tag)%1000;
        let sectionTitles = ((gcontactModel.contactList.allKeys as NSArray).sortedArray(using: #selector(NSString.compare(_:))) as NSArray).object(at: selectedSection)
        let contactParser = (gcontactModel.contactList.value(forKey: sectionTitles as! String) as! NSArray).object(at: selectedRow) as! ContactParserModel
        gcontactModel.checkUnCheck(contactParser: contactParser)
        let indexPath = IndexPath(row: selectedRow, section: selectedSection)
        tableViewContacts.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let contactModel = gcontactModel.searchText(searchString: searchText as NSString)
        gcontactModel = contactModel
        tableViewContacts.reloadData()
    }
    
    func changeNumbers(_ button : UIButton) {
        selectedSection = (button.tag)/1000;
        selectedRow = (button.tag)%1000;
        
        self.performSegue(withIdentifier: "ShowAlternateNumbers", sender: button as UIButton)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        let contactArray = NSMutableArray()
       gcontactModel = gcontactModel.dispalyContacts()
        saveContact(gcontactModel)
        self.navigationController?.popViewController(animated: true)
//        for contactParser in gcontactModel.contactArray{
//            if (contactParser as! ContactParserModel).isSelected {
////                saveContact(contactParser as! ContactParserModel)
//                contactArray.add(contactParser as! ContactParserModel)
//            }
//        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sectionTitles = ((gcontactModel.contactList.allKeys as NSArray).sortedArray(using: #selector(NSString.compare(_:))) as NSArray).object(at: selectedSection)
        let contactParser = (gcontactModel.contactList.value(forKey: sectionTitles as! String) as! NSArray).object(at: selectedRow) as! ContactParserModel
        let changeNumberController = segue.destination as! ChangeNumberViewController
        changeNumberController.contactparserModel = contactParser
        changeNumberController.selectNumber = { phonenumber in
            let contactNumber = phonenumber
            contactParser.contactNumber = contactNumber as NSString
            self.tableViewContacts.reloadData()
        }
        
    }
}

