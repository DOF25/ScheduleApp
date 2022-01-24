//
//  Builder.swift
//  ScheduleApp
//
//  Created by Крылов Данила  on 01.01.2022.
//

import UIKit

final class Builder {

    private static func createNavigationController(vc: UIViewController,
                                    itemName: String,
                                    itemImage: String) -> UINavigationController {

        let tabBarItem = UITabBarItem(title: itemName,
                                      image: UIImage(systemName: itemImage)?
                                        .withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)),
                                      tag: 0)
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)

        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }

    static func createTabBarViewController() -> UITabBarController {

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            createNavigationController(vc: ScheduleViewController(),
                                       itemName: "Schedule",
                                       itemImage: "calendar"),
            createNavigationController(vc: TasksViewController(),
                                       itemName: "Tasks",
                                       itemImage: "list.bullet.rectangle"),
            createNavigationController(vc: ContactsViewController(),
                                       itemName: "Contacts",
                                       itemImage: "person.3")
        ]

        return tabBarController

    }
}
