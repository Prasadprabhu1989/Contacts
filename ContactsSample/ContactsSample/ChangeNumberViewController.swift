//
//  ChangeNumberViewController.swift
//  ContactsSample
//
//  Created by Prasad.d on 09/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit
typealias SelectNumber = (String) ->Void
class ChangeNumberViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var contactparserModel : ContactParserModel = ContactParserModel()
    var selectNumber : SelectNumber!
    @IBOutlet weak var tableViewNumbers: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNumbers.tableFooterView = UIView.init(frame: .zero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactparserModel.alternateNumbers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        contactCell.labelContactName.text = contactparserModel.alternateNumbers[indexPath.row] as? String
        return contactCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneNumber = contactparserModel.alternateNumbers[indexPath.row] as? String
        selectNumber(phoneNumber!)
        self.navigationController?.popViewController(animated: true)
        
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
