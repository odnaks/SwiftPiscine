//
//  APITwitterDelegate.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func manageReceived(_ tweets: [Tweet])
    func showAlert(withError error: Error)
}
