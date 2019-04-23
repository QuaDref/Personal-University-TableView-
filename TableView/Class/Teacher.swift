//
//  Teacher.swift
//  TableView
//
//  Created by Quadref on 12.04.2019.
//  Copyright © 2019 Quadref. All rights reserved.
//

import UIKit

class Teacher {
    
    let manager = DataManager.shared
    
    var name: String?
    var surname: String?
    var gender: Gender!
    var photo: String?
    var positionT: String?
    
    init(index: Int) {
        self.gender = manager.getGender()
        let tmpName = manager.getFioTeacher(gender: gender)
        self.name = tmpName.nameBoy
        self.surname = tmpName.surnameT
        self.positionT = manager.getPosition(index: index)
        self.photo = manager.getPhoto(gender: gender)
    }
}
