import UIKit


extension UIViewController {
    static var currentCalendar: Calendar {
        return Calendar.current
    }
    
    var koreaDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ko_kr")
        dateFormatter.dateStyle = .long
        
        return dateFormatter
    }
}
