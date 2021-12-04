//
//  APIWorker.swift
//  PenguinPay
//
//  Created by Felipe Moreira Tarrio Bassi on 04/12/21.
//

import Foundation

protocol APIWorkerProtocol: AnyObject {
    associatedtype EndPoint: Requestable
    func request<T: Codable>(_ route: EndPoint, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func cancel()
}

class APIWorker<EndPoint: Requestable>: APIWorkerProtocol {
    private var task: URLSessionTask?
    
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    func request<T: Codable>(_ route: EndPoint, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                guard let responseData = data else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                do {
                    let result = try JSONDecoder().decode(expecting, from: responseData)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            })
        }catch {
            completion(.failure(error))
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            try self.configureParameters(parameters: route.parameters, request: &request)
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(parameters: [String: Any], request: inout URLRequest) throws {
        do {
            guard let url = request.url else { throw NetworkError.missingURL }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                
                urlComponents.queryItems = [URLQueryItem]()
                
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
            
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw error
        }
    }
    
    public enum NetworkError : String, Error {
        case missingURL = "URL is nil."
    }
}
