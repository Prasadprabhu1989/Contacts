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
    var contactList = NSMutableDictionary()
    var filteredArray = NSMutableArray()
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
    
    func setSectionsForContacts(contactModel: ContactModel) -> ContactModel {
        contactList = NSMutableDictionary()
        let contactSortDescriptor = NSSortDescriptor(key: "contactName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        var found : Bool = false
        contactArray.sort(using: [contactSortDescriptor])
        for contactParser in contactArray {
            var firstCharacter  = false
            var isNameAvailable = false
            if ((contactParser as! ContactParserModel).contactNumber as NSString).length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = (contactParser as! ContactParserModel).contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if ((contactParser as! ContactParserModel).contactNumber as NSString).length == 0 || !firstCharacter {
                if contactList.count == 0 {
                    contactList.setValue(NSMutableArray(), forKey: "#")
                }
            }
            else{
                let c = (contactParser as! ContactParserModel).contactName.substring(to: 1)
                found = false
                for str in contactList.allKeys{
                    if (str as! NSString).isEqual(to: c) {
                        found = true
                    }
                }
                if !found {
                    contactList.setValue(NSMutableArray(), forKey: c.uppercased())
                }
            }
        }
        for temp in contactArray{
            var firstCharacter = false as Bool
            var isNameAvailable = false as Bool
            if (temp as! ContactParserModel).contactName.length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = (temp as! ContactParserModel).contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if (temp as! ContactParserModel).contactName.length == 0{
                let arr = NSMutableArray()
                arr.add(temp as! ContactParserModel)
                contactList.setValue(arr, forKey: "#")
            }
            else if !firstCharacter {
                let arr = NSMutableArray()
                arr.add(temp as! ContactParserModel)
                 contactList.setValue(arr, forKey: "#")
                
            }
            else{
                let arr = NSMutableArray()
                arr.add(temp as! ContactParserModel)
                contactList.setValue(arr, forKey: (temp as! ContactParserModel).contactName.uppercased)
            }
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
