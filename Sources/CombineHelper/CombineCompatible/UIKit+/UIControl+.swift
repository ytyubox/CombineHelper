//
//  File.swift
//  
//
//  Created by 游宗諭 on 2019/10/9.
//

import Combine
#if !os(macOS)
import UIKit

extension CombineCompatible where Self: UIControl {
   public func publisher(for event: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, event: event)
    }
}

struct UIControlPublisher<Control: UIControl>: Publisher {

    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let controlEvent: UIControl.Event

    init(control: Control, event: UIControl.Event) {
        self.control = control
        self.controlEvent = event
    }

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvent)
        subscriber.receive(subscription: subscription)
    }
}

final class UIControlSubscription<SubscriberType: Subscriber,
                                  Control: UIControl>: Subscription
                                  where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
    }

    func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}
#endif
