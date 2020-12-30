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
    
    var koreaTimeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }
}
