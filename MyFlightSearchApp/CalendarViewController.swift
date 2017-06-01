//
//  CalendarViewController.swift
//  MyFlightSearchApp
//
//  Created by Christophe Foucan on 14/05/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import FSCalendar

protocol CalendarViewControllerProtocol{
    func close(_ controller: UIViewController, beginDate: String, endDate: String, index: Int)
}

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendarView: FSCalendar!
    var tag : Int = 0
    var indexDate : Int = 0
    var initDate : Date = NSDate(timeIntervalSince1970: 0) as Date
    var departureDate: Date = NSDate(timeIntervalSince1970: 0) as Date
    var arrivalDate: Date = NSDate(timeIntervalSince1970: 0) as Date
    
    let gregorian = Calendar(identifier: .gregorian)
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr-FR")
        formatter.dateFormat = "E MMM dd, yyyy"
        return formatter
    }()

    var viewModel = CalendarViewModel()
    
    var delegate: CalendarViewControllerProtocol?
    
    var customCell = CustomCalendarCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
        
        calendarView.appearance.weekdayTextColor = Color.MYAPPCOLOR
        calendarView.appearance.selectionColor = Color.MYAPPCOLOR
        calendarView.appearance.headerTitleColor = Color.MYAPPCOLOR
        calendarView.appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM YYYY", options: 0, locale: Locale(identifier: "en_US"))
        
        calendarView.pagingEnabled = false
        calendarView.swipeToChooseGesture.isEnabled = true
        
        switch tag {
        case 0:
            calendarView.allowsMultipleSelection = false
            break
        case 1:
            calendarView.allowsMultipleSelection = true
            break
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.delegate?.close(self, beginDate: Default.departureDate_text.rawValue, endDate: Default.arrivalDate_text.rawValue, index: 4)
    }

    @IBAction func validate(_ sender: UIBarButtonItem) {
        if(viewModel.checkPeriod(selectedDate : viewModel.selectedDateArray)) {
            self.delegate?.close(self, beginDate: self.dateFormatter.string(from: departureDate).capitalized, endDate: self.dateFormatter.string(from: arrivalDate).capitalized,  index: tag)
        }
        else {
            let alert = UIAlertController(title: "Erreur", message: viewModel.error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in })
            self.present(alert, animated: true)
        }
    }
    
    // MARK:- FSCalendarDataSource
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            return formatter.string(from: date)
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.availableDate(selectedDate: calendar.selectedDates)
        setDate(date: date)

        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        self.configureVisibleCells()
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        viewModel.availableDate(selectedDate: calendar.selectedDates)
        setDate(date: date)
        self.configureVisibleCells()
    }
    
    func setDate(date: Date) {
        if(tag == 0) {
            self.departureDate = date
        }
        else {
            if(viewModel.selectedDateArray.count > 0) {
                self.departureDate = viewModel.selectedDateArray.first!
                self.arrivalDate = viewModel.selectedDateArray.last!
            }
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .month, value: 12, to: Date())
        return endDate!
    }
    
    private func configureVisibleCells() {
        calendarView.visibleCells().forEach { (cell) in
            let date = calendarView.date(for: cell)
            let position = calendarView.monthPosition(for: cell)
            self.configure(cell: cell, for: date, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let customCell = cell as! CustomCalendarCell
        // Custom today circle
        if(self.gregorian.isDateInToday(date)) {
            customCell.appearance.titleTodayColor = UIColor.black
        }
        // Configure selection layer
        if position == .current {
            var selectionType = SelectionType.none
            
            if calendarView.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendarView.selectedDates.contains(date) {
                    if calendarView.selectedDates.contains(previousDate) && calendarView.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendarView.selectedDates.contains(previousDate) && calendarView.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendarView.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                customCell.selectionLayer.isHidden = true
                return
            }
            customCell.selectionLayer.isHidden = false
            customCell.selectionType = selectionType
            
        } else {
            customCell.selectionLayer.isHidden = true
        }
        
    }

}

