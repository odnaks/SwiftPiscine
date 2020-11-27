//
//  APIController.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

fileprivate let CONSUMER_KEY = "IQKbtAYlXLripLGPWd0HUA"
fileprivate let CONSUMER_SECRET = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"

class APIController {
    weak var delegate: APITwitterDelegate?
    
    var token: String
    
    init(withToken token: String, andDelegate delegate: APITwitterDelegate?) {
        self.delegate = delegate
        self.token = token
    }
    
    func search(by keyword: String) {
        //request
        print("search")
        guard let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(keyword)&count=100") else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        //https://www.xspdf.com/resolution/50536620.html
        
        session.dataTask(with: request as URLRequest){
            (data, response, error) in
                if let data = data {
                    do {
//                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            if let names = json["names"] as? [String] {
//                                   print(names)
//                               }
//                           }
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                            print(json)
                        }
                    } catch {
                        // handle error
                    }
                } else if let error = error {
                   // handle error
                }
            }.resume()
        
        
        var tweets: [Tweet] = [] //answer
        
        delegate?.manageReceived(tweets)
    }
    
    class func getToken(_ completion: @escaping ((String) -> Void)) {
        guard let url = URL(string: "https://api.twitter.com/oauth2/token") else { return }
        let bearer = (("\(CONSUMER_KEY):\(CONSUMER_SECRET)").data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(bearer)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
    
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                //show error
            } else if let data = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                        guard let token = dic["access_token"] as? String else {return}
                        completion(token)
                    }
                } catch (let err) {
                    //show error
                }
            }
        }.resume()
    }
}


// https://documenter.getpostman.com/view/35240/SWE6adN7?version=latest
// https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only
// https://developer.twitter.com/en/docs/authentication/api-reference/token
// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
