//
//  Design.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 24.04.2023.
//

import Foundation
import UIKit
import SVGKit

enum Chillax: String {
    case extralight = "Chillax-Extralight"
    case light = "Chillax-Light"
    case regular = "Chillax-Regular"
    case medium = "Chillax-Medium"
    case semibold = "Chillax-Semibold"
    case bold = "Chillax-Bold"
}

class Design {
    
    static var shared = Design()
    
    // MARK: - Images
    var backgroundImage = UIImage(named: "background_image")!
    
    var notRegisteredImage = SVGKImage(named: "notRegisteredImage").uiImage!
    var internetErrorImage = SVGKImage(named: "internetError").uiImage!
    
    var clockImage = SVGKImage(named: "clock").uiImage!
    
    var coinsImage = SVGKImage(named: "coins").uiImage!
    var coinImage = SVGKImage(named: "coin").uiImage!
    
    var ownSkinsImage = SVGKImage(named: "ownSkins").uiImage!
    var allSkinsImage = SVGKImage(named: "allSkins").uiImage!
    
    var googleLogoImage = SVGKImage(named: "googleLogo").uiImage!
    var appleLogoImage = SVGKImage(named: "appleLogo").uiImage!
    var emailLogoImage = SVGKImage(named: "emailLogo").uiImage!
    
    var ratingImage = SVGKImage(named: "rating").uiImage!
    var cupImage = SVGKImage(named: "cup").uiImage!
    var skinsImage = SVGKImage(named: "skins").uiImage!
    
    var goldMedalImage = SVGKImage(named: "goldMedal").uiImage!
    var silverMedalImage = SVGKImage(named: "silverMedal").uiImage!
    var bronzeMedalImage = SVGKImage(named: "bronzeMedal").uiImage!
    
    
    // MARK: - Colors
    var yellowColor = UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    
    var grayColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 0.5)
            } else {
                return UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 0.5)
            }
        }
    }()
    
    var tabBarUnselectedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 60.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var navigationTitleColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .black
            }
        }
    }()
    
    var textColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Start Button
    var startButtonBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var startButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var startButtonTappedTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    var startButtonBorderTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            } else {
                return UIColor.black.withAlphaComponent(0.8)
            }
        }
    }()
    
    // MARK: - Waiting Room
    
    var waitingRoomClockImageTintColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    var waitingRoomPlayerViewColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 0.5)
            } else {
                return UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 0.5)
            }
        }
    }()
    
    var waitingRoomUsernameColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    
    // MARK: - Game View
    
    var gameUsernameTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    var gameProgressTintColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var keyboardButtonBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var keyboardButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var keyboardButtonTappedTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    var keyboardButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            } else {
                return UIColor.black.withAlphaComponent(0.8)
            }
        }
    }()
    
    var gameQuestionTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    
    // MARK: - Post Game Statistics
    var playerViewBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var playerViewBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1)
            } else {
                return UIColor(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1)
            }
        }
    }()
    
    var playerBalanceAndRatingTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.black
            } else {
                return UIColor.white
            }
        }
    }()
    
    var playerUsernameTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.black
            } else {
                return UIColor.white
            }
        }
    }()
    
    
    
    // MARK: - Error View
    var reloadButtonColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var reloadButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.orange
            } else {
                return UIColor.orange
            }
        }
    }()
    
    var reloadButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: - Skins
    var skinsSelectedCellColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 0.5)
            } else {
                return UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 0.5)
            }
        }
    }()
    
    var skinsCellTintColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var skinsUsernameColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Skin Alert
    var skinsCancelButtonBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 255.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 255.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var skinsCancelButtonTappedBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 231.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 231.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var skinsBuyButtonBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 0.0/255.0, green: 190.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 0.0/255.0, green: 190.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var skinsBuyButtonTappedBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 0.0/255.0, green: 157.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 0.0/255.0, green: 157.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var skinsBuyButtonSelectedBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 190.0/255.0, green: 190.0/255.0, blue: 190.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var skinAlertBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    // MARK: - Settings
    
    // MARK: Report Bug Button
    var settingsReportBugButtonColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var settingsReportBugButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.orange
            } else {
                return UIColor.orange
            }
        }
    }()
    
    var settingsReportBugButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Log Out Button
    var settingsLogOutButtonBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var settingsLogOutButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var settingsLogOutButtonTappedTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    var settingsLogOutButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            } else {
                return UIColor.black.withAlphaComponent(0.8)
            }
        }
    }()
    
    // MARK: Save button
    var settingsSaveTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Username and Email
    var settingsUsernameAndEmailTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    var settingsUsernameTextFieldColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.black.withAlphaComponent(0.8)
            } else {
                return UIColor.white.withAlphaComponent(0.8)
            }
        }
    }()
    
    var settingsEmailTextFieldColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.lightGray.withAlphaComponent(0.8)
            } else {
                return UIColor.lightGray.withAlphaComponent(0.8)
            }
        }
    }()
    
    // MARK: - Sign In
    
    // MARK: Sign In with Google Button
    var signInWithGoogleButtonBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var signInWithGoogleButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var signInWithGoogleButtonTappedTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    var signInWithGoogleButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            } else {
                return UIColor.black.withAlphaComponent(0.8)
            }
        }
    }()
    
    var signInWithAppleLogoColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    var signInWithAppleLogoHighlightedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.black
            } else {
                return UIColor.white
            }
        }
    }()
    
    // MARK: Main Label
    var signInMainLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Reason Title Label
    var signInReasonTitleLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Reason Description Label
    var signInReasonDescriptionLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    
    // MARK: - Profile
    
    // MARK: Sign In Button
    var signInButtonBorderColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var signInButtonTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor.black
            }
        }
    }()
    
    var signInButtonTappedTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }()
    
    var signInButtonTappedColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 0.5)
            } else {
                return UIColor.black.withAlphaComponent(0.8)
            }
        }
    }()
    
    // MARK: User Info View
    var userInfoBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 0.2)
            } else {
                return UIColor.black.withAlphaComponent(0.2)
            }
        }
    }()
    
    var userInfoEloLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            } else {
                return UIColor(red: 251.0/255.0, green: 188.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            }
        }
    }()
    
    var userInfoEloNameLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    var userInfoUsernameLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    // MARK: Statistics View
    var statisticsBackgroundColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.black.withAlphaComponent(0.6)
            } else {
                return UIColor.black.withAlphaComponent(0.6)
            }
        }
    }()
    
    var statLabelTextColor: UIColor = {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return UIColor.white
            } else {
                return UIColor.black
            }
        }
    }()
    
    

    
    // MARK: - Fonts
    func chillax(style: Chillax, size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
