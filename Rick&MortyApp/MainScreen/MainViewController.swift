//
//  MainViewController.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import UIKit
import CoreMedia

class MainViewController: UIViewController {

    private lazy var tableView: UITableView = UITableView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var filterButton: UIButton = UIButton()

    let viewModel: MainViewModel = MainViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayouts()
        setUI()
        setObservers()
    }

    private func setLayouts(){

        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(28)
            make.width.equalTo(163)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
        }

        self.view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.width.equalTo(23)
            make.height.equalTo(26)
        }

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }

    }

    private func setUI() {

        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.isHidden = true

        titleLabel.setLabel(font: .Bold_24, text: "Rick and Morty", aligment: .center)

        filterButton.setImage(UIImage(named: "FilterIcon"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)

        setTableView()
    }

    @objc private func filterButtonPressed() {

        let filterView = FilterViewController()
        filterView.modalPresentationStyle = .overFullScreen
        self.present(filterView, animated: false)
    }

    func setObservers() {

        viewModel.characterFilter.bind { [weak self] _ in
            self?.viewModel.getData(isNextPage: false)
        }

        viewModel.characterData.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.errorOccured = {
            self.showError()
        }
    }

    func showError() {
        //Pop-Up window for the errors can be implemented
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier,
                                                 for: indexPath) as! MainViewCell
        cell.setCell(charaterName: viewModel.characterData.value[indexPath.row].name ?? "",
                     characterId: viewModel.characterData.value[indexPath.row].id ?? "",
                     characterImageURL: viewModel.characterData.value[indexPath.row].image ?? "",
                     characterLocation: viewModel.characterData.value[indexPath.row].location?["name"] ?? "")
        if indexPath.row == viewModel.getRowCount() - 1 {
            viewModel.getData(isNextPage: true)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func setTableView() {

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .white
        tableView.register(MainViewCell.self,
                           forCellReuseIdentifier: MainViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 50, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 250
    }
}
