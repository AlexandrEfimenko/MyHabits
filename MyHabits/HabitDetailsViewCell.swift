//
//  HabitDetailsViewCell.swift
//  MyHabits
//
//  Created by Александр Ефименко on 16.05.2024.
//

import UIKit

final class HabitDetailsViewCell: UITableViewCell {

    static let id = "HabitDetailsViewCell"
    private var date: Date?
    private var widthF = 150.0

    private lazy var dateLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false

       return view
    }()

    private lazy var takeImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

       return view
    }()

    private lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 20


       return view
    }()

    private lazy var viewSpace: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

       return view
    }()




    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



    private func setupUI() {
        self.widthF =  (contentView.bounds.width - 20.0) / 2

        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(viewSpace)
        stackView.addArrangedSubview(takeImage)
        addSubview(stackView)

       setupConstraints()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            takeImage.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalToConstant: widthF),
            viewSpace.widthAnchor.constraint(equalToConstant: widthF)

        ])
    }

    func updateData(date: Date, habit:Habit) {
        self.date = date

        if let index = HabitsStore.shared.dates.firstIndex(of: date) {
            self.dateLabel.text = HabitsStore.shared.trackDateString(forIndex: index)
        }

        if  HabitsStore.shared.habit(habit, isTrackedIn: date) {
            self.takeImage.image = UIImage(systemName: "checkmark")
        } else {
            self.takeImage.image = nil
        }

    }

}
