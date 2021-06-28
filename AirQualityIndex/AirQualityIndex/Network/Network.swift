//
//  NetworkLayer.swift
//  CodeAssignment
//
//  Created by Mollick, Tapash on 27/06/21.
//

import Foundation
import Starscream
import ObjectMapper

enum Result<Value, CustomError: Swift.Error > {
    case success(Value)
    case failure(CustomError)
}

enum CustomError: Error {
    case networkUnavailable
    case invalidStatusCode
    case parsingError
    case unexpected(code: Int)
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .parsingError:
                return "Could not parse."
            case .invalidStatusCode:
                return "The satus code is not valid."
            case .networkUnavailable:
                return "The network is not available."
            case .unexpected(_):
                return "An unexpected error occurred."
        }
    }
}

open class Network {
    
    var socket: WebSocket!
    typealias handler = (Result<Data,Error>) -> Void
     var bindDataToViewModel: (([City]) -> ()) = {_ in }

     func load(then handler: @escaping handler) {
        var request = URLRequest(url: URL(string: "ws://city-ws.herokuapp.com/")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}

extension Network: WebSocketDelegate {
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                debugPrint("\nconnected: \(headers)")
            case let .disconnected (reason, code):
                debugPrint("\n disconnected \t reason: \(reason) \t code: \(code)")
            case .text(let string):
                handleMessage(jsonString: string)
                debugPrint("text: \(string)")
            case .binary(let data) :
                debugPrint("binary :\(data)")
            case .cancelled:
                debugPrint("\n cancelled")
            case .error(let error):
                debugPrint("\n error: \(String(describing: error))")
            case .ping(_), .pong(_), .viabilityChanged(_), .reconnectSuggested(_) :
                break
        }
    }
    
    func handleMessage(jsonString: String){
        if jsonString.count > 0 {
            guard let data = Mapper<City>().mapArray(JSONString: jsonString) else {
                self.bindDataToViewModel([])
                return
            }
            self.bindDataToViewModel(data)
        }
    }
}


