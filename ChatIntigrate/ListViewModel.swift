//
//  ListViewModel.swift
//  Project
//
//  Created by Gunjan on 03/01/25.
//
import Foundation


class ListViewModel {
    
    var bookings: [Datas] = []
    var onDataUpdated: (() -> Void)?
    
    func fetchChatStore() {
        ApiClient.shared.callHttpMethod(
            apiendpoint: Constant.bookingRequest,
            method: .get,
            param: [:],
            model: BookingResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let response):
                if let data = response.data {
                    self?.bookings = data
                    self?.onDataUpdated?() 
                } else {
                    print("No data received")
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
    
}
