//
//  EventDetailViewController.swift
//  bgfestivals
//
//  Created by Gabriela Zagarova on 3/12/17.
//  Copyright © 2017 Gabriela Zagarova. All rights reserved.
//

import UIKit

typealias ActionBlock = (_ action: UIPreviewAction, _ controller: UIViewController) -> Void

let defaultCellHeight: CGFloat = 216
let mainAppColor: UIColor = .red


class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerToolBar: UIToolbar!
    @IBOutlet weak var footerButton: UIBarButtonItem!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet var ratingAlertView: RatingAlert!
    
    @IBOutlet var viewTapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: Important store a reference for Preview Interaction
    var ratePreviewInteraction: Any?
    
    var isPreviewed: Bool?
    var currentEvent: Event?
    var editMode: Bool?
    
    // MARK: Register for Preview Actions
    @available(iOS 9.0, *)
    override var previewActionItems: [UIPreviewActionItem] {
        var items: [UIPreviewActionItem] = []
        
        // Conditional
        if let currentEvent = currentEvent, currentEvent.isSelected {
            // MARK: Selected style no need handler example
            let isSelected = UIPreviewAction(title: "Going", style: .selected, handler: { (action, viewController) in
                
            })
            items.append(isSelected)
            
            
            // MARK: Preview Action Group example
            let handler: ActionBlock = { (action, viewController) in
                (viewController as! EventDetailViewController).putRatingToEvent(rating: 0)
            }
            let replayActions = [UIPreviewAction(title: "1", style: .default, handler: handler),
                                 UIPreviewAction(title: "2", style: .default, handler: handler),
                                 UIPreviewAction(title: "3", style: .default, handler: handler)]
            let rate = UIPreviewActionGroup(title: "Rate", style: .default, actions: replayActions)
            items.append(rate)
            
            
            // MARK: Default style example
            let share = UIPreviewAction(title: "Share", style: .default) { (action, viewController) in
                (viewController as! EventDetailViewController).shareEvent()
            }
            items.append(share)
            
            
            // MARK: Destructive style example
            let delete = UIPreviewAction(title: "Remove from going list", style: .destructive) { (action, viewController) in
                (viewController as! EventDetailViewController).deleteEvent()
            }
            items.append(delete)
            
        } else {
            
            // MARK: Default style example
            let addEventToGoingList = UIPreviewAction(title: "Add to going list", style: .default) { (action, viewController) in
                (viewController as! EventDetailViewController).addEventToGoingList()
            }
            items.append(addEventToGoingList)
        }
        
        return items
    }
    
    fileprivate var datePickerIndexPath: IndexPath?
    
    fileprivate var replyViewControllerIsPresented: Bool {
        return presentedViewController != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreenMode()
        configureTableView()
        
        // MARK: Register
        if #available(iOS 10.0, *) {
            let ratePreviewInteraction: UIPreviewInteraction = UIPreviewInteraction(view: view)
            ratePreviewInteraction.delegate = self
            self.ratePreviewInteraction = ratePreviewInteraction
        } else {
            // Fallback on earlier versions
        }
        
        ratingAlertView.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func footerButtonPressed(_ sender: Any) {
        if editMode == true {
            createEvent()
        } else {
            deleteEvent()
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        shareEvent()
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        showRatingAlert(fromLocation: sender.center)
    }
    
    @IBAction func tapGestureRecognizerTriggered(_ sender: UITapGestureRecognizer) {
        let tapGestureLocation = sender.location(in: view)
        if !ratingAlertView.frame.contains(tapGestureLocation) {
            hideRatingAlert()
        }
    }
    
    // MARK: Private actions
    
    fileprivate func deleteEvent() {
        print("Delete event \(currentEvent?.title)")
    }
    
    fileprivate func createEvent() {
        print("Create event \(currentEvent?.title)")
    }
    
    fileprivate func shareEvent() {
        print("Share event \(currentEvent?.title)")
    }
    
    fileprivate func addEventToGoingList() {
        print("Add \(currentEvent?.title) to going list")
    }
    
    fileprivate func putRatingToEvent(rating: Double) {
        print("Rate \(currentEvent?.title)")
    }
    
    // MARK: Rating alert
    fileprivate func showRatingAlert(fromLocation: CGPoint) {
        let yOffset = ratingAlertView.frame.size.height
        
        // choose whether to show it bellow or above interaction point
        var yCenter = fromLocation.y - yOffset
        if yCenter < 0 {
            yCenter = fromLocation.y + yOffset
        }
        
        var xCenter = fromLocation.x
        if  xCenter - ratingAlertView.frame.size.width/2 < 0 {
            xCenter = xCenter + ratingAlertView.frame.size.width/2
        }
        else if xCenter + ratingAlertView.frame.size.width/2 > view.frame.size.width {
            xCenter = xCenter - ratingAlertView.frame.size.width/2
        }
        
        ratingAlertView.center = CGPoint(x: xCenter, y: yCenter)
        showRatingAlert()
    }
    
    fileprivate func showRatingAlert() {
        if !ratingAlertView.shown {
            print("Show rating view")
            view.addSubview(ratingAlertView);
            view.bringSubview(toFront: ratingAlertView);
            
            ratingAlertView.shown = true
        }        
    }
    
    fileprivate func hideRatingAlert() {
        if ratingAlertView.shown {
            ratingAlertView.removeFromSuperview()
            ratingAlertView.shown = false
        }
    }
    
    // MARK: Config
    
    fileprivate func configureTableView() {
        tableView.estimatedRowHeight = defaultCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func configureScreenMode() {
        if let isPreviewed = isPreviewed {
            footerToolBar.isHidden = isPreviewed
            rateButton.isHidden = isPreviewed
        }
        
        if currentEvent == nil {
            footerButton.title = "Create"
            footerButton.tintColor = .mainApp()
            rateButton.isHidden = true
        } else {
            if currentEvent?.isSelected == true {
                footerButton.title = "Remove from going list"
                footerButton.tintColor = .red
            } else {
                footerButton.title = "Add to going list"
                footerButton.tintColor = .mainApp()
                rateButton.isHidden = true
            }
        }
    }
}


// MARK: UI Preview Interaction Delegate

@available(iOS 10.0, *)
extension EventDetailViewController: UIPreviewInteractionDelegate {
    
    @available(iOS 10.0, *)
    func previewInteractionShouldBegin(_ previewInteraction: UIPreviewInteraction) -> Bool {
        
        return true
    }
    
    @available(iOS 10.0, *)
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        if !ratingAlertView.shown {
            ratingAlertView.isUserInteractionEnabled = false
            showRatingAlert(fromLocation: previewInteraction.location(in: view))
        }
        
        ratingAlertView.alpha = transitionProgress
        
        if ended {
            ratingAlertView.isUserInteractionEnabled = true
        }
    }
    
    @available(iOS 10.0, *)
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdateCommitTransition transitionProgress: CGFloat, ended: Bool) {
        // Do additional actions on commit
        // not required
    }
    
    @available(iOS 10.0, *)
    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        ratingAlertView.isUserInteractionEnabled = false
        hideRatingAlert()
    }
}

extension EventDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EventDetailSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let datePickerIndexPath = datePickerIndexPath,
            let editMode = editMode,
            ((section == EventDetailSection.startDate.rawValue || section == EventDetailSection.endDate.rawValue) &&
                editMode && datePickerIndexPath.section == section) {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DatePickerTableViewCell.self)) as! DatePickerTableViewCell
            cell.delegate = self
            return cell
        }
        
        return EventDetailSection.cellSection(index: indexPath.section, tableView: tableView, currentEvent: currentEvent)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let indexPathCopy = datePickerIndexPath
        
        if ((indexPath.section == EventDetailSection.startDate.rawValue || indexPath.section == EventDetailSection.endDate.rawValue) && editMode!) {
            
            datePickerIndexPath = IndexPath(row: 1, section: indexPath.section)
            
            tableView.beginUpdates()
            
            if let oldIndexPath = indexPathCopy {
                tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            }
            
            if let newPickerIndexPath = datePickerIndexPath, indexPathCopy?.section != datePickerIndexPath?.section {
                tableView.insertRows(at: [newPickerIndexPath], with: .automatic)
            }
            datePickerIndexPath = indexPathCopy?.section == datePickerIndexPath?.section ? nil : datePickerIndexPath
            
            tableView .endUpdates()
            
        } else {
            datePickerIndexPath = nil
        }
    }
}

extension EventDetailViewController: UIToolbarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .bottom
    }
}

extension EventDetailViewController: DatePickerTableViewCellDelegate {
    
    func datePickerDidChangeValue(datePicker: UIDatePicker, cell: DatePickerTableViewCell) {
        if let cellIndxPath = tableView.indexPath(for: cell) {
            let labelIndexPath = IndexPath(row: 0, section: cellIndxPath.section)
            if let labelCell = tableView.cellForRow(at: labelIndexPath) as? RightTextFieldTableViewCell {
                labelCell.textField.text = String(describing: datePicker.date)
            }
        }
    }
}

extension EventDetailViewController {
    
    class func detailViewController(event: Event?) -> EventDetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let eventDetailViewController = storyboard.instantiateViewController(withIdentifier: String(describing: EventDetailViewController.self)) as? EventDetailViewController {
            if let event = event {
                eventDetailViewController.editMode = false
                eventDetailViewController.currentEvent = event
            } else {
                eventDetailViewController.editMode = true
            }
            return eventDetailViewController
        }
        return nil
    }
}

extension EventDetailViewController : RatingAlertDelegate {
    func ratingAlert(buttonTapped: RatingButton) {
        hideRatingAlert()
    
        let closeAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        let controller = UIAlertController.init(title: "You've rated sucessfully!", message: "Your rating is: " + (buttonTapped.titleLabel?.text)!, preferredStyle: .alert)
        controller.addAction(closeAction)
        present(controller, animated: true, completion: nil)
    }
}
