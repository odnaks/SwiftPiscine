//
//  APIController.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate: APITwitterDelegate?
    
    var token: String
    
    init(withToken token: String, andDelegate delegate: APITwitterDelegate?) {
        self.delegate = delegate
        self.token = token
    }
    
    private let CONSUMER_KEY = "IQKbtAYlXLripLGPWd0HUA"
    private let CONSUMER_SECRET = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"
    
    
    func search(with text: String) {
        //request
        print("search")
        let urlString = "https://api.twitter.com/1.1/search/tweets.json/q=ecole42"
        let session = URLSession.shared
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
//        request.setValue(CONSUMER_KEY, forHTTPHeaderField: "Authorization")
//        request.setValue(OAUTH_CONSUMER_KEY)
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        
//        print(CONSUMER_SECRET)
        //https://www.xspdf.com/resolution/50536620.html
//        print(CONSUMER_SECRET.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
        
        session.dataTask(with: request as URLRequest){
            (data, response, error) in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    print(data)
//                    do{
//                        let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
//                        print(json)
//                    }catch{
//                        print("Could not serialize")
//                    }
                } else if let error = error {
                    print(error)
                }

            }.resume()
        
        
        var tweets: [Tweet] = [] //answer
        
        delegate?.manageReceived(tweets)
    }
    
    func getToken(/*byConsumerKey consumerKey: String, andConsumerSecret consumerSecret: String*/) {
        print("getToken")
        let encodedConsumerKey = CONSUMER_KEY.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let encodedConsumerSecret = CONSUMER_SECRET.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let bearerToken = "\(encodedConsumerKey):\(encodedConsumerSecret)".data(using: .utf8)?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        guard let url = URL(string: "https://api.twitter.com/oauth2/token") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                //handle error
            } else if let d = data {
                do {
                    if let dic = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        guard let token = dic["access_token"] as? String else {return}
                        // save token self.token = token
                        self.token = token
                        print(token)
                        self.search(with: "")
                        
                    }
                } catch (let err) {
                    //handel error
                }
            }
        }
    }
    
}


// https://documenter.getpostman.com/view/35240/SWE6adN7?version=latest
// https://developer.twitter.com/en/docs/authentication/oauth-2-0/application-only
// https://developer.twitter.com/en/docs/authentication/api-reference/token
// https://developer.twitter.com/en/docs/twitter-api/v1/tweets/search/api-reference/get-search-tweets
