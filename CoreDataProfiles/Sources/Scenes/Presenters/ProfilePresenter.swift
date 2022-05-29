//
//  ProfilePresenter.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var delegate: ProfilePresenterDelegate?
    var profile: Profile?
    var dataProvider = DataProvider()
    
    // MARK: - Configuration
    
    func setViewDelegate(delegate: ProfilePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getProfile() {
        guard let profile = profile else { return }
        delegate?.showProfile(profile: profile)
    }
    
    // MARK: - Functions
    func updateProfile() {
        guard
            let profile = profile,
            let view = delegate as? ProfileViewController
        else {
            return
        }
        profile.name = view.nameTextField.text
        profile.gender = view.genderTextField.text
        profile.birthday = view.birthdayDatePicker.date
        
        if view.needToUploadImage {
            profile.image = view.profileImageView.image?.jpegData(compressionQuality: 1)
            delegate?.resetNeedToUpload()
        }
        
        dataProvider.updateProfile(profile: profile) {
            self.getProfile()
        }
    }
}
