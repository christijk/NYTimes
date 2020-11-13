//
//  NewsListTableViewCell.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

	@IBOutlet weak var thumbnailImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var snippetLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		thumbnailImageView.image = UIImage(named: NYImage.placeHolder)
    }
	
	override func prepareForReuse() {
		titleLabel.isHidden = false
		snippetLabel.isHidden = false
		dateLabel.isHidden = false
		thumbnailImageView.image = UIImage(named: NYImage.placeHolder)
	}

	// Method to configure cell using viewmodel
	//
	func configureCell(_ model: NewsListCellViewModelProtocol?) {
		guard let model = model else { return }
		
		titleLabel.text = model.title
		titleLabel.isHidden = (model.title == nil)
		
		snippetLabel.text = model.snippet
		snippetLabel.isHidden = (model.snippet == nil)
		
		dateLabel.text = model.date
		dateLabel.isHidden = (model.date == nil)
	
		model.fetchImage { [weak self] (image) in
			DispatchQueue.main.async {
				self?.thumbnailImageView.image = image
			}
		}
		
		self.layoutIfNeeded()
	}

}
