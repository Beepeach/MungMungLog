//
//  CalendarViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/07/09.
//

import UIKit

class CalendarViewController: UIViewController {
    private let cellIdentifier: String = "DaySquareCollectionViewCell"
    private var selectedDate: Date = Date()
    private var daySquares: [String] = []
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func increaseMonth(_ sender: Any) {
        selectedDate = MonthChanger().plusOneMonth(date: selectedDate)
        createMonthCalendar()
    }
    
    @IBAction func decreaseMonth(_ sender: Any) {
        selectedDate = MonthChanger().minusOneMonth(date: selectedDate)
        createMonthCalendar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender: UICollectionViewCell = sender as? UICollectionViewCell else { return }
        guard let indexPath: IndexPath = collectionView.indexPath(for: sender) else { return }
        guard let targetCell: DaySquareCollectionViewCell = collectionView.cellForItem(at: indexPath) as? DaySquareCollectionViewCell else { return }
        
        guard let nav: UINavigationController = segue.destination as? UINavigationController else { return }
        guard let vc: DetailDateViewController =  nav.children.first as? DetailDateViewController else { return }
        
        vc.setDate(date: targetCell.getDate() ?? Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCellSize()
        createMonthCalendar()
    }
    
    private func setCellSize() {
        guard let flowLayout: UICollectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let expectedHorizonCellCount: Int = 7
        let expectedVerticalCellCount: Int = 5
        
        let lineSpacing: CGFloat = flowLayout.minimumLineSpacing
        let itemSpacing: CGFloat = flowLayout.minimumInteritemSpacing
        
        let otherHorizonInset: CGFloat = itemSpacing * CGFloat(expectedHorizonCellCount - 1)
        let otherVerticalInset: CGFloat = lineSpacing * CGFloat(expectedVerticalCellCount - 1)
        
        let width: CGFloat = (view.frame.size.width - otherHorizonInset) / CGFloat(expectedHorizonCellCount)
        let height: CGFloat = (view.frame.size.height - otherVerticalInset) / CGFloat(expectedVerticalCellCount)
        
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func createMonthCalendar() {
        daySquares.removeAll()
        
        var daySquaresGenerator: DaySquareGenerator = DaySquareGenerator()
        
        daySquares = daySquaresGenerator.create(date: selectedDate)
        configureMonthLabel()
        collectionView.reloadData()
    }
    
    private func configureMonthLabel() {
        monthLabel.text = selectedDate.yearFormatted + "" + selectedDate.monthFormatted
    }
    
    public func getSelectedDate() -> Date {
        return self.selectedDate
    }
    
    public func setSelectedDate(date: Date) {
        selectedDate = date
    }
}


// MARK: - UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daySquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DaySquareCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? DaySquareCollectionViewCell else {
            return DaySquareCollectionViewCell()
        }
        
        cell.dayOfMonthLabel.text = daySquares[indexPath.item]
        
        guard let year: Int = CalendarCalculator().extractYearComponent(date: selectedDate).year,
              let month: Int = CalendarCalculator().extractMonthComponent(date: selectedDate).month else {
            return cell
        }
        
        
        if let day: Int = Int(daySquares[indexPath.item]) {
            let date: Date = DateGenerator().create(year: year, month: month, day: day) ?? Date()
            cell.setDate(date: date)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if daySquares[indexPath.item] == "" {
            return false
        }
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DaySquareCollectionViewCell else { return }
    }
}
