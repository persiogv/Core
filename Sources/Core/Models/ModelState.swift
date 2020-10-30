//
//  ModelState.swift
//  Core
//
//  Created by Pérsio on 30/10/20.
//

import Foundation

enum ModelState<Model> {
    case none
    case loading
    case finished(Model)
    case failed
}
