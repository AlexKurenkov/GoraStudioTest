//
//  UserTableViewCell.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!

    // MARK: - Public methods
    public func setupUserTableViewCell(fromUser user: User?) {
        nameLabel.attributedText = NSMutableAttributedString.getAttributedText(bold: "Name: ", normal: "\(user?.name ?? Constans.StringConstants.defaultName)")
        userNameLabel.attributedText = NSMutableAttributedString.getAttributedText(bold: "User Name: ", normal: "\(user?.username ?? Constans.StringConstants.defaultName)")
        emailLabel.attributedText = NSMutableAttributedString.getAttributedText(bold: "e-mail: ", normal: "\(user?.email ?? Constans.StringConstants.defaultEmail)")
        companyNameLabel.attributedText = NSMutableAttributedString.getAttributedText(bold: "Company: ", normal: "\(user?.company?.name ?? Constans.StringConstants.defaultCompanyName)")
    }
}
