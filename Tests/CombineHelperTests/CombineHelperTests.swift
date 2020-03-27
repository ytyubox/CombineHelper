import XCTest
@testable import CombineHelper
import Foundation

final class CombineHelperTests: XCTestCase {
  let session = URLSession.shared
  func testURLDataTaskPublisher() {
    let wait = XCTestExpectation()
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    let anyCancellable = session.dataTaskPublisher(for: url)
      .handleResponse(handleRes)
      .strPrint()
      .twoDecode(twDecodable: Result<Todo,TodoError>.self, decoder: JSONDecoder())
      .sink(receiveCompletion: {_ in}, receiveValue: handleResult)
    
    self.wait(for: [wait], timeout: 15)
    anyCancellable.cancel()
  }
  enum S:Error {
    case not200
  }
  
  func handleRes(_ output: URLSession.DataTaskPublisher.Output) throws {
    let httpURLResponse = output.response as! HTTPURLResponse
    guard
      httpURLResponse.statusCode == 200
      else {
        throw S.not200
    }
    
  }
  
  func handleResult<Success,Failure: Error>(_ r: Result<Success,Failure>) {
    switch r {
      case .success(let it): print(it)
      case .failure(let it): print(it)
    }
  }
  
  // MARK: - TransactionResponse
  struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
      case userID = "userId"
      case id, title, completed
    }
  }
  
  struct TodoError:Codable,Error {
    let msg:String
  }
}
