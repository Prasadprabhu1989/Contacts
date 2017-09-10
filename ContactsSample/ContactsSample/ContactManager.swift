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
    static let sharedManager = ContactManager()
    var gContactModel : ContactModel = ContactModel();
    lazy var contactStore : CNContactStore = {
        return CNContactStore()
    }()
    
    
    func fetchAllContacts(completion:@escaping (_ isGranted : Bool,_ contactModel: ContactModel)->Void) -> Void {
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .notDetermined:
            
            weak var weakSelf = self
            weakSelf?.contactStore.requestAccess(for: .contacts, completionHandler: { (isGranted, error) in
                var contactModel = ContactModel()
                if isGranted{
                    contactModel = (weakSelf?.getAllContacts())!
                }
                completion(isGranted, contactModel)
            })
            
            
            break
        case .authorized:
            
            let contactModel = getAllContacts()
            completion(true, contactModel)
            
            break
            
        default:
            completion(false, gContactModel)
            break
            
        }
    }
    func getAllContacts() -> ContactModel {
        let keyToFetch = [CNContactGivenNameKey , CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactUrlAddressesKey,CNContactMiddleNameKey]
        let fetchRequest = CNContactFetchRequest.init(keysToFetch: keyToFetch as [CNKeyDescriptor])
        var groupsOfContact = [CNContact]()
        
        try! contactStore.enumerateContacts(with: fetchRequest, usingBlock: { contact, stop in
            groupsOfContact.append(contact)
        })
        let contactModel = ContactModel().initWithContactArray(groupContactAray: groupsOfContact)
        return contactModel
    }
    
    
}
