//
//  Student.swift
//  TableView
//
//  Created by Quadref on 10.04.2019.
//  Copyright © 2019 Quadref. All rights reserved.
//

import UIKit

class Student {
    
    let manager = DataManager.shared
    
    var name: String?
    var surname: String?
    var years: Int?
    var gender: Gender!
    var photo: String?
    var position: String? 
    
    
    init(index: Int) {
        self.gender = manager.getGender()
        let tmpName = manager.getFioStudent(gender: gender)
        self.name = tmpName.name
        self.surname = tmpName.surname
        self.position = tmpName.position
        self.years = manager.getYears(index: index)
        self.photo = manager.getPhoto(gender: gender)
    }
    
    
    
    
    
}
