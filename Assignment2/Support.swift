import Foundation
import UIKit

enum StoryBoardName:String {
    case Main
}

enum TextFieldType:String {
    case email
    case password
}

protocol StoryboardInitializable {
    static func instantiateViewController(storyboardName:StoryBoardName, identifier:String) -> UIViewController
}
