//
//  MainViewController.swift
//  UIPickers
//
//  Single-screen demo of all three framework delegate idioms in one VC:
//
//   - UITextFieldDelegate                         (email + phone)
//   - UIPickerViewDataSource + UIPickerViewDelegate  (country)
//   - UIContextMenuInteractionDelegate            (long-press item)
//   - declarative UIMenu                          (sort pull-down)
//
//  The VC ends up conforming to FOUR protocols. That's the moment to show
//  interns the FormCoordinator file — extracting these out is exactly
//  what coordinators are for.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: Model

    private let countries = Country.demoData
    private var selectedCountry: Country
    private var currentSort: SortOption = .name

    // MARK: Views

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let emailField = ValidatedTextField(
        validator: EmailValidator(),
        placeholder: "you@example.com")

    private let phoneField = ValidatedTextField(
        validator: CompositeValidator(
            LengthValidator(min: 9, max: 9, fieldName: "Phone"),
            PhoneNumberValidator(maxDigits: 9, dialCode: "+995")
        ),
        placeholder: "5XX XX XX XX")

    private let countryPicker = UIPickerView()

    private let sortButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.title = "Sort by: Name (A–Z)"
        config.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        config.imagePadding = 8
        return UIButton(configuration: config)
    }()

    private let contextItemView: UIView = {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 12
        return v
    }()
    private let contextItemLabel: UILabel = {
        let l = UILabel()
        l.text = "Long-press for context menu"
        l.textAlignment = .center
        return l
    }()

    private let submitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Submit"
        let b = UIButton(configuration: config)
        b.isEnabled = false
        return b
    }()

    private let statusLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .preferredFont(forTextStyle: .footnote)
        l.textColor = .secondaryLabel
        return l
    }()

    // MARK: Init

    init() {
        self.selectedCountry = Country.demoData[0]
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Form"

        setUpLayout()
        configureFields()
        configurePicker()
        configureSortMenu()
        configureContextMenu()
        configureSubmit()
    }

    // MARK: Layout

    private func setUpLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 12

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            contentStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])

        contentStack.addArrangedSubview(heading("Email"))
        contentStack.addArrangedSubview(emailField)

        contentStack.addArrangedSubview(heading("Phone"))
        contentStack.addArrangedSubview(phoneField)

        contentStack.addArrangedSubview(heading("Country"))
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
        countryPicker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        contentStack.addArrangedSubview(countryPicker)

        contentStack.addArrangedSubview(heading("Sort"))
        contentStack.addArrangedSubview(sortButton)

        contentStack.addArrangedSubview(heading("Context menu"))
        contentItemViewLayout()
        contentStack.addArrangedSubview(contextItemView)

        contentStack.addArrangedSubview(submitButton)
        contentStack.addArrangedSubview(statusLabel)
    }

    private func contentItemViewLayout() {
        contextItemLabel.translatesAutoresizingMaskIntoConstraints = false
        contextItemView.addSubview(contextItemLabel)
        NSLayoutConstraint.activate([
            contextItemView.heightAnchor.constraint(equalToConstant: 80),
            contextItemLabel.centerXAnchor.constraint(equalTo: contextItemView.centerXAnchor),
            contextItemLabel.centerYAnchor.constraint(equalTo: contextItemView.centerYAnchor),
        ])
    }

    private func heading(_ text: String) -> UILabel {
        let l = UILabel()
        l.text = text
        l.font = .preferredFont(forTextStyle: .headline)
        return l
    }

    // MARK: Wiring

    private func configureFields() {
        emailField.delegate = self
        phoneField.delegate = self
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        phoneField.keyboardType = .numberPad
        emailField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        phoneField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    private func configurePicker() {
        countryPicker.dataSource = self
        countryPicker.delegate = self
        if let row = countries.firstIndex(of: selectedCountry) {
            countryPicker.selectRow(row, inComponent: 0, animated: false)
        }
    }

    private func configureSortMenu() {
        refreshSortMenu()
        sortButton.showsMenuAsPrimaryAction = true
    }

    private func refreshSortMenu() {
        sortButton.menu = SortMenuBuilder.makeMenu(current: currentSort) { [weak self] option in
            self?.currentSort = option
            self?.sortButton.configuration?.title = "Sort by: \(option.title)"
            self?.refreshSortMenu()  // rebuild so the checkmark moves
            self?.append(log: "[menu] sort → \(option.title)")
        }
        sortButton.configuration?.title = "Sort by: \(currentSort.title)"
    }

    private func configureContextMenu() {
        let interaction = UIContextMenuInteraction(delegate: self)
        contextItemView.addInteraction(interaction)
    }

    private func configureSubmit() {
        submitButton.addAction(UIAction { [weak self] _ in
            self?.submit()
        }, for: .touchUpInside)
    }

    // MARK: Actions

    private func submit() {
        let e = emailField.commit()
        let p = phoneField.commit()
        switch (e, p) {
        case (.valid(let email), .valid(let phone)):
            statusLabel.textColor = .systemGreen
            statusLabel.text =
                "Submitted: \(email) / \(phone) / \(selectedCountry.isoCode)"
        default:
            statusLabel.textColor = .systemRed
            statusLabel.text = [e.errorMessage, p.errorMessage]
                .compactMap { $0 }.joined(separator: "\n")
        }
        refreshSubmitState()
    }

    private func refreshSubmitState() {
        submitButton.isEnabled =
            (emailField.lastResult?.isValid == true) &&
            (phoneField.lastResult?.isValid == true)
    }

    private func append(log line: String) {
        statusLabel.textColor = .secondaryLabel
        let existing = statusLabel.text ?? ""
        statusLabel.text = (existing + "\n" + line).trimmingCharacters(in: .newlines)
    }

    @objc private func textChanged() {
        statusLabel.text = nil
    }
}

// MARK: - UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let field = textField as? ValidatedTextField else { return true }
        return field.validator.shouldAcceptReplacement(
            currentText: field.text ?? "",
            range: range,
            replacement: string)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ValidatedTextField)?.commit()
        textField.resignFirstResponder()
        refreshSubmitState()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason) {
        guard reason == .committed else { return }
        (textField as? ValidatedTextField)?.commit()
        refreshSubmitState()
    }
}

// MARK: - UIPickerViewDataSource

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
}

// MARK: - UIPickerViewDelegate

extension MainViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        let c = countries[row]
        return "\(c.flag)  \(c.name)  \(c.dialCode)"
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        let candidate = countries[row]

        // Demo veto: refuse Türkiye, snap back to previous selection.
        if candidate.isoCode == "TR" {
            statusLabel.textColor = .systemRed
            statusLabel.text = "nooo TURK"
            if let previousRow = countries.firstIndex(of: selectedCountry) {
                pickerView.selectRow(previousRow, inComponent: 0, animated: true)
            }
            return
        }

        selectedCountry = candidate
        statusLabel.text = nil
    }
}

// MARK: - UIContextMenuInteractionDelegate

extension MainViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint)
                                -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            SortMenuBuilder.makeContextMenu(
                itemName: "Demo item",
                onShare:  { self?.append(log: "[ctx] share")  },
                onDelete: { self?.append(log: "[ctx] delete") }
            )
        }
    }

    /// Lifecycle hook closures CAN'T express — exactly when you still need
    /// a delegate even with modern menu APIs.
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                willDisplayMenuFor configuration: UIContextMenuConfiguration,
                                animator: (any UIContextMenuInteractionAnimating)?) {
        append(log: "[ctx] will display")
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                willEndFor configuration: UIContextMenuConfiguration,
                                animator: (any UIContextMenuInteractionAnimating)?) {
        append(log: "[ctx] will end")
    }
}
