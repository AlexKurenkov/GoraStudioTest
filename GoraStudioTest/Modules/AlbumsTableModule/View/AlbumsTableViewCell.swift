//
//  AlbumsTableViewCell.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    public func setupAlbumsTableViewCell(fromAlbum album: Album?, index: Int) {
        titleLabel.attributedText = NSMutableAttributedString.getAttributedText(bold: "\(index). ", normal: "\(album?.title ?? Constans.StringConstants.defaultTitle)")
    }
    
}
