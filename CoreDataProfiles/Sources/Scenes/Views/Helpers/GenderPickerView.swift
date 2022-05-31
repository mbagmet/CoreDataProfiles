//
//  GenderPickerView.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 29.05.2022.
//

import UIKit

class GenderPickerView: UIPickerView {

    // MARK: - Initial
    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Settings
    private func commonInit() {
        delegate = self
        dataSource = self
    }
    
    // MARK: - Methods
    func getSelection() -> String? {
        let row = selectedRow(inComponent: 0)
        return Genders.allCases[row].rawValue
    }
}

// MARK: - Delegate
extension GenderPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Genders.allCases[row].rawValue
    }
}

// MARK: - DataSource
extension GenderPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Genders.allCases.count
    }
}

// MARK: список для пикера
extension GenderPickerView {
    private enum Genders: String, CaseIterable {
        case Male = "Мужчина"
        case Female = "Женщина"
    }
}
