//
//  PrepareForAutoLayout.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

public func prepareForAutoLayout<T: UIView>(_ view: T) -> T {
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
}
