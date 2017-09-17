//
//  Listener.swift
//  ContactsSample
//
//  Created by Prasad Prabhu on 17/09/17.
//  Copyright © 2017 Prasad.d. All rights reserved.
//

import Foundation


class Box<T> {
    typealias Listener = (T) -> Void
    var listener : Listener?
    var value :T {
    didSet{
    listener?(value)
    }
}
    init(_value : T) {
        self.value = _value
         listener?(value)
    }
    func bind(listener : Listener?)  {
        self.listener = listener
        listener?(value)
    }
}
