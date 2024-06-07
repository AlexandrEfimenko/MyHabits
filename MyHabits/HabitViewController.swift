//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Ефименко on 16.04.2024.
//

import UIKit

final class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {

    private var habit: Habit?
    private weak var habitsVC: HabitsViewController? = nil


    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "НАЗВАНИЕ"
        name.font = UIFont.boldSystemFont(ofSize: 16)

        return name
    }()

    private lazy var nameTextField: UITextField = {
        let name = UITextField()
        name.text = habit != nil ? habit!.name : ""
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "Введите название привычки ..."

        return name
    }()

    private lazy var dateLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "ВРЕМЯ"
        name.font = UIFont.boldSystemFont(ofSize: 16)

        return name
    }()

    private lazy var dateDescription: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Каждый день"

        return name
    }()

    private lazy var dateDescriptionTime: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = ""
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.textColor = UIColor.magenta

        return name
    }()

    private lazy var dateDescStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5

        return stack
    }()


    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.date = habit != nil ? habit!.date : Date()

        let changedDateAction = UIAction(title: "change date") { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "HH:mm"
            self.dateDescriptionTime.text = dateFormatter.string(from: picker.date)
        }

        picker.addAction(changedDateAction, for: .valueChanged)

        return picker
    }()


    private lazy var colorTitle: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "ЦВЕТ"
        name.font = UIFont.boldSystemFont(ofSize: 16)

        return name
    }()

    private lazy var colorHabitLabel: UILabel = {
        let color = UILabel()
        color.translatesAutoresizingMaskIntoConstraints = false
        color.backgroundColor = habit != nil ? habit!.color : .red
        color.layer.cornerRadius = 20
        color.clipsToBounds = true
        color.isUserInteractionEnabled = true

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentColorPicker))

        color.addGestureRecognizer(gestureRecognizer)

        return color
    }()


    private lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(onTapDelete), for: .touchUpInside)

        return button
    }()

    init(habit: Habit? , habitsVC: HabitsViewController?) {
        self.habit = habit
        self.habitsVC = habitsVC

        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }



    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "dfdfdfd"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(onTapSave))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(onTapCancel))
        

        if self.habit == nil {
            self.navigationItem.title = "Создать"
        } else {
            self.navigationItem.title = "Править"
        }

        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(colorTitle)
        view.addSubview(colorHabitLabel)

        dateDescStack.addArrangedSubview(dateDescription)
        dateDescStack.addArrangedSubview(dateDescriptionTime)

        view.addSubview(dateLabel)
        view.addSubview(dateDescStack)
        view.addSubview(datePicker)
        view.addSubview(deleteHabitButton)

        deleteHabitButton.isHidden =  habit == nil

    }


    private func setupConstraints() {
        let safeArea  = view.safeAreaLayoutGuide

        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),


            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5),

            colorTitle.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            colorTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            colorTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),


            colorHabitLabel.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 10),
            colorHabitLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            colorHabitLabel.heightAnchor.constraint(equalToConstant: 40),
            colorHabitLabel.widthAnchor.constraint(equalToConstant: 40),

            dateLabel.topAnchor.constraint(equalTo: colorHabitLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 10),

            dateDescStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            dateDescStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),


            datePicker.topAnchor.constraint(equalTo: dateDescStack.bottomAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            deleteHabitButton.centerYAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            deleteHabitButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }


    @objc
    func onTapSave() {
        if self.habit == nil {
            // Новая привычка
            if nameTextField.text!.isEmpty {
                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertAction)

                self.present(alert, animated: true, completion: {self.nameTextField.becomeFirstResponder()}) 

                return
            }

            let newHabit = Habit(name: nameTextField.text!, date: datePicker.date, color: colorHabitLabel.backgroundColor ?? .red)

            let store = HabitsStore.shared
            store.habits.append(newHabit)

            self.dismiss(animated: true) {
                if self.habitsVC != nil {
                    self.habitsVC!.reloadCollectionView()
                }
            }


        } else {
            // Редактирование привычки
            self.habit!.name  = nameTextField.text!
            self.habit!.color = colorHabitLabel.backgroundColor ?? .red
            self.habit!.date  = datePicker.date

            HabitsStore.shared.save()

            if self.habitsVC != nil {
                self.habitsVC!.reloadCollectionView()
            }

            navigationController?.popToRootViewController(animated: true)
        }
    }


    @objc
    func onTapCancel() {
        if self.habit == nil {
            self.dismiss(animated: true)
        } else{
            navigationController?.popViewController(animated: true)
        }

    }


    @objc
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Выберите цвет привычки"
        colorPicker.selectedColor = habit?.color ?? .red
        colorPicker.supportsAlpha = true
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
       // colorPicker.popoverPresentationController?.sourceItem = BarI

        self.present(colorPicker, animated: true)
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {

        colorHabitLabel.backgroundColor = color
    }



    @objc 
    func onTapDelete() {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: {_ in

            let index = HabitsStore.shared.habits.firstIndex(of: self.habit!)
            guard index != nil else {return}

            HabitsStore.shared.habits.remove(at: index!)

            if self.habitsVC != nil {
                self.habitsVC!.reloadCollectionView()
            }

            self.navigationController?.popToRootViewController(animated: true)

        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }


}
