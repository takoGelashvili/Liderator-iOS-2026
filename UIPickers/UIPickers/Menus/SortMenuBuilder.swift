//
//  SortMenuBuilder.swift
//  UIPickers
//
//  Declarative menu construction. Modern UIMenu + UIAction replaces
//  delegation for the common case — no protocol to implement, no
//  boilerplate, the closure carries the action.
//
//  Builder is generic over `SortOption.allCases` so adding a new option
//  to the enum automatically adds a row to the menu.
//

import UIKit

enum SortMenuBuilder {

    /// Build a single-selection menu where the current selection shows a checkmark.
    static func makeMenu(current: SortOption,
                         onSelect: @escaping (SortOption) -> Void) -> UIMenu {
        let actions = SortOption.allCases.map { option in
            UIAction(
                title: option.title,
                image: UIImage(systemName: option.systemImageName),
                state: option == current ? .on : .off
            ) { _ in
                onSelect(option)
            }
        }
        return UIMenu(title: "Sort by", children: actions)
    }

    /// Build a context menu shown on long-press over a single item.
    static func makeContextMenu(itemName: String,
                                onShare:  @escaping () -> Void,
                                onDelete: @escaping () -> Void) -> UIMenu {
        let share = UIAction(title: "Share \"\(itemName)\"",
                             image: UIImage(systemName: "square.and.arrow.up")) { _ in
            onShare()
        }
        let delete = UIAction(title: "Delete",
                              image: UIImage(systemName: "trash"),
                              attributes: .destructive) { _ in
            onDelete()
        }
        return UIMenu(children: [share, delete])
    }
}
