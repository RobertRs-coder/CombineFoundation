/*
  Example: Notification Center.
 */

import Combine
import Foundation

//Is need it to use notification center o URLSession inside playground
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//We extend notification center with our own message
extension Notification.Name{
    static let myNotification = Notification.Name("Keepcoding.clase.combine")
}

var message: String = ""{
    didSet{
        print("New value: \(message)")
    }
}

//Create notification center Publisher
let publisher = NotificationCenter.default
    .publisher(for: .myNotification)
    .map{
        $0.object as? String
    }
    .replaceNil(with: "nil data")
    .replaceError(with: "error data")
    .replaceEmpty(with: "empty data")

//Create the subscriber
var subscriber : AnyCancellable?

//subscriber = publisher.sink(receiveValue: {
//    message = $0
//})

subscriber = publisher
    .sink{
        message = $0
    }

//Create a timer each 3 seconds which we send it by Notification Center
let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
    // Send it by Notification Center
    NotificationCenter.default.post(name: .myNotification, object: "Secret message \(Int.random(in: 1...50))")
}

