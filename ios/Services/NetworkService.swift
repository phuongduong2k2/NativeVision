//
//  NetworkService.swift
//  NativeVision
//
//  Created by Duong Phuong on 6/8/25.
//

import Foundation
import AVFoundation

enum NetworkError: Error {
  case BadResponse(URLResponse?)
  case BadURL
  case BadData
}

enum HttpMethod: String {
  case POST = "POST"
  case PUT = "PUT"
  case GET = "GET"
  case DELETE = "DELETE"
}

class NetworkService {
  static let share = NetworkService()
  
  private var session: URLSession!
  
  init() {
    let config = URLSessionConfiguration.default
    session = URLSession(configuration: config)
  }
  
  func createComponent() -> URLComponents {
    var component = URLComponents()
    component.scheme = "https"
    return component
  }
  
  func createRequest(url: URL, method: HttpMethod) -> URLRequest? {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    return request
  }
  
  func getData(urlString: String, completion: @escaping ((Data?, Error?) -> Void)) {
    guard let url = URL(string: urlString) else {
      completion(nil, NetworkError.BadURL)
      return
    }
    let request = URLRequest(url: url)
    
    let task = session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        completion(nil, NetworkError.BadResponse(response))
        return
      }
      
      guard let data = data else {
        completion(nil, NetworkError.BadData)
        return
      }
      
      completion(data, nil)
    }
    task.resume()
  }
}
