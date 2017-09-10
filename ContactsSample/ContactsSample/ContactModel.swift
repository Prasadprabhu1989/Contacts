
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
    var contactArray = [ContactParserModel]()
    //    var contactList : Dictionary<String,[ContactParserModel]> = [:]
    var contactList = Dictionary<String,[ContactParserModel]>()
    var filteredContactList = NSMutableDictionary()
    var contactGroups = NSMutableArray()
    //    var contactList   =  Dictionary <String, Array<Any>>()
    var filteredArray = [ContactParserModel]()
    let isSelected = Bool()
    
    override init() {
        super.init()
    }
    
    func initWithContactArray(groupContactAray:[CNContact]) -> ContactModel {
        contactArray = [ContactParserModel]()
        
        for contact  in groupContactAray {
            var parserModel = ContactParserModel().initWithContact(contact: contact as! CNContact)
            //            parserModel = parserModel .initWithContact(contact: contact as! CNContact)
            if parserModel.alternateNumbers.count > 0 {
                self.contactArray.append(parserModel)
            }
        }
        setSectionsForContacts(contactModel: self)
        return self
    }
    
    func searchText(searchString : NSString) -> ContactModel {
        filteredArray =  [ContactParserModel]()
        filteredContactList = NSMutableDictionary()
        for parserModel in contactArray {
            var isMatch = false as Bool
            if searchString.length == 0 {
                isMatch = true
            }
            else{
                var descriptionRange = NSRange()
                
                if  parserModel .contactName.length == 0 {
                    descriptionRange = parserModel .contactNumber.range(of: searchString as String, options: .caseInsensitive)
                }
                else{
                    descriptionRange = parserModel.contactName.range(of: searchString as String, options: .caseInsensitive)
                }
                
                if descriptionRange.location != NSNotFound {
                    isMatch = true
                }
                
            }
            if isMatch {
                
                filteredArray.append(parserModel)
            }
            
        }
        if filteredArray.count > 0 {
            setSectionsForFilteredContacts(contactModel: self)
        }
        return self
        
    }
    func dispalyContacts() -> ContactModel {
        for temp in contactArray{
            if temp .isSelected{
                contactGroups.add(temp)
                
            }
        }
        return self
    }
    func checkUnCheck(contactParser:ContactParserModel) -> Void {
        for temp  in contactArray{
            if contactParser  .isEqual(temp) {
                if temp.isSelected {
                    temp .isSelected  = false
                }
                else{
                    temp .isSelected  = true
                }
            }
        }
    }
    
    func setSectionsForFilteredContacts(contactModel: ContactModel) {
        contactList = Dictionary<String,[ContactParserModel]>()
        //       contactList = Dictionary<String, Array<Any>>()
        _ = NSSortDescriptor(key: "contactName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare))
        var found : Bool = false
        //        contactArray.sort(using: [contactSortDescriptor])
        for contactParser in filteredArray {
            var firstCharacter   = false
            var isNameAvailable = false
            if contactParser.contactName.length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = contactParser .contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if contactParser.contactName.length == 0 || !firstCharacter {
                if contactList.count == 0 {
                    //                    contactList.setValue(NSMutableArray(), forKey: "#")
                    contactList.updateValue(Array(), forKey: "#")
                }
                
            }
            else{
                let c = contactParser.contactName.substring(to: 1)
                found = false
                for str in contactList.keys{
                    if str.isEqual(c) {
                        found = true
                    }
                }
                if !found {
                    //                    contactList.setValue(NSMutableArray(), forKey: c.uppercased())
                    contactList.updateValue(Array(), forKey: c.uppercased())
                    
                }
            }
        }
        
        var arr = [ContactParserModel]()
        for temp in filteredArray{
            var firstCharacter = false as Bool
            var isNameAvailable = false as Bool
            if temp.contactName.length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = temp.contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if temp.contactName.length == 0{
                
                //                arr.add(temp as! ContactParserModel)
                arr.append(temp)
                //                contactList.setValue(arr, forKey: "#")
                contactList.updateValue(arr, forKey: "#")
                
            }
            else if !firstCharacter {
                //                let arr = NSMutableArray()
                //                arr.add(temp as! ContactParserModel)
                arr.append(temp)
                //                contactList.setValue(arr, forKey: "#")
                contactList.updateValue(arr, forKey: "#")
                
            }
            else{
                //                let arr = NSMutableArray()
                var s = contactList[temp.contactName.substring(to: 1).uppercased()]!
                
                s.append(temp)
                contactList[temp.contactName.substring(to: 1).uppercased()] = s
                
                
            }
        }
        
    }
    
    func setSectionsForContacts(contactModel: ContactModel) {
        contactList = Dictionary<String,[ContactParserModel]>()
        //       contactList = Dictionary<String, Array<Any>>()
        
        var found : Bool = false
        //        contactArray.sort(using: [contactSortDescriptor])
        for contactParser in contactArray {
            var firstCharacter  = false
            var isNameAvailable = false
            if contactParser.contactName.length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = contactParser .contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if contactParser .contactName.length == 0 || !firstCharacter {
                if contactList.count == 0 {
                    //                    contactList.setValue(NSMutableArray(), forKey: "#")
                    contactList.updateValue(Array(), forKey: "#")
                }
            }
            else{
                let c = contactParser.contactName.substring(to: 1)
                found = false
                for str in contactList.keys{
                    if str .isEqual(c) {
                        found = true
                    }
                }
                if !found {
                    //                    contactList.setValue(NSMutableArray(), forKey: c.uppercased())
                    contactList.updateValue(Array(), forKey: c.uppercased())
                    
                }
            }
        }
        
        var arr = [ContactParserModel]()
        for temp in contactArray{
            var firstCharacter = false as Bool
            var isNameAvailable = false as Bool
            if temp .contactName.length > 0{
                isNameAvailable = true
            }
            if isNameAvailable {
                let firstChar = temp.contactName.character(at: 0) as unichar
                let letters = NSCharacterSet.letters
                firstCharacter = letters.contains(UnicodeScalar(firstChar)!)
            }
            if temp.contactName.length == 0{
                
                //                arr.add(temp as! ContactParserModel)
                arr.append(temp)
                contactList.updateValue(arr, forKey: "#")
                //                contactList.setValue(arr, forKey: "#")
                
                
            }
            else if !firstCharacter {
                //                let arr = NSMutableArray()
                arr.append(temp)
                contactList.updateValue(arr, forKey: "#")
                //                arr.add(temp as! ContactParserModel)
                //
                //                 contactList.setValue(arr, forKey: "#")
                
            }
            else{
                //                let arr = NSMutableArray()
                //                var s = contactList.object(forKey: (temp as! ContactParserModel).contactName.substring(to: 1).uppercased()) as! NSMutableArray
                var e = contactList[temp.contactName.substring(to: 1).uppercased()]
                print("Key :\(e)")
                var s = contactList[temp.contactName.substring(to: 1).uppercased()]!
                //                s.add(temp as! ContactParserModel)
                s.append(temp)
                contactList[temp.contactName.substring(to: 1).uppercased()] = s
                print("s :\(s)")
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
    var contactId = String()
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
        contactId = String.init(format: "%f", Date.timeIntervalBetween1970AndReferenceDate)
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
