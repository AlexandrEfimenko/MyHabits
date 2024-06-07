//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр Ефименко on 09.04.2024.
//

import UIKit

final class InfoViewController: UIViewController {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = """
Экспертиза Игоря Федотова.
        В РПЛ остался всего один тур, и интриг перед ним полно. Неудивительно, что в последние недели матчи особенно напряжённые, а работа арбитров рассматривается под микроскопом. 29-й тур, к счастью, обошёлся без громких судейских скандалов.

        Специально для «Чемпионата» судейство в 29-м туре чемпионата России разобрал наш эксперт, бывший арбитр РПЛ Игорь Федотов. Ниже — его экспертиза по всем восьми матчам.

        Максимальная оценка — 8,5. Её арбитр получает, если проводит матч без ошибок.

        Оценка снижается до 7,9, если арбитр допускает одну ключевую ошибку — неправильное назначение или неназначение 11-метрового удара, показ красной или непоказ прямой красной (игроку или членам тренерского штаба), показ или непоказ второй жёлтой карточки (игроку или членам тренерского штаба).

        В случае второй ключевой ошибки снимается 0,5 балла.

        0,1 балла снимается за неправильный показ или непоказ жёлтой карточки (игроку или членам тренерского штаба), а также за пропуск от трёх до пяти нарушений.

        1 балл снимается, если арбитр на VAR указал на ошибку судьи в поле, но тот оставил своё неправильное решение в с

тест
тест 2
тест 3
end
"""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var  contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private lazy var  scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea  = view.safeAreaLayoutGuide

        let constraints: [NSLayoutConstraint] = [

            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)


    }

}
