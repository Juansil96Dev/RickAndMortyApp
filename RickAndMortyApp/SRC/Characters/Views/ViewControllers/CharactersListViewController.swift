//
//  DashboardViewController.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import UIKit
class CharactersListViewController: UIViewController {
    
    private var viewModel: CharacterViewModel!
    private var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)

    convenience init(viewModel: CharacterViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = UIColor(red: 0.941, green: 0.949, blue: 0.945, alpha: 1)
        useDefaultBackButton()
        setupCollectionView()
        setupSearchBar()
        bindViewModel()
        viewModel.loadInitialCharacters()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
        ])
    }

    private func setupSearchBar() {
        searchController.searchBar.placeholder = "Buscar personaje"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func bindViewModel() {
        viewModel.didUpdate = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.didFail = { [weak self] error in
            self?.showUnexpectedErrorAlert()
        }
    }
    
    private func showUnexpectedErrorAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Ocurrió un error inesperado",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true, completion: nil)
    }

    // MARK: Scroll infinito
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 1.5 {
            viewModel.loadMoreCharacters()
        }
    }
}

// MARK: - UICollectionView
extension CharactersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filteredCharacters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCell.reuseIdentifier,
            for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        let character = viewModel.filteredCharacters[indexPath.item]
        cell.configure(with: character) {
            self.viewModel.showDetails(character: character)
        }
        return cell
    }
}

extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow + 1)
        let width = (collectionView.frame.width - totalPadding) / itemsPerRow
        return CGSize(width: width, height: width * 1.4)
    }
}

extension CharactersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.filter(by: query)
    }
}
