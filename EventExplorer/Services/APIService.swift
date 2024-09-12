//
//  APIServer.swift
//  EventExplorer
//
//  Created by L S on 14/03/2024.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    private let apiKey = "NDE2OTI5MTh8MTcxNjExNTExOS41MTkwMTUz"
    private let baseURL = "https://api.seatgeek.com/2/events"
    
    private var store = Set<AnyCancellable>()
    
    func fetchData(page: Int = 1, perPage: Int = 100, country: String, returned: @escaping ([EventModel]) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            print("Invalid base URL")
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: apiKey),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage)),
            URLQueryItem(name: "venue.country", value: country)
        ]
        
        guard let url = urlComponents.url else {
            print("Invalid URL components")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print("Sending API request to:", url)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { $0.data }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("API request completed successfully")
                case .failure(let error):
                    print("API request failed with error:", error)
                }
            }, receiveValue: { data in
                do {
                    let decodedResponse = try JSONDecoder().decode(SeatGeekResponse.self, from: data)
                    let events = decodedResponse.events
                    returned(events.map { EventModel(from: $0) })
                } catch {
                    print("Error decoding JSON:", error)
                }
            })
            .store(in: &store)
    }
}


