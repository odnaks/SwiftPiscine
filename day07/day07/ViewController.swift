//
//  ViewController.swift
//  day07
//
//  Created by Dremora Restless on 12/2/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import UIKit
import DarkSkyKit
import RecastAI
import JSQMessagesViewController

class ViewController: JSQMessagesViewController {

    let forecastClient = DarkSkyKit(apiToken: "2b485393cb19279ada9959ed78f14c7a")
    let recastBot: RecastAIClient = RecastAIClient(token: "abc0f6e96953b036f063b6364e0af6c0", language: "en")
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    
    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.center.y = self.view.center.y - 30

//            CGRect
        setupBubbles()
        
//        self.addMessage("0", text: "hello")
        
        self.senderId = UIDevice.current.identifierForVendor?.uuidString
        self.senderDisplayName = UIDevice.current.identifierForVendor?.uuidString
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
            DispatchQueue.main.async {
                self.addMessage("", text: "Hello!\nPlease, enter your city or country.\n\nexample: Moscow")
            }
        }
    
        
//        forecastClient.current(latitude: 55.753215, longitude: 37.622504) { result in
//          switch result {
//          case .success(let data):
//            guard let temp = data.currently?.temperature else { return }
//            print(temp.celsius())
////            print(data.currently?.temperature?.celsius())
////            print(data)
//              // Manage weather data using the Forecast model. Ex:
////              if let current = forecast.currently {
////                let t = current.temperature
////              }
//            case .failure(let error):
//                print("error")
//                print(error)
//              // Manage error case
//          }
//        }
        
    }
    
    fileprivate func setupBubbles() {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleRed())
        incomingBubbleImageView = bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
            addMessage(senderId, text: text)
            startSearch(city: text)
    }
    
    private func getWeather(by lat: Double, and lng: Double) {
        print("get weather by \(lat) and \(lng)")
        forecastClient.current(latitude: lat, longitude: lng) { result in
            switch result {
                case .success(let data):
                    guard let temp = data.currently?.temperature else { return }
                    print("weather data:\n")
                    print(data)
                    self.addMessage("", text: " \(temp.celsius()) celsus")
                    print(temp.celsius())
//            print(data.currently?.temperature?.celsius())
//            print(data)
              // Manage weather data using the Forecast model. Ex:
//              if let current = forecast.currently {
//                let t = current.temperature
//              }
                case .failure(let error):
                    print("error 4")
                    self.sendError(with: .darkSkyServerError)
              // Manage error case
            }
        }
    }
    
    private func startSearch(city: String) {
        print("city: \(city)")
        recastBot.textRequest(city, successHandler: { [weak self] (responce) in
            print("response:\n\n")
            print(responce)
            if let dic = responce.entities {
                if let locations = dic["location"] as? [[String: Any]] {
                    print("locations")
                    for location in locations {
                        if  let lat = location["lat"] as? Double,
                            let lng = location["lng"] as? Double {
                            print("lat = \(lat), lng = \(lng)")
                            self?.getWeather(by: lat, and: lng)
                        }
                    }
                } else {
                    print("error 0")
                    self?.sendError(with: .cityError)
                }
            } else {
                print("error 1")
                self?.sendError(with: .recastServerError)
            }
        }, failureHandle: {_ in
            print("error 2")
            self.sendError(with: .recastServerError)
        })
        
    }
    
    private func sendError(with code: MyError) {
        switch code {
            case .cityError:
                addMessage("", text: "Not correct city. Try another.")
            case .recastServerError:
                addMessage("", text: "RecastBot error.")
            case .darkSkyServerError:
                addMessage("", text: "DarkSky error.")
        }
    }
    
    private func addMessage(_ id: String, text: String) {
        guard let message = JSQMessage(senderId: id, displayName: "", text: text) else { return }
        messages.append(message)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
            
            let data = messages[indexPath.row]
            switch(data.senderId) {
                case self.senderId:
                    return self.outgoingBubbleImageView
                default:
                    return self.incomingBubbleImageView
            }
        }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
            
            return nil
        }
    
}

extension Double {
    func celsius() -> Int {
        return Int(5.0 / 9.0 * (self - 32.0))
    }
}

//https://cocoapods.org/pods/RecastAI
//https://cai.tools.sap/xvluk/day07/settings/tokens

//https://cocoapods.org/pods/SwiftOpenWeatherMapAPI
//https://home.openweathermap.org/api_keys
