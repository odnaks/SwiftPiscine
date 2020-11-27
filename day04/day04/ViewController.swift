//
//  ViewController.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    private let OAUTH_CONSUMER_KEY = ""
//    private let OAUTH_TOKEN = ""

    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIController.getToken{ token in
            let api = APIController(withToken: token, andDelegate: self)
            api.search(by: "ecole42")
        }
//        api.search(with: "ecole 42")
        
        
        //api.gettoken
        //api.search(token)
    }
    
    
}

extension ViewController: APITwitterDelegate {
    func manageReceived(_ tweets: [Tweet]) {
        //
    }
    
    func showAlert(withError error: Error) {
        //
    }
    
    
}

//extension ViewController {
//    func getAuthorizationToken() {
//        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        let url = URL(string: "https://api.twitter.com/oauth2/token")
//        var request = URLRequest(url: url!)
//
//        request.httpMethod = "POST"
//        request.setValue("Basic \(BEARER)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let err = error {
////                self.error(withError: err)
//            } else if let d = data {
//                do {
//                    if let dic = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
//                        guard let token = dic["access_token"] as? String else {return}
//                        self.token = token
//                    }
//                } catch (let err) {
////                    self.error(withError: err)
//                }
//            }
//        }.resume()
//    }
//}
