import Foundation

typealias QueryCompletionHandler = (_ result : FetchResult) -> Void
typealias FetchResult = Result<CanadaInfo, APIErrors>

class NetworkDataLoader {
    let baseUrlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var canadaInfo: CanadaInfo?
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    func loadResult(completion: @escaping QueryCompletionHandler) {
        
        let request = baseUrlString.urlRequest()
        
        dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                completion(.failure(.requestFailed(error: error as NSError)))
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.parseData(String(data:data,
                                      encoding:.isoLatin1)!.data(using: .utf8)!){ result in
                    switch result {
                    case let .success(canadaInfo): completion(.success(canadaInfo))
                    case let .failure(error) : completion(.failure(error))
                    }
                }
            }else{
                if (response as? HTTPURLResponse) != nil{
                    completion(.failure(.responseUnsuccessful))
                }
            }
        }
        dataTask?.resume()
    }

    private func parseData(_ data: Data, completion: QueryCompletionHandler) {
        do {
            var canadaInfo = try decoder.decode(CanadaInfo.self, from: data)
            let filteredElements = canadaInfo.rows.filter{ $0.title != nil }
            canadaInfo.rows = filteredElements
            self.canadaInfo = canadaInfo
            completion(.success(canadaInfo))
        } catch _ as NSError {
            completion(.failure(.jsonParsingFailure))
            return
        }
    }
}
