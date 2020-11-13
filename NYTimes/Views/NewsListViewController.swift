//
//  ViewController.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import UIKit

class NewsListViewController: UIViewController {
	private struct Constants {
		static let title = "NYTimes"
	}
	
	@IBOutlet weak var tableView: UITableView!
	
	var viewModel: NewsListViewModelProtocol = NewsListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		configureUI()
		//
		// Bind view controller with viewmodel
		bindViewModel()
	}

}

// MARK:- Private Methods

private extension NewsListViewController {
	func configureUI() {
		self.title = Constants.title
		tableView.estimatedRowHeight = 200.0
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	func bindViewModel() {
		// API success closure binding
		//
		viewModel.onAPISuccess = { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		
		// API failure handling closure binding
		//
		viewModel.onAPIError = { [weak self] error in
			DispatchQueue.main.async {
				self?.tableView.tableFooterView = nil
			}
			print(error.errorDescription)
		}
		
		// Call to get items from API
		//
		viewModel.getItems()
	}
	
	// Method used to push to the news detail page
	// Create a detail view model and pass
	//
	func pushToNewsDeatilsVC(_ vm: NewsListCellViewModelProtocol?) {
		guard let vm = vm else { return }
		let detailsVM = NewsDetailViewModel(news: vm.news)
		let vc = self.storyboard?.instantiateViewController(
			identifier: StoryboardId.newsDetails) as! NewsDetailsViewController
		vc.viewModel = detailsVM
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK:- UITableView Delegate Methods

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(
			NewsListTableViewCell.self, indexPath: indexPath)
		let cellViewModel = viewModel
			.getNewsListCellModel(for: indexPath.row)
		cell.configureCell(cellViewModel)
		cell.layoutIfNeeded()
		return cell
	}
	
	func tableView(_ tableView: UITableView,
				   willDisplay cell: UITableViewCell,
				   forRowAt indexPath: IndexPath) {
		guard viewModel.isNextPagePresent &&
				indexPath.row+1 == viewModel.numberOfRows else {
			return
		}
		viewModel.getItemsForNextPage()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selected = viewModel.getNewsListCellModel(for: indexPath.row)
		pushToNewsDeatilsVC(selected)
	}
}
