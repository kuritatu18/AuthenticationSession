//
//  AuthenticationSessionProtocol.swift
//  AuthenticationSession
//
//  Created by Tatsunori Kuri on 2019/01/03.
//  Copyright © 2019年 Tatsunori Kuri. All rights reserved.
//

import Foundation

import Foundation
import SafariServices
import AuthenticationServices

protocol AuthenticationSessionProtocol {
    
    init(url URL: URL,
         callbackURLScheme: String?,
         completionHandler: @escaping (URL?, Error?) -> Void)
    
    func start() -> Bool
    func cancel()
}

class AuthenticationSession: AuthenticationSessionProtocol {
    
    private let innerAuthenticationSession: AuthenticationSessionProtocol
    
    required init(url URL: URL,
                  callbackURLScheme: String?,
                  completionHandler: @escaping (URL?, Error?) -> Void) {
        
        if #available(iOS 12, *) {
            innerAuthenticationSession = ASWebAuthenticationSession(url: URL, callbackURLScheme: callbackURLScheme, completionHandler: completionHandler)
        } else {
            innerAuthenticationSession = SFAuthenticationSession(url: URL, callbackURLScheme: callbackURLScheme, completionHandler: completionHandler)
        }
    }
    
    func start() -> Bool {
        return innerAuthenticationSession.start()
    }
    
    func cancel() {
        innerAuthenticationSession.cancel()
    }
}

extension SFAuthenticationSession: AuthenticationSessionProtocol {
}

@available(iOS 12.0, *)
extension ASWebAuthenticationSession: AuthenticationSessionProtocol {
}
