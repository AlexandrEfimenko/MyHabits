//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Ефименко on 11.05.2024.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    static let idCell = "ProgressCollectionViewCell"

    lazy var progressView: UIProgressView = {
       let progress = UIProgressView()
       progress.translatesAutoresizingMaskIntoConstraints = false
       return progress
    }()

    private lazy var titleLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.systemGray
        view.text = "Всё получится!"

       return view
    }()

    private lazy var percentLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.systemGray

       return view
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressView)

        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)


        ])
    }

    func updateData() {
        let progress = HabitsStore.shared.todayProgress
        self.progressView.setProgress(progress, animated: true)
        self.percentLabel.text = "\(Int(progress*100)) %"
    }

}
