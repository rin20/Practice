//
//  class.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/02.
//

import Foundation

import RealmSwift

class Task: Object{
    @objc dynamic var title: String!
    @objc dynamic var num = 0
}
