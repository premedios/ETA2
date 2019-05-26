//
//  MessageResultNotification.swift
//  ETA
//
//  Created by Pedro Remedios on 24/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit
import NotificationBanner
import MessageUI

struct MessageResultNotification {
    private var result: MessageComposeResult

    var leftView: UIImageView!
    var message: (title: String, subTitle: String)!
    var style: BannerStyle

    init(result: MessageComposeResult) {
        self.result = result
        switch result {
        case MessageComposeResult.sent:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "success"))
            self.message = (NSLocalizedString("Message sent!", comment: ""),
                            NSLocalizedString("You will be receiving an answer shortly", comment: ""))
            self.style = .success
        case MessageComposeResult.cancelled:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "warning"))
            self.message = (NSLocalizedString("Message not sent!", comment: ""),
                            NSLocalizedString("You have cancelled sending", comment: ""))
            self.style = .warning
        case MessageComposeResult.failed:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "error"))
            self.message = (NSLocalizedString("Message not sent!", comment: ""),
                            NSLocalizedString("Please contact your mobile carrier", comment: ""))
            self.style = .danger
        }
    }
}
