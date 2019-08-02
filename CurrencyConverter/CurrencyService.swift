//
//  File.swift
//  CurrencyConverter
//
//  Created by Arturo Reyes on 8/1/19.
//  Copyright © 2019 Arturo Reyes. All rights reserved.
//

import Foundation

protocol CurrencyServiceDelegate: class {
    func didFetchRates()
    func didFailFetch(with error: Error)
}

class CurrencyService {
    
    private static let apiKey = "c53803884a8cd62521f26cab3ab3ef4b"
    
    private(set) var rates: [Rate] = []
    private(set) var base: Currency
    
    private weak var delegate: CurrencyServiceDelegate?
    
    private static let refreshRatesPeriod: TimeInterval = 3600
    private var idleTimer: Timer?
    
    init(base: Currency, delegate: CurrencyServiceDelegate) {
        self.base = base
        self.delegate = delegate
        self.fetchConversions()
    }
    
    
    func updateBase(with currency: Currency) {
        self.base = currency
        self.fetchConversions()
    }
    
    func fetchConversions() {
        var parameters: [String:String] = ["access_key":CurrencyService.apiKey]
        parameters[FixerConstants.ResponseKeys.base] = self.base.code
        let url: URL = CurrencyService.buildURL(parameters)
        let request = URLRequest(url: url)
        
        CurrencyService.performRequest(request) { [unowned self] result, error in
            
            if let error = error {
                self.delegate?.didFailFetch(with: error)
                return
            }
            
            if let rates = result?[FixerConstants.ResponseKeys.rates] as? [String:Any] {
                self.setRates(rates: rates)
                self.resetRefreshTimer()
                self.delegate?.didFetchRates()
            }
        }
        
    }
    
    private func setRates(rates: [String:Any]) {
        self.rates.removeAll()
        for currency in Currencies.list {
            if let availableRate = rates[currency.code] as? Double {
                let rounded = round(availableRate * 100)/100
                let newRate = Rate(for: currency, rate: rounded)
                self.rates.append(newRate)
            }
        }
    }
    
    private static func performRequest(_ request: URLRequest, completion: @escaping (AnyObject?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "performRequest", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request")
                print("There was an error with request: \(String(describing: error))")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            CurrencyService.parseData(data, completion: completion)
            
        }
        
        task.resume()
    }
    
    
    private static func parseData(_ data: Data, completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        var parsedResult: [String:AnyObject]?
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completion(nil, NSError(domain: "parseDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        print("Parsed Result -> \(parsedResult!)")
        completion(parsedResult as AnyObject, nil)
    }
    
    
    private static func buildURL(_ parameters: [String:String]) -> URL {
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "data.fixer.io"
        components.path = "/api/latest"
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        print("URL -> \(components.url!)")
        
        return components.url!
    }
    
}


extension CurrencyService {
    
    private func setRefreshTimer() {
        self.idleTimer = Timer.scheduledTimer(timeInterval: CurrencyService.refreshRatesPeriod,
                                              target: self,
                                              selector: #selector(self.refreshConversions),
                                              userInfo: nil,
                                              repeats: false
        )
    }
    
    /// Reset the timer because there was user interaction
    private func resetRefreshTimer() {
        if let idleTimer = self.idleTimer {
            idleTimer.invalidate()
            self.idleTimer = nil
        }
        
        self.setRefreshTimer()
    }
    
    @objc private func refreshConversions() {
        self.fetchConversions()
    }
}
