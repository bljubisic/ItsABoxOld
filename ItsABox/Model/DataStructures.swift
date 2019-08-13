//
//  DataStructures.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 13.08.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreLocation

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

struct Box {
    let name: String
    let location: CLLocation
    let blob: Data 
}

extension Box {
    init() {
        name = ""
        location = CLLocation()
        blob = Data()
    }
}

extension Box {
    static let boxNameLens = Lens<Box, String> (
        get: { $0.name },
        set: { (name, oldBox) in Box(name: name,
                                     location: oldBox.location,
                                     blob: oldBox.blob)}
    )
    
    static let boxLocationLens = Lens<Box, CLLocation> (
        get: { $0.location },
        set: { (location, oldBox) in Box(name: oldBox.name,
                                         location: location,
                                         blob: oldBox.blob)}
    )
    
    static let boxBlobLens = Lens<Box, Data> (
        get: { $0.blob },
        set: { (blob, oldBox) in Box(name: oldBox.name,
                                     location: oldBox.location,
                                     blob: blob)}
    )
}
