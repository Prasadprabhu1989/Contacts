//
//  ContactManager.swift
//  ContactsSample
//
//  Created by Prasad.d on 03/08/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import UIKit
import Contacts
class ContactManager: NSObject {
    let contactManager = ContactManager()
    lazy var contactStore : CNContactStore = {
        return CNContactStore()
    }()
   

func fetchAllContacts(isGranted : Bool,contactModel: ContactModel,completion:()->Void ) -> Void {
    
    switch CNContactStore.authorizationStatus(for: .contacts) {
    case .notDetermined:
    
    contactStore.requestAccess(for: .contacts, completionHandler: { (isGranted, error) in
       
    })
    
    break
    default:
        break
        
    }
}
    func getAllContacts() -> ContactModel {
        let keyToFetch = [CNContactGivenNameKey , CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactUrlAddressesKey,CNContactMiddleNameKey]
        let fetchRequest = CNContactFetchRequest.init(keysToFetch: keyToFetch as [CNKeyDescriptor])
        let groupsOfContact = NSMutableArray()
        
        try! contactStore.enumerateContacts(with: fetchRequest, usingBlock: { contact, stop in
            groupsOfContact.add(contact)
        })
        let contactModel = ContactModel()
    }
    
}
