//
//  Bindable.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 18/7/21.
//

import Foundation

class Bindable<BindedType> {
    typealias Binding = (BindedType?) -> Void
    var onValueChange: Binding? = nil
    private var _value: BindedType
    
    init(_ value: BindedType){
        _value = value
    }
    
    public var value: BindedType {
        return _value
    }
    
    func bindingChanged(to newValue:BindedType) {
        _value = newValue
        onValueChange?(newValue)
    }
}

