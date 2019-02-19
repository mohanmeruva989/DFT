//
//  Location.swift
//  DFT
//
//  Created by Mohan on 19/02/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation
class Field : Location{
    var name:String
    var facilites : [Facility]?
    init(name : String , facilites : [Facility]?) {
        self.name = name
         self.facilites = facilites
    }
}
class Facility : Location{
    var name:String
    var wellpads : [Wellpad]?
    init(name : String , wellpads : [Wellpad]?) {
        self.name = name
        self.wellpads = wellpads
    }
}
class Wellpad: Location {
    var name:String
    var wells : [Well]?
    init(name : String , wells : [Well]?) {
        self.name = name
        self.wells = wells
    }
}
class Well: Location {
    var name:String

    init(name : String) {
        self.name = name
    }
}
protocol Location {
    var name : String {get set}
}
