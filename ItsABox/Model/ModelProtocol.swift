//
//  ModelProtocol.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 13.08.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol ItsABoxProtocolInputs {
    func add(box: Box, locatedAt worldMap: Data) -> Bool // adding a box and save it at the same time
    func check(Location loc: CLLocation, withinRadius: Double) -> Bool // checks if any box is located near (within radius)
    func getBox(locatedAt loc: CLLocation) -> Observable<Box?> // return an observable which could return a Box, optional
}
