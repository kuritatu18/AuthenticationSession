//
//  ViewController.swift
//  AuthenticationSession
//
//  Created by Tatsunori Kuri on 2019/01/03.
//  Copyright © 2019年 Tatsunori Kuri. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var authenticationSession: AuthenticationSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // generate customzURL link
        let url = URL(string: "http://ux.nu/uS21P")!
        
        authenticationSession = AuthenticationSession.init(url: url, callbackURLScheme: nil, completionHandler: { [weak self] (callBack: URL?, error: Error?) in
            self?.getAuthorizationToken(callBack: callBack, error: error)
        })
        _ = authenticationSession?.start()
    }
    
    func getAuthorizationToken(callBack: URL?, error: Error?) {
        guard error == nil,
            let successURL = callBack else {
                return
        }
        let authToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "token"}).first
        guard let _authToken = authToken else {
            return
        }
        print(String(describing: _authToken.value))
    }
}

