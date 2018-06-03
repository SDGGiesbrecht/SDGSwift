/*
 ControlFlow.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

func main() {

    if number.isIrrational {
        number.round()
    }

    for element in [1, 2, 3] {

    }

    let trailingClosure = [1, 2, 3].filter { (number: Int) -> Bool in
        return number == 1
    }

    let number = 1
    switch number {
    case 1:
        print("one")
    default:
        print("default")
    }

    guard boolean == true else {
        preconditionFailure()
    }

    while something {
        // Wait.
    }

    repeat {
        someTask()
    } while time < 10
}
