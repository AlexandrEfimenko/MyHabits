//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Ефименко on 16.05.2024.
//

import UIKit

final class HabitDetailsViewController: UITableViewController {

    private var dataSource = HabitsStore.shared.dates
    private var habit: Habit
    private weak var habitsVC: HabitsViewController? = nil

    
    init(habit: Habit, habitsVC: HabitsViewController? ) {
        self.habit = habit
        self.habitsVC = habitsVC

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = habit.name

        self.tableView.register(HabitDetailsViewCell.self, forCellReuseIdentifier: HabitDetailsViewCell.id)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(onTapEdit))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Сегодня", style: .plain, target: self, action: #selector(onTapBack))

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date: Date = dataSource[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsViewCell.id, for: indexPath) as? HabitDetailsViewCell

        else {
            return UITableViewCell()
        }

        cell.updateData(date: date, habit: habit)

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }

    @objc
    func onTapEdit() {
        let habitVC = HabitViewController(habit: self.habit, habitsVC: habitsVC )
        navigationController?.pushViewController(habitVC, animated: true)
    }

    @objc
    func onTapBack() {
        navigationController?.popToRootViewController(animated: true)
    }



}
