//
//  CardsListVC.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

final class CardsListVC: BaseVC, StoryboardInstatiatable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Static Properties
    
    static var storyboardName: StoryboardName = .cards
    
    // MARK: - Private Properties
    
    private var viewModel: CardsListViewModelProtocol?
    
    // MARK: - Initializers
    
    static func instantiate(_ viewModel: CardsListViewModelProtocol) -> CardsListVC {
        let vc = CardsListVC.instantiateVC()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        setupRendering()
    }
}

// MARK: - Private Methods
private extension CardsListVC {
    func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupBinding() {
        /// Binding
    }
    
    func setupRendering() {
        viewModel?.state
            .sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .loading: break
                    
                case .loaded:
                    self.tableView.reloadData()
                    
                case .errors(let errors):
                    self.handleErrors(errors: errors)
                    
                case .view: break
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(addCardTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self,
                                                           action: #selector(trashCardSTapped))
    }
    
    func setupTableView() {
        tableView.register(CardsTVC.self)
    }
    
    @objc
    func addCardTapped() {
        viewModel?.addCardTapped()
    }
    
    @objc
    func trashCardSTapped() {
        viewModel?.trashCardsTapped()
    }
}

// MARK: - UITableViewDataSource
extension CardsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardsTVC = tableView.dequeueReusableCell()
        
        guard let model = viewModel?[modelFor: indexPath.row] else { return cell }
        
        cell.setup(with: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CardsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.openCardDetail(index: indexPath.row)
    }
}
