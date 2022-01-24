//
//  ScheduleViewController.swift
//  ScheduleApp
//
//  Created by Крылов Данила  on 11.01.2022.
//

import UIKit
import FSCalendar

final class ScheduleViewController: UIViewController {

    //MARK: - Property
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    private let changeCalenderHeightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Expand calendar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()

    private var calendarHeightContraint: NSLayoutConstraint!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Schedule"
        setConstraints()
        configureCalendar()
        configureButton()
        swipeGesture()

    }

    //MARK: - Constraints
    private func setConstraints() {

        ///calendar
        view.addSubview(calendar)
        let safeArea = view.safeAreaLayoutGuide

        self.calendarHeightContraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(self.calendarHeightContraint)

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0)
        ])
        ///changeCalenderHeightButton
        view.addSubview(changeCalenderHeightButton)
        NSLayoutConstraint.activate([
            changeCalenderHeightButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            changeCalenderHeightButton.centerXAnchor.constraint(equalTo: calendar.centerXAnchor),
            changeCalenderHeightButton.heightAnchor.constraint(equalToConstant: 20),
            changeCalenderHeightButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    //MARK: - Calendar
    private func configureCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .week
    }

    //MARK: - Button
    private func configureButton() {
        changeCalenderHeightButton.addTarget(self, action: #selector(showHideCalendar), for: .touchUpInside)
    }

    @objc private func showHideCalendar() {

        if self.calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            changeCalenderHeightButton.setTitle("Collapse calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            changeCalenderHeightButton.setTitle("Expand calendar", for: .normal)
        }
    }

    //SwipeGestureRecognizer
    func swipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(collapse))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(expand))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }

    @objc private func collapse() {
        calendar.setScope(.week, animated: true)
        changeCalenderHeightButton.setTitle("Expand calendar", for: .normal)
    }

    @objc private func expand() {
        calendar.setScope(.month, animated: true)
        changeCalenderHeightButton.setTitle("Collapse calendar", for: .normal)
    }

}

//MARK: - FSCalendarDataSource
extension ScheduleViewController: FSCalendarDataSource {

}

//MARK: - FSCalendarDelegate
extension ScheduleViewController: FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightContraint.constant = bounds.height
        view.layoutIfNeeded()
    }
}
