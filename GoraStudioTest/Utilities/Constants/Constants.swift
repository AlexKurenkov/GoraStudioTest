//
//  Constants.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

struct Constans {
    
    enum TableCellIdentifiers {
        
        static let userTableViewCellIdentifier  = "userTableViewCellIdentifier"
        static let albumTableViewCellIdentifier = "albumTableViewCellIdentifier"
        static let photoTableViewCellIdentifier = "photoTableViewCellIdentifier"
    }
    
    enum StringConstants {
        
        static let defaultName          = "emptyName"
        static let defaultEmail         = "email@exmpl.com"
        static let defaultCompanyName   = "emptyCompany"
        static let defaultTitle         = "emptyTitle"
    }
    
    enum UIConstants {
        
        static let estimatedUserTableViewCellHeight : CGFloat = 200.0
        static let estimatedAlbumTableViewCellHeight: CGFloat = 60.0
        static let estimatedPhotoTableViewCellHeight: CGFloat = 370.0
    }
    
    enum Images {
        
        static let errorImage: UIImage = UIImage(named: "errorImage")!
    }
}
