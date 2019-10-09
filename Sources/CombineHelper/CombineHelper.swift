import Combine


public final class GenericSubscriber<Input, Failure:Error>: Subscriber {
    public init(receive:@escaping ((Input)->Subscribers.Demand)) {
        self.receiveHandle = receive
    }
    
    public var subscriptionHandle:((Subscription)->Void)?
    public var receiveHandle:((Input)->Subscribers.Demand)
    public var completionHandle:((Subscribers.Completion<Error>)->Void)?
  
    public func receive(subscription: Subscription) {
    subscriptionHandle?(subscription)
  }
  
    public func receive(_ input: Input) -> Subscribers.Demand {
    return  receiveHandle(input)
  }
  
    public func receive(completion: Subscribers.Completion<Error>) {
        completionHandle?(completion)
  }
}
