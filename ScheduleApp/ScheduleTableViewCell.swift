//
//  ScheduleTableViewCell.swift
//  ScheduleApp
//
//  Created by Крылов Данила  on 26.01.2022.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {

    //MARK: - Properties
    let lessonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lesson Name"
        label.font = UIFont(name: "Georgia-Italic", size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let teacherName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lesson Name"
        label.font = UIFont(name: "Georgia-Italic", size: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Private methods
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [self.lessonName, self.teacherName])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
}
