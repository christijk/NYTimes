//
//  NewsDetailsViewController.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import UIKit

class NewsDetailsViewController: UIViewController {
	private struct Constants {
		static let title = "NYTimes"
	}
	
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var snippetlabel: UILabel!
	@IBOutlet weak var byLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!
	
	var viewModel: NewsDetailViewModelProtocol?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		configureUI()
    }

}

// MARK:- Private Methods

private extension NewsDetailsViewController {
	func configureUI() {
		self.title = Constants.title
		categoryLabel.text = viewModel?.category
		titleLabel.text = viewModel?.title
		snippetlabel.text = viewModel?.snippet
		byLabel.text = viewModel?.byLine
		dateLabel.text = viewModel?.date
		contentLabel.text = viewModel?.content
		
		viewModel?.fetchImage(completion: { [weak self] (image) in
			DispatchQueue.main.async {
				self?.imageView.image = image
			}
		})
	}
}
