//
//  Model.swift
//  SimpleChat
//
//  Created by Aleksey Alyonin on 14.07.2023.
//

import UIKit

enum AuthResponse {
    case success, error, noVerify
}

struct Slide {
    var id: Int
    var text: String
    var img: UIImage
}

struct LogiField {
    var email: String
    var password: String
}

struct ResponceCode {
    var code: Int
}

struct CurrentUser {
    var id: String
    var email: String
}
