//
//  CalendarViewController.swift
//  IflyotaPortalSwift
//
//  Created by luwu on 2017/10/24.
//  Copyright © 2017年 iflyota. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: LWBaseViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    var rightBtn = UIBarButtonItem()
    var firstDate: Date?
    let backThemeColor = LWColor(r: 245, g: 245, b: 245, a: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "酒店日期选择"
        self.automaticallyAdjustsScrollViewInsets = false
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.cellSize = (SCREENW - 20)/7 //cell的高
        calendarView.showsVerticalScrollIndicator = false
        calendarView.allowsMultipleSelection = true
        calendarView.register(UINib (nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        calendarView.register(CalenderHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
        
        let today = Date()
        
        let t = Calendar.current.date(byAdding: .day, value: 1, to: today)
        let tt = Calendar.current.date(byAdding: .day, value: 2, to: today)
        calendarView.selectDates([t!,tt!], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
        
        setRightTitle(2)
        // Do any additional setup after loading the view.
    }

    func setRightTitle(_ number:Int) {
        let rightTitle = UILabel()
        rightTitle.text = "共\(number)晚"
        rightTitle.textColor = ThemeColor()
        rightTitle.sizeToFit()
        rightBtn = UIBarButtonItem.init(customView: rightTitle)
        
        self.navigationItem.rightBarButtonItem = rightBtn
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
        let startMonth = Calendar.current.component(.month, from: Date())
        let startDate = formatter.date(from: "2017 0\(startMonth) 01")!
        let endMDate = Calendar.current.date(byAdding: .month, value: 2, to: startDate)
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endMDate!,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
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
        
        if cellState.date.compare(Date()) == .orderedAscending {
            myCustomCell.isUserInteractionEnabled = false
        }
        else{
            myCustomCell.isUserInteractionEnabled = true
        }
        
       
        
        if calendarView.selectedDates.count == 1 && calendarView.selectedDates.first?.compare(date) == .orderedSame {
            myCustomCell.selectPosition = .only
            return
        }
        
        if calendarView.selectedDates.count > 1 {
            let startDate = calendarView.selectedDates.first!
            let endDate = calendarView.selectedDates.last!
            if  date.compare(startDate) == .orderedSame {
                myCustomCell.selectPosition = .first
                return
            }
            
            if date.compare(endDate) == .orderedSame {
                myCustomCell.selectPosition = .last
                return
            }
            
            if date.compare(startDate) == .orderedDescending && date.compare(endDate) == .orderedAscending {
                myCustomCell.selectPosition = .middle
                return
            }
        }
        
        if Calendar.current.isDateInToday(cellState.date) {
            myCustomCell.backgroundColor = LWColor(r: 200, g: 200, b: 200, a: 1.0)
            myCustomCell.Daylabel.textColor = UIColor.white
            myCustomCell.layer.cornerRadius = myCustomCell.width/2
        }else{
            myCustomCell.backgroundColor = backThemeColor
            myCustomCell.Daylabel.textColor = UIColor.black
            myCustomCell.layer.cornerRadius = 0
            myCustomCell.selectPosition = .noneSelect
        }
        
        

        
    }
    
    func handleSelection(cell:DateCell,cellState:CellState){

        
        
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
        
        if calendar.selectedDates.count > 2{
            print(date)
            setAllCellDesSelect(dates: calendar.selectedDates)
            calendar.deselect(dates: calendar.selectedDates, triggerSelectionDelegate: false)
            calendar.selectDates([date], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: false)
            firstDate = date
            self.navigationItem.rightBarButtonItem = nil
            return
        }
        
        if firstDate != nil && firstDate?.compare(date) != ComparisonResult.orderedSame{
            let result = firstDate?.compare(date)
            if result == ComparisonResult.orderedAscending{
                calendarView.selectDates(from: firstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }else{
                calendarView.selectDates(from: date, to: firstDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
            
          let components =  Calendar.current.dateComponents([.day], from: firstDate!, to: date)
            setRightTitle(components.day!)
            
        }else{
            firstDate = date
            calendarView.selectDates([date], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
             self.navigationItem.rightBarButtonItem = nil
        }

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        

        if calendar.selectedDates.count == 1 {
            return
        }
        setAllCellDesSelect(dates: calendar.selectedDates)
        
        calendar.deselect(dates: calendar.selectedDates, triggerSelectionDelegate: false)
        calendar.selectDates([date], triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
        firstDate = date

    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        
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
    
    func setAllCellDesSelect(dates:[Date]){
        if dates.count == 0 {
            return
        }
        
        for index in 0...dates.count - 1{
            let cell = calendarView.cellStatus(for: dates[index])!.cell() as! DateCell
            cell.selectPosition = .noneSelect
        }
    }
}
