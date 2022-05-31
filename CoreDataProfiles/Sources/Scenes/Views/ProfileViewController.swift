//
//  ProfileViewController.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import UIKit
import SnapKit

// MARK: - View
class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter = ProfilePresenter()
    
    lazy var needToUploadImage = false
    
    // MARK: - Views
    
    private lazy var editButton = UIBarButtonItem(title: Strings.editButton,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(editButtonAction))
    
    private lazy var mainStackView = createStackView(axis: .vertical, distribution: .equalCentering, alignment: .center)
    
    // MARK: Profile Image
    
    lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .secondarySystemBackground
        imageView.image = UIImage(systemName: "person.fill")
        
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Metric.imageSize / 2
        imageView.layer.borderWidth = Metric.imageBorderWidth
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return imageView
    }()
    
    // MARK: Stack views
    private lazy var textFieldsStackView = createStackView(axis: .vertical, distribution: .fillProportionally, alignment: .fill)
    
    private lazy var nameStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .center)
    private lazy var birthdayStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .center)
    private lazy var genderStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .center)
    
    private lazy var birthdayFieldStackView = createStackView(axis: .vertical, distribution: .fill, alignment: .leading)
    
    // MARK: Field Icons
    private lazy var nameImage = createIcons(imageName: "person")
    private lazy var birthdayImage = createIcons(imageName: "calendar")
    private lazy var genderImage = createIcons(imageName: "heart")
    
    // MARK: Name
    lazy var nameTextField = createTextFields(placeholder: Strings.nameTextFieldPlacegolder)
    
    // MARK: Birthday
    lazy var birthdayDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date.now
        
        return datePicker
    }()
    
    // MARK: Gender
    lazy var genderTextField = createTextFields(placeholder: Strings.genderTextFieldPlacegolder)
    private lazy var genderToolar = createGenderToolbar()
    private lazy var genderPicker = GenderPickerView()
    
    // MARK: Fields Separators
    private lazy var lineSeparatorOne = makeLineSeparator()
    private lazy var lineSeparatorTwo = makeLineSeparator()
    private lazy var lineSeparatorThree = makeLineSeparator()

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        needToUploadImage = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Presenter setup
        presenter.setViewDelegate(delegate: self)
        presenter.getProfile()

        // MARK: View Setup
        setupEditButton()
        setupView()
        setupHierarchy()
        setupLayout()
        
        // MARK: Input Fields Setup
        toogleUserIterations(active: self.isEditing)
    }
    
    // MARK: - Settings
    
    private func setupEditButton() {
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupView() {
        view.backgroundColor = .tertiarySystemBackground | .systemBackground
        
        mainStackView.spacing = Metric.mainStackViewSpacing
        textFieldsStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        configureCenderTextField(textField: genderTextField, toolbar: genderToolar)
    }
    
    private func setupHierarchy() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(profileImageView)
        mainStackView.addArrangedSubview(textFieldsStackView)
        
        textFieldsStackView.addArrangedSubview(nameStackView)
        textFieldsStackView.addArrangedSubview(lineSeparatorOne)
        textFieldsStackView.addArrangedSubview(birthdayStackView)
        textFieldsStackView.addArrangedSubview(lineSeparatorTwo)
        textFieldsStackView.addArrangedSubview(genderStackView)
        textFieldsStackView.addArrangedSubview(lineSeparatorThree)

        nameStackView.addArrangedSubview(nameImage)
        nameStackView.addArrangedSubview(nameTextField)
        
        birthdayStackView.addArrangedSubview(birthdayImage)
        birthdayStackView.addArrangedSubview(birthdayFieldStackView)
        birthdayFieldStackView.addArrangedSubview(birthdayDatePicker)

        genderStackView.addArrangedSubview(genderImage)
        genderStackView.addArrangedSubview(genderTextField)
    }
    
    private func setupLayout() {
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(Metric.imageTopOffset)
            make.top.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(Metric.leadingOffset)
            make.trailing.equalToSuperview().offset(Metric.trailingOffset)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(Metric.imageSize)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        nameStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        makeLineSeparatorConstraints(line: lineSeparatorOne)
        makeLineSeparatorConstraints(line: lineSeparatorTwo)
        makeLineSeparatorConstraints(line: lineSeparatorThree)
    }
    
    // MARK: - Private functions

    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = Metric.stackViewSpacing
        stackView.alignment = alignment

        return stackView
    }
    
    private func createIcons(imageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: imageName, withConfiguration: Metric.iconConfiguration)
        imageView.tintColor = .systemGray
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }
    
    private func createTextFields(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    private func createGenderToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        let cancelButton = UIBarButtonItem(title: Strings.cancelButton, style: .plain, target: self, action: #selector(cancelGender))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: Strings.doneButton, style: .done, target: self, action: #selector(selectGender))

        toolbar.setItems([cancelButton, spacer, doneButton], animated: true)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    private func configureCenderTextField(textField: UITextField, toolbar: UIToolbar) {
        textField.inputView = genderPicker
        textField.inputAccessoryView = toolbar
    }
    
    private func makeLineSeparator() -> UIView {
        let line = UIView()
        line.layer.borderColor = UIColor.systemGray.cgColor
        line.layer.borderWidth = (1.0 / UIScreen.main.scale) / 2

        return line
    }
    
    private func makeLineSeparatorConstraints(line: UIView) {
        line.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func toogleUserIterations(active: Bool) {
        [profileImageView, textFieldsStackView].forEach {
            $0.isUserInteractionEnabled = active
        }
    }
    
    private func showPhotoGallery() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true)
    }
    
    private func saveImage(image: UIImage) {
        profileImageView.image = image
        
    }
}

// MARK: - Presenter Delegate
extension ProfileViewController: ProfilePresenterDelegate {
    func showProfile(profile: Profile) {
        nameTextField.text = profile.name
        genderTextField.text = profile.gender
        
        if let birthday = profile.birthday {
            birthdayDatePicker.date = birthday
        }
        if let imageData = profile.image {
            profileImageView.image = UIImage(data: imageData)
        }
    }
    
    func resetNeedToUpload() {
        needToUploadImage = false
    }
}

// MARK: - User Actions

extension ProfileViewController {
    @objc func editButtonAction() {
        if self.isEditing {
            self.setEditing(false, animated: true)
            editButton.title = Strings.editButton
            presenter.updateProfile()
        } else {
            self.setEditing(true, animated: true)
            editButton.title = Strings.saveButton
        }
        toogleUserIterations(active: self.isEditing)
    }
    
    @objc func selectGender() {
        genderTextField.text = genderPicker.getSelection()
        genderTextField.endEditing(false)
    }

    @objc func cancelGender() {
        genderTextField.endEditing(false)
    }
    
    @objc func chooseImage(sender: UITapGestureRecognizer) {
        showPhotoGallery()
        needToUploadImage = true
    }
}

// MARK: - ImagePicker Delegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        saveImage(image: image)
    }
}

// MARK: - Constatnts

extension ProfileViewController {
    enum Metric {
        static let stackViewSpacing: CGFloat = 12
        static let mainStackViewSpacing: CGFloat = 40
        static let leadingOffset: CGFloat = 40
        static let trailingOffset: CGFloat = -40
        
        static let imageTopOffset: CGFloat = -30
        static let imageSize: CGFloat = 200
        static let imageBorderWidth: CGFloat = 8
        
        static let iconConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 28, weight: .ultraLight))
    }
    
    enum Strings {
        static let nameTextFieldPlacegolder = "Имя"
        static let birthdayTextFieldPlacegolder = "Дата рождения"
        static let genderTextFieldPlacegolder = "Пол"
        
        static let doneButton = "Готово"
        static let cancelButton = "Отмена"
        static let editButton = "Редактировать"
        static let saveButton = " Сохранить"
    }
}
