//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Ефименко on 02.05.2024.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    static let idCell = "HabitCollectionViewCell"
    private var habit: Habit?
    var collectionView: UICollectionView?

    private lazy var nameHabitLabel: UILabel = {
       let name = UILabel()
       name.translatesAutoresizingMaskIntoConstraints = false
       name.layer.borderColor = UIColor.systemRed.cgColor

       return name
    }()


    private lazy var markImage: UIImageView = {
       let mark = UIImageView()
       mark.translatesAutoresizingMaskIntoConstraints = false
       mark.contentMode = .scaleAspectFill
       mark.clipsToBounds = true
       mark.layer.cornerRadius = 25
       mark.isUserInteractionEnabled = true

       let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMarkImage))
       mark.addGestureRecognizer(tapRecognizer)

       return mark
    }()

    private lazy var timeLabel: UILabel = {
       let time = UILabel()
       time.translatesAutoresizingMaskIntoConstraints = false
       time.textColor = UIColor.systemGray
       time.font = time.font.withSize(12)

       return time
    }()

    private lazy var counterLabel: UILabel = {
       let counter = UILabel()
       counter.translatesAutoresizingMaskIntoConstraints = false
       counter.textColor = UIColor.systemGray
       counter.font = counter.font.withSize(14)

       return counter
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)


        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupUI() {
        contentView.addSubview(nameHabitLabel)
        contentView.addSubview(markImage)
        contentView.addSubview(timeLabel)
        contentView.addSubview(counterLabel)

        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            markImage.leadingAnchor.constraint(equalTo: nameHabitLabel.trailingAnchor, constant: 20),
            markImage.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -30),
            markImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            markImage.widthAnchor.constraint(equalToConstant: 50),
            markImage.heightAnchor.constraint(equalToConstant: 50),

            timeLabel.topAnchor.constraint(equalTo: nameHabitLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }



    func updateData(habit: Habit) {
        self.habit = habit
        self.nameHabitLabel.text = habit.name
        self.nameHabitLabel.textColor = habit.color
        self.markImage.image = UIImage(systemName: "circle")
        self.markImage.tintColor = habit.color


        if habit.isAlreadyTakenToday {
            self.markImage.image = UIImage(systemName: "checkmark.circle.fill")
        }


        self.timeLabel.text = "Каждый день в " + getDateTimeText(date: habit.date)
        self.counterLabel.text = "Счетчик: \(habit.trackDates.count)"


        // self.markImage.layer.borderColor = habit.color.cgColor
        // self.markImage.layer.borderWidth = 3
        // self.markImage.backgroundColor = .blue
    }


    func getDateTimeText(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        return dateFormatter.string(from: date)
    }

    @objc
    private func tapMarkImage() {
        guard let habit = self.habit  else { return }

            if !habit.isAlreadyTakenToday {
                HabitsStore.shared.track(habit)

               // updateData(habit: habit)

                self.collectionView?.reloadData()
            }
        }
    }









