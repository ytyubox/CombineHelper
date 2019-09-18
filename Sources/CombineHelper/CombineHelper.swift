import Combine

@available(iOS 13.0, *)
public final class GenericSubscriber<Input, Failure:Error>: Subscriber {
    @available(iOS 13.0, *)
    public
    init(receive:@escaping ((Input)->Subscribers.Demand)) {
        self.receiveHandle = receive
    }
    
    public var subscriptionHandle:((Subscription)->Void)?
    public var receiveHandle:((Input)->Subscribers.Demand)
    public var completionHandle:((Subscribers.Completion<Error>)->Void)?
  
    @available(iOS 13.0, *)
    public func receive(subscription: Subscription) {
    subscriptionHandle?(subscription)
  }
  
    @available(iOS 13.0, *)
    public func receive(_ input: Input) -> Subscribers.Demand {

    return  receiveHandle(input)
  }
  
    @available(iOS 13.0, *)
    public func receive(completion: Subscribers.Completion<Error>) {
        completionHandle?(completion)
  }
}
