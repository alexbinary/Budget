
import Foundation



enum Formatter {
    

    static func format(currency number: Double) -> String {

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: abs(number)))!
    }
}
