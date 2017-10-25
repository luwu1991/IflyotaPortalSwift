//
//  CalendarViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    var firstDate: Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.cellSize = (SCREENW - 20)/7 //cell的高
        calendarView.showsVerticalScrollIndicator = false
        calendarView.allowsMultipleSelection = true
//        calendarView.isRangeSelectionUsed = true
        
        calendarView.register(UINib (nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        calendarView.register(CalenderHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CalendarViewController:JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2017 08 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 5, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .off,
            firstDayOfWeek: .monday)
        return parameters
    }
    
 

    func configureVisibleCell(myCustomCell: DateCell, cellState: CellState, date: Date) {
        myCustomCell.Daylabel.text = cellState.text
        if cellState.dateBelongsTo != .thisMonth {
            myCustomCell.isHidden = true
        }else{
            myCustomCell.isHidden = false
        }
        
        if Calendar.current.isDateInToday(cellState.date) {
            myCustomCell.backgroundColor = UIColor.red
        }else{
            myCustomCell.backgroundColor = LWColor(r: 245, g: 245, b: 245, a: 1.0)
        }
//
//        if date.compare(Date()) == .orderedAscending{
//            myCustomCell.Daylabel.textColor = UIColor.red
//        }else{
//            myCustomCell.Daylabel.textColor = UIColor.black
//        }
    }
    
    func handleSelection(cell:DateCell,cellState:CellState){

        print(calendarView.selectedDates.count)
        if cell.isSelected {
            cell.backgroundColor = ThemeColor()
        }else{
            cell.backgroundColor = LWColor(r: 245, g: 245, b: 245, a: 1.0)
        }
        
        if calendarView.selectedDates.count == 0{
            return
        }
        if calendarView.selectedDates.count == 1 {
            cell.selectPosition = .only
            return
        }
        
        if cellState.date.compare(calendarView.selectedDates.first!) == .orderedSame {
            cell.selectPosition = .first
            return
        }
        
        if cellState.date.compare(calendarView.selectedDates.last!) == .orderedSame {
            cell.selectPosition = .last
            return
        }
        
        cell.selectPosition = .middle
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let myCustomCell = cell as! DateCell
        
        if calendar.selectedDates.count > 2{

            calendar.deselect(dates: calendar.selectedDates, triggerSelectionDelegate: false)
            calendar.selectDates([date], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            firstDate = date
            handleSelection(cell: myCustomCell, cellState: cellState)
            return
        }
        
        if firstDate != nil && firstDate?.compare(date) != ComparisonResult.orderedSame{
            let result = firstDate?.compare(date)
            if result == ComparisonResult.orderedAscending{
                calendarView.selectDates(from: firstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }else{
                calendarView.selectDates(from: date, to: firstDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
            
        }else{
            firstDate = date
            
            handleSelection(cell: myCustomCell, cellState: cellState)
            
        }

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
//        handleSelection(cell: cell as! DateCell, cellState: cellState)
        if calendar.selectedDates.count == 1 {
            return
        }
        
        calendar.deselect(dates: calendar.selectedDates, triggerSelectionDelegate: false)
        calendar.selectDates([date], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
        firstDate = date
        let myCustomCell = cell as! DateCell
        handleSelection(cell: myCustomCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        handleSelection(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize?{
        return MonthSize(defaultSize: 50, months: [75: [.feb, .apr]])
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let date = range.start
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let header: CalenderHeaderView
   
            header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "HeaderView", for: indexPath) as! CalenderHeaderView
            header.titleLabel.text = "\(year)年\(month)月"
        
        return header
    }
    
    
}
