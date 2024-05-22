//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Ефименко on 09.04.2024.
//

import UIKit

class HabitsViewController: UIViewController {

    private enum LayoutConstant {
          static let spacing: CGFloat = 20.0
          static let itemHeight: CGFloat = 120.0
          static let itemWidth: CGFloat = 350.0
      }


    private lazy var collectionView: UICollectionView  = {
        let viewLayout = UICollectionViewFlowLayout()

        viewLayout.itemSize = .init(width: LayoutConstant.itemWidth, height: LayoutConstant.itemHeight)
        viewLayout.minimumLineSpacing = LayoutConstant.spacing


        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemBackground

        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 30)
        ]
    }

    func setupUI() {
       title = "Сегодня"


        view.addSubview(collectionView)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(onTapPlus))
    }

    func setupCollectionView(){
        collectionView.register(HabitCollectionViewCell.self,
                                forCellWithReuseIdentifier: HabitCollectionViewCell.idCell)

        collectionView.register(ProgressCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProgressCollectionViewCell.idCell)

        collectionView.delegate = self
        collectionView.dataSource = self
    }


    func setupConstraints(){
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 5)
        ])
    }



    @objc
    func onTapPlus() {
        let habitVC = HabitViewController(habit: nil, habitsVC: self)

        let habitNavigation = UINavigationController(rootViewController: habitVC)
        present(habitNavigation, animated: true)
    }

}


extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count + 1 // доп ячейка для прогресса
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.idCell, for: indexPath) as! ProgressCollectionViewCell
            cell.updateData()

            return cell

        } else {
            let habit: Habit = HabitsStore.shared.habits[indexPath.row-1]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.idCell, for: indexPath) as! HabitCollectionViewCell
            cell.updateData(habit: habit)

            return cell
        }

    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 0 {
            return CGSize(width: LayoutConstant.itemWidth, height: 60)

        } else {
            return CGSize(width: LayoutConstant.itemWidth, height: LayoutConstant.itemHeight)
        }
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int ) -> CGFloat {

        LayoutConstant.spacing
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row != 0 {
            let habit: Habit = HabitsStore.shared.habits[indexPath.row-1]

            let vc = HabitDetailsViewController(habit: habit, habitsVC: self)
            navigationController?.pushViewController(vc, animated: true)

        }
    }




    func reloadCollectionView() {
        self.collectionView.reloadData()
    }



}
