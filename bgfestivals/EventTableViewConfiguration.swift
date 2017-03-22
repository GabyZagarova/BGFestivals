//
//  EventTableViewConfiguration.swift
//  bgfestivals
//
//  Created by Gabriela Zagarova on 3/21/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import Foundation
import UIKit

enum EventDetailSection: Int {
    
    case image
    case title
    case location
    case raiting
    case startDate
    case endDate
    case eventDescription
    
    static var count: Int { return EventDetailSection.eventDescription.hashValue + 1}
    
    static func cellSectionIdentifier(index: Int) -> String {
        let sectionType = EventDetailSection(rawValue: index)
        switch sectionType! {
        case .image:
            return String(describing: ImageViewTableViewCell.self)
        case .title,.location, .raiting:
            return String(describing: TextFieldTableViewCell.self)
        case .startDate, .endDate:
            return String(describing: RightTextFieldTableViewCell.self)
        case .eventDescription:
            return String(describing: TextViewTableViewCell.self)
        }
    }
    
    static func cellSection(index: Int, tableView: UITableView, currentEvent: Event?) -> UITableViewCell {
        let sectionType = EventDetailSection(rawValue: index)
        switch sectionType! {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! ImageViewTableViewCell
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! TextFieldTableViewCell
            if let event = currentEvent {
                cell.textField.text = event.title
            } else {
                cell.textField.text = "Enter title"
            }
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! TextFieldTableViewCell
            cell.isTitle = false
            if let event = currentEvent {
                cell.textField.text = event.location
            } else {
                cell.textField.placeholder = "Enter location"
            }
            return cell
        case .raiting:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! TextFieldTableViewCell
            cell.isTitle = false
            if let event = currentEvent {
                cell.textField.text = "Rating \(String(event.rating))"
            } else {
                cell.textField.placeholder = "Enter rating 1,2,3"
            }
            return cell
        case .startDate:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! RightTextFieldTableViewCell
            cell.titleLabel.text = "Start Date"
            if let event = currentEvent {
                cell.textField.text = (event.startDate as! Date).toString()
            }
            cell.textField.isUserInteractionEnabled = false
            return cell
        case .endDate:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! RightTextFieldTableViewCell
            cell.titleLabel.text = "End Date"
            if let event = currentEvent {
                cell.textField.text = (event.endDate as! Date).toString()
            }
            cell.textField.isUserInteractionEnabled = false
            return cell
        case .eventDescription:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellSectionIdentifier(index: index)) as! TextViewTableViewCell
            if let event = currentEvent {
                cell.textView.text = event.eventDescription
                cell.placeholderText = nil
            } else {
                cell.placeholderText = "Add description for your event here"
            }
            return cell
        }
    }
    
}
