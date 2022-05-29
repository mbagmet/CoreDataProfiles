//
//  RootViewController.swift
//  CoreDataProfiles
//
//  Created by Михаил Багмет on 28.05.2022.
//

import UIKit
import SnapKit

// MARK: - View
class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter = RootPresenter()
    
    // MARK: - Views
    private lazy var newProfileStackView = createStackView(axis: .horizontal, distribution: .fill)
    
    private lazy var newProfileTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.newProfileTextFieldPlacegolder
        textfield.becomeFirstResponder()
        
        return textfield
    }()
    
    private lazy var newProfileButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.addTarget(self, action: #selector(newProfileButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profilesTableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Presenter setup
        presenter.setViewDelegate(delegate: self)
        presenter.updateProfiles()
        
        // MARK: Navigaiton Setup
        setupNavigation()
        
        // MARK: View Setup
        setupView()
        setupHierarchy()
        setupLayout()
        
        // MARK: Table View Setup
        setupDataSource()
        setupDelegate()
        setupTableCells()
    }
    
    // MARK: - Settings
    
    private func setupView() {
        view.backgroundColor = .tertiarySystemBackground | .systemBackground
    }
    
    private func setupHierarchy() {
        view.addSubview(newProfileStackView)
        
        newProfileStackView.addArrangedSubview(newProfileTextField)
        newProfileStackView.addArrangedSubview(newProfileButton)
        
        view.addSubview(profilesTableView)
    }
    
    private func setupLayout() {
        newProfileStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(Metric.leadingOffset)
            make.trailing.equalToSuperview().offset(Metric.trailingOffset)
        }
        
        profilesTableView.snp.makeConstraints { make in
            make.top.equalTo(newProfileStackView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Table View Settings
    
    private func setupDataSource() {
        profilesTableView.dataSource = self
    }
    
    private func setupDelegate() {
        profilesTableView.delegate = self
    }
    
    private func setupTableCells() {
        profilesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "profilesTableCell")
    }
    
    // MARK: - Private functions

    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = Metric.stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}

// MARK: - Navigation

extension RootViewController {
    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Presenter Delegate
extension RootViewController: RootPresenterDelegate {
    func reloadData() {
        self.profilesTableView.reloadData()
    }
}

// MARK: - User Actions

extension RootViewController {
    @objc func newProfileButtonAction() {
        guard let name = newProfileTextField.text else { return }
        if name != "" {
            presenter.addProfile(name: name)
            newProfileTextField.text = nil
        }
    }
}

// MARK: - Data source, модель ячейки
// Работает в паре с setupDataSource()

extension RootViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.profiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = presenter.profiles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilesTableCell", for: indexPath)
        cell.textLabel?.text = profile.value(forKeyPath: "name") as? String
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - Обработка нажатия на ячейку

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = presenter.profiles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        let profileViewController = ProfileViewController()
        profileViewController.presenter.profile = profile
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// MARK: - Cell Delete

extension RootViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteProfile(index: indexPath.row) {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

// MARK: - Constatnts

extension RootViewController {
    enum Metric {
        static let stackViewSpacing: CGFloat = 12
        static let leadingOffset: CGFloat = 20
        static let trailingOffset: CGFloat = -20
    }
    
    enum Strings {
        static let navigationTitle = "Профили"
        static let newProfileTextFieldPlacegolder = "Добавить новый профиль"
    }
}
