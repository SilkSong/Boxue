import UIKit

class Student {
    let email: String
    let firstName: String
    let lastName: String
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    } }
extension Student: Hashable {
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.email == rhs.email &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(firstName)
        hasher.combine(lastName)
    } }

let john = Student(email: "johnny.appleseed@apple.com", firstName:
    "Johnny", lastName: "Appleseed")
let lockerMap = [john: "14B"]
