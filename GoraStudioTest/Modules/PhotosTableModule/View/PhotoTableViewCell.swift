//
//  PhotoTableViewCell.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var baseCellView: UIView! {
        didSet {
            baseCellView.backgroundColor = UIColor.white
            baseCellView.layer.cornerRadius = 5
            baseCellView.layer.shadowColor = UIColor.black.cgColor
            baseCellView.layer.shadowOpacity = 1
            baseCellView.layer.shadowOffset = .zero
            baseCellView.layer.shadowRadius = 2
            baseCellView.layer.shouldRasterize = true
            baseCellView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    // MARK: - Private Properties
    private let networkService = ApiNetworkDataFetcher()
    private var imageUrl: String? {
        didSet {
            photoImageView.image = nil
            updateUI()
        }
    }

    // MARK: - Public methods
    public func setupPhotoCell(fromPhoto photo: Photo?) {
        imageUrl = photo?.url
        titleLabel.text = photo?.title
    }

    // MARK: - Private Methods
    private func updateUI() {
        guard let url = imageUrl else { return }
        indicator.startAnimating()

        networkService.fetchImage(fromUrl: url) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.indicator.stopAnimating()
                self?.photoImageView.image = image
            case .failure(let error):
                self?.photoImageView.image = Constans.Images.errorImage
                print (error.localizedDescription)
            }
        }
    }
}
