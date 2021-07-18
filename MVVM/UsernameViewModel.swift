//
//  UsernameViewModel.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 18/7/21.
//

import Foundation

final class UsernameViewModel {
    
    private var user = User()
    
    private(set) var userNameBinding: Bindable<String?>
    private(set) var infoLabelBinding: Bindable<String?>
    private(set) var infoLabelValid: Bindable<Bool>
    
    init(
        withDefaultUserName defaultUserName: String,
        infoLabelName defaultInfoLabelName: String,
        infoLableValid defaultValue: Bool = true
    ) {
        
        userNameBinding = Bindable(defaultUserName)
        infoLabelBinding = Bindable(defaultInfoLabelName)
        infoLabelValid = Bindable(true)
        
        userNameBinding.onValueChange = { [weak self] newValue in
            guard
                let uSelf = self,
                let uNewValue = newValue
            else {
                return
            }
            
            let updated = uSelf.user.update(toPossibleUserName: uNewValue ?? "")
            self?.infoLabelValid.bindingChanged(to: updated)
        }
    }
}
