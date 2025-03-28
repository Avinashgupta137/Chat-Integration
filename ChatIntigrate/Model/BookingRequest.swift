//
//  BookingRequest.swift
//  ChatIntigrate
//
//  Created by Sanskar IOS Dev on 27/03/25.
//
import Foundation

struct BookingResponse : Codable {
    let status : Bool?
    let message : String?
    let data : [Datas]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Datas].self, forKey: .data)
    }

}


struct Datas : Codable {
    let id : Int?
    let user_id : Int?
    let name : String?
    let email : String?
    let mobile : String?
    let postal_code : String?
    let description : String?
    let image : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?
    let customer : Customer?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
        case postal_code = "postal_code"
        case description = "description"
        case image = "image"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case customer = "customer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
    }

}


struct Customer : Codable {
    let id : Int?
    let name : String?
    let mobile : String?
    let email : String?
    let token : String?
    let fcm_token : String?
    let status : Int?
    let device_type : String?
    let user_type : String?
    let email_verified_at : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case mobile = "mobile"
        case email = "email"
        case token = "token"
        case fcm_token = "fcm_token"
        case status = "status"
        case device_type = "device_type"
        case user_type = "user_type"
        case email_verified_at = "email_verified_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        device_type = try values.decodeIfPresent(String.self, forKey: .device_type)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
