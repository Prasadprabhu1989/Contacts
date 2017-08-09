
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
    var filteredContactList = NSMutableDictionary()
//    var contactList   =  Dictionary <String, Array<Any>>()
    var filteredArray = NSMutableArray()
    let isSelected = Bool()
    
    override init() {
        super.init()
    }
    
    func initWithContactArray(groupContactAray:NSMutableArray) -> ContactModel {
       contactArray = NSMutableArray()
        
        for contact  in groupContactAray {
            var parserModel = ContactParserModel().initWithContact(contact: contact as! CNContact)
//            parserModel = parserModel .initWithContact(contact: contact as! CNContact)
            if parserModel.alternateNumbers.count > 0 {
                self.contactArray.add(parserModel)
            }
        }
        setSectionsForContacts(contactModel: self)
        return self
    }
    
    func searchText(searchString : NSString) -> ContactModel {
        filteredArray = NSMutableArray()
        filteredContactList = NSMutableDictionary()
        for parserModel in contactArray {
            var isMatch = false as Bool
            if searchString.length == 0 {
                isMatch = true
            }
            else{
                var descriptionRange = NSRange()
                
                if  (parserModel as! ContactParserModel).contactName.length == 0 {
                    descriptionRange = (parserModel as! ContactParserModel).contactNumber.range(of: searchString as String, options: .caseInsensitive)
                }
                else{
                    descriptionRange = (parserModel as! ContactParserModel).contactName.range(of: searchString as String, options: .caseInsensitive)
                }
               
                if descriptionRange.location != NSNotFound {
                    isMatch = true
                }
                
            }
            if isMatch {
                filteredArray.add(parserModel as! ContactParserModel)
            }
            
        }
        if filteredArray.count > 0 {
            setSectionsForFilteredContacts(contactModel: self)
        }
        return self
        
    }
    
    func checkUnCheck(contactParser:ContactParserModel) -> Void {
        for temp  in contactArray{
            if (contactParser as ContactParserModel) .isEqual(temp as! ContactParserModel) {
                if (temp as! ContactParserModel).isSelected {
                    (temp as! ContactParserModel).isSelected  = false
                }
                else{
                    (temp as! ContactParserModel).isSelected  = true
                }
            }
        }
    }
    
    func setSectionsForFilteredContacts(contactModel: ContactModel) {
        contactList = NSMutableDictionary()
        //       contactList = Dictionary<String, Array<Any>>()
        _ = NSSortDescriptor(key: "contactName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        var found : Bool = false
        //        contactArray.sort(using: [contactSortDescriptor])
        for contactParser in filteredArray {
            var firstCharacter  = false
            var isNameAvailable = false
            if ((contactParser as! ContactParserModel).contactName as NSString).length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = (contactParser as! ContactParserModel).contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if ((contactParser as! ContactParserModel).contactName as NSString).length == 0 || !firstCharacter {
                if contactList.count == 0 {
                    contactList.setValue(NSMutableArray(), forKey: "#")
                }
            }
            else{
                let c = (contactParser as! ContactParserModel).contactName.substring(to: 1)
                found = false
                for str in contactList.allKeys{
                    if (str as! String).isEqual(c) {
                        found = true
                    }
                }
                if !found {
                    contactList.setValue(NSMutableArray(), forKey: c.uppercased())
                    
                }
            }
        }
        
        let arr = NSMutableArray()
        for temp in filteredArray{
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
                
                arr.add(temp as! ContactParserModel)
                contactList.setValue(arr, forKey: "#")
                
            }
            else if !firstCharacter {
                //                let arr = NSMutableArray()
                arr.add(temp as! ContactParserModel)
                contactList.setValue(arr, forKey: "#")
                
            }
            else{
                //                let arr = NSMutableArray()
                var s = contactList.object(forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased()) as! NSMutableArray
                s.add(temp as! ContactParserModel)
                //                s = contactList.object(forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased())
                //                contactList.setValue(arr, forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased())
                
            }
        }
        
    }
    
    func setSectionsForContacts(contactModel: ContactModel) {
        contactList = NSMutableDictionary()
//       contactList = Dictionary<String, Array<Any>>()
        let contactSortDescriptor = NSSortDescriptor(key: "contactName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        var found : Bool = false
//        contactArray.sort(using: [contactSortDescriptor])
        for contactParser in contactArray {
            var firstCharacter  = false
            var isNameAvailable = false
            if ((contactParser as! ContactParserModel).contactName as NSString).length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = (contactParser as! ContactParserModel).contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if ((contactParser as! ContactParserModel).contactName as NSString).length == 0 || !firstCharacter {
                if contactList.count == 0 {
                    contactList.setValue(NSMutableArray(), forKey: "#")
                }
            }
            else{
                let c = (contactParser as! ContactParserModel).contactName.substring(to: 1)
                found = false
                for str in contactList.allKeys{
                    if (str as! String).isEqual(c) {
                        found = true
                    }
                }
                if !found {
                    contactList.setValue(NSMutableArray(), forKey: c.uppercased())
                    
                }
            }
        }
        
        let arr = NSMutableArray()
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
                
                arr.add(temp as! ContactParserModel)
                contactList.setValue(arr, forKey: "#")
                
            }
            else if !firstCharacter {
//                let arr = NSMutableArray()
                arr.add(temp as! ContactParserModel)
                 contactList.setValue(arr, forKey: "#")
                
            }
            else{
//                let arr = NSMutableArray()
                var s = contactList.object(forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased()) as! NSMutableArray
                s.add(temp as! ContactParserModel)
//                s = contactList.object(forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased())
//                contactList.setValue(arr, forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased())
                
            }
        }
        
    }
}


class ContactParserModel: NSObject {
 
    var contactName = NSString()
    var contactNumber = NSString()
    var alternateNumbers = NSMutableArray()
    var contactImage = Data()
    var isSelected = Bool()
    override init() {
        super.init()
    }
    func initWithContact(contact: CNContact) -> ContactParserModel {
        contactName = contact.givenName as NSString
        if contact.thumbnailImageData !=  nil{
        contactImage = contact.thumbnailImageData!
        }
//        alternateNumbers = contact.phoneNumbers as NSArray
        contactNumber = (contact.phoneNumbers[0].value as CNPhoneNumber).value(forKey: "digits") as! NSString
        
        for i in 0..<contact.phoneNumbers.count {
            alternateNumbers.add((contact.phoneNumbers[i].value as CNPhoneNumber).value(forKey: "digits")!)
        }
//        alternateNumbers = contact.phoneNumbers as NSArray
        if alternateNumbers.count > 0 {
            contactNumber = (contact.phoneNumbers[0].value as CNPhoneNumber).value(forKey: "digits") as! NSString
        }
        return self
    }
    
}
