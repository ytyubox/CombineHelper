# CombineHelper


## URLSession.DataTaskPublisher

```swift
let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
let anyCancellable = session.dataTaskPublisher(for: url)
    .handleResponse(handleRes)
    .strPrint()
    .twoDecode(twDecodable: Result<Todo,TodoError>.self, decoder: JSONDecoder())
    .sink(receiveCompletion: {_ in }, receiveValue: handleResult)
```
