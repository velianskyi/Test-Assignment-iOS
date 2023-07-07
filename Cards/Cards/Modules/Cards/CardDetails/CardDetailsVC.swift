//
//  CardDetailsVC.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

final class CardDetailsVC: BaseVC, StoryboardInstatiatable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var cardNameLabel: UILabel!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    @IBOutlet private weak var cardTypeImageView: UIImageView!
    
    // MARK: - Static Properties
    
    static var storyboardName: StoryboardName = .cards
    
    // MARK: - Private Properties
    
    private var viewModel: CardDetailsViewModelProtocol?
    
    // MARK: - Initializers
    
    static func instantiate(_ viewModel: CardDetailsViewModelProtocol) -> CardDetailsVC {
        let vc = CardDetailsVC.instantiateVC()
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
private extension CardDetailsVC {
    func setupUI() {
        setupNavigationBar()
        setupViews()
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
                    self.setupViews()
                    
                case .errors(let errors):
                    self.handleErrors(errors: errors)
                    
                case .view: break
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                                                            action: #selector(reloadTapped))
    }
    
    func setupViews() {
        cardNameLabel.text = viewModel?.cardName
        cardNumberLabel.text = viewModel?.cardNumber
        cardTypeImageView.image = viewModel?.cardType.image
        cardView.backgroundColor = viewModel?.cardType.color
    }
    
    @objc
    func reloadTapped() {
        viewModel?.reloadTapped()
    }
}
