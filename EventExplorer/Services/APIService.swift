//
//  APIServer.swift
//  EventExplorer
//
//  Created by L S on 14/03/2024.
//

import Combine
import Foundation

// API Service responsible for handling SeatGeek API requests
class APIService {
    
    // Singleton instance of APIService
    static let shared = APIService()
    
    // Computed property to fetch the API key from Secrets.plist
    private var apiKey: String? {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) {
            return dictionary["API_KEY"] as? String
        }
        return nil
    }
    
    // Base URL for the SeatGeek API
    private let baseURL = "https://api.seatgeek.com/2/events"
    
    // Combine cancellable store to manage subscriptions
    private var store = Set<AnyCancellable>()
    
    // Fetches event data from the SeatGeek API
    // - Parameters:
    //   - page: The page number for pagination (default: 1)
    //   - perPage: The number of results per page (default: 100)
    //   - country: The country filter for events
    //   - returned: Closure that returns an array of EventModel objects
    func fetchData(page: Int = 1, perPage: Int = 100, country: String, returned: @escaping ([EventModel]) -> Void) {
        
        // Build the URL components
        guard var urlComponents = URLComponents(string: baseURL) else {
            print("Invalid base URL")
            return
        }
        
        // Ensure the API key exists
        guard let apiKey = apiKey else {
            print("API key is missing")
            return
        }
        
        // Append query parameters to the URL
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: apiKey),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage)),
            URLQueryItem(name: "venue.country", value: country)
        ]
        
        // Construct the final URL from the components
        guard let url = urlComponents.url else {
            print("Invalid URL components")
            return
        }
        
        // Create a URL request object
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Perform the API request using Combine's dataTaskPublisher
        URLSession.shared.dataTaskPublisher(for: request)
            // Map the response to data
            .tryMap { $0.data }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Successful completion
                    print("API request completed successfully")
                case .failure(let error):
                    // Handle errors during the API request
                    print("API request failed with error:", error)
                }
            }, receiveValue: { data in
                do {
                    // Decode the SeatGeekResponse from the data
                    let decodedResponse = try JSONDecoder().decode(SeatGeekResponse.self, from: data)
                    
                    // Map the decoded events to EventModel and return via the closure
                    let events = decodedResponse.events
                    returned(events.map { EventModel(from: $0) })
                    
                } catch {
                    // Handle JSON decoding errors
                    print("Error decoding JSON:", error)
                }
            })
            // Store the subscription in the cancellable store
            .store(in: &store)
    }
}

