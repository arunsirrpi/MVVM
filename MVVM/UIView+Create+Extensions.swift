//
//  UIView+Create+Extensions.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 18/7/21.
//

import UIKit

extension UIView {
    typealias SetupClosure = (UIView) -> Void
    func build(_ setupClosure: SetupClosure) {
        translatesAutoresizingMaskIntoConstraints = false
        setupClosure(self)
    }
    
    @discardableResult
    func addToAndBuild(
        inParentView parent:UIView,
        _ setupClosure: SetupClosure) -> UIView
    {
        parent.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        setupClosure(self)
        return self
    }
}
