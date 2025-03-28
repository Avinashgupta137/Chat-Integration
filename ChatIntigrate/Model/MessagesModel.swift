//
//  MessagesModel.swift
//  Project
//
//  Created by Gunjan on 03/01/25.
//
import Foundation

struct MessagesResponse: Codable {
    let status: Bool
    let message: String
    let data: [Message]?
}

struct Message: Codable {
    let id: Int
    let booking_id: Int
    let sender_id: Int
    let receiver_id: Int
    let type: String
    let message: String
    let deleted_by: String?
    let created_at: String
    let updated_at: String
    let created_at_human: String
    let updated_at_human: String
}


struct SendMessage: Codable {
    let bookingId: String
    let senderId: Int
    let receiverId: Int
    let type: String
    let message: String
    let updatedAt: String
    let createdAt: String
    let id: Int
    let createdAtHuman: String
    let updatedAtHuman: String

    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case type
        case message
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case createdAtHuman = "created_at_human"
        case updatedAtHuman = "updated_at_human"
    }
}

struct SendMessageResponse: Codable {
    let status: Bool
    let message: String
    let data: [SendMessage]
}

// Example function for decoding a response
func decodeMessagesResponse(from data: Data) -> MessagesResponse? {
    let decoder = JSONDecoder()
    do {
        let response = try decoder.decode(MessagesResponse.self, from: data)
        return response
    } catch {
        print("Error decoding response: \(error.localizedDescription)")
        return nil
    }
}

func decodeSendMessageResponse(from data: Data) -> SendMessageResponse? {
    let decoder = JSONDecoder()
    do {
        let response = try decoder.decode(SendMessageResponse.self, from: data)
        return response
    } catch {
        print("Error decoding response: \(error.localizedDescription)")
        return nil
    }
}
extension SendMessage {
    init(from message : Message) {
        self.bookingId = String(message.booking_id)
        self.senderId = message.sender_id
        self.receiverId = message.receiver_id
        self.type = message.type
        self.message = message.message
        self.updatedAt = message.updated_at
        self.createdAt = message.created_at
        self.id = message.id
        self.createdAtHuman = message.created_at_human
        self.updatedAtHuman = message.updated_at_human
        
    }
}
