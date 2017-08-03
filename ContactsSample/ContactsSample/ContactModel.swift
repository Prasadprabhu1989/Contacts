//
//  ContactModel.swift
//  ContactsSample
//
//  Created by Prasad.d on 03/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit
import Contacts

class ContactModel: NSObject {
    var contactArray = NSMutableArray()
    let contactList = NSMutableDictionary()
    override init() {
        super.init()
    }
    func initWithContactArray(groupContactAray:NSMutableArray) -> ContactModel {
       contactArray = NSMutableArray()
        for contact  in groupContactAray {
            var parserModel = ContactParserModel().initWithContact(contact: contact as! CNContact)
//            parserModel = parserModel .initWithContact(contact: contact as! CNContact)
        }
        return self
    }
}


class ContactParserModel: NSObject {
 
    var contactName = NSString()
    var contactNumber = NSString()
    var alternateNumbers = NSArray()
    var contactImage = NSData()
    var isSelected = Bool()
    override init() {
        super.init()
    }
    func initWithContact(contact: CNContact) -> ContactParserModel {
        contactName = contact.givenName as NSString
        if contact.thumbnailImageData !=  nil{
        contactImage = contact.thumbnailImageData! as NSData
        }
        alternateNumbers = (contact.phoneNumbers[0].value as CNPhoneNumber).value(forKey: "digits") as! NSArray
        if alternateNumbers.count > 0 {
            contactNumber = alternateNumbers[0] as! NSString
        }
        return self
    }
}
