//
//  Constant.swift
//  Binko Movi
//
//  Created by Warln on 20/08/22.


import UIKit

class ApiRequest {
    static let shared = ApiRequest()
    
    enum BuildType {
        case dev
        case pro
    }
    
    struct Url {
        static var buildType: BuildType = .pro
        
        static var serverURL: String {
            switch buildType {
            case .dev:
                return "https://mt.localserverpro.com/api"
            case .pro:
                return "https://mt.localserverpro.com/api"
            }
        }
    }
}

struct Constant {

    static let BASEURL                     = ApiRequest.Url.serverURL

    static let authFcmUpdate                = "/auth/fcm-update"
    static let chatStore                    = "/chat/store"
    static let bookingRequest              = "/booking/request/list?page=\(1)&limit=\(10)"


}
//https://mt.localserverpro.com/api/booking/request/list?page=1&limit=10
//https://mt.localserverpro.com/api/booking/request/list?page=1&limit=10
//https://mt.localserverpro.com/api/booking/request/list?page=1&limit=10
