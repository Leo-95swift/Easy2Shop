//
//  BasketRouter.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 08.11.24.
//

import Foundation

@objc protocol BasketRoutingLogic {
}

protocol BasketDataPassing {
    var dataStore: BasketDataStore? { get }
}

final class BasketRouter: NSObject, BasketRoutingLogic, BasketDataPassing {
    weak var viewController: BasketViewController?
    var dataStore: BasketDataStore?
}
