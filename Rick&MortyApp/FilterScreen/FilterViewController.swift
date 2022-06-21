//
//  FilterViewController.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 21.06.2022.
//

import Foundation
import SnapKit
import UIKit

class FilterViewController: UIViewController {
    
    private lazy var mainView: UIView = UIView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var seperatorView: UIView = UIView()
    private lazy var firstFilterButton: UIButton = UIButton()
    private lazy var secondFilterButton: UIButton = UIButton()
    private lazy var firstFilterLabel: UILabel = UILabel()
    private lazy var secondFilterLabel: UILabel = UILabel()
    private lazy var firstFilterImageView: UIImageView = UIImageView()
    private lazy var secondFilterImageView: UIImageView = UIImageView()
    
    let viewModel = MainViewModel.shared
    
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayouts()
        setUI()
    }
    
    private func setLayouts() {
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(UIScreen.main.bounds.width - 52)
            make.height.equalTo(170)
        }
        
        self.mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading).offset(16)
            make.top.equalTo(mainView.snp.top).offset(16)
            make.width.greaterThanOrEqualTo(56)
            make.height.equalTo(28)
        }
        
        self.mainView.addSubview(seperatorView)
        seperatorView.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading)
            make.trailing.equalTo(mainView.snp.trailing)
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        self.mainView.addSubview(firstFilterButton)
        firstFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading)
            make.trailing.equalTo(mainView.snp.trailing)
            make.top.equalTo(seperatorView.snp.bottom)
            make.height.equalTo(56)
        }
        
        self.mainView.addSubview(firstFilterLabel)
        firstFilterLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading).offset(16)
            make.trailing.equalTo(mainView.snp.trailing).offset(-40)
            make.height.equalTo(24)
            make.top.equalTo(seperatorView.snp.bottom).offset(16)
        }
        
        self.mainView.addSubview(firstFilterImageView)
        firstFilterImageView.snp.makeConstraints { make in
            make.leading.equalTo(firstFilterLabel.snp.trailing)
            make.trailing.equalTo(mainView.snp.trailing).offset(-16)
            make.height.equalTo(24)
            make.centerY.equalTo(firstFilterLabel.snp.centerY)
        }
        
        self.mainView.addSubview(secondFilterButton)
        secondFilterButton.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading)
            make.trailing.equalTo(mainView.snp.trailing)
            make.top.equalTo(firstFilterButton.snp.bottom)
            make.height.equalTo(56)
        }
        
        self.mainView.addSubview(secondFilterLabel)
        secondFilterLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainView.snp.leading).offset(16)
            make.trailing.equalTo(mainView.snp.trailing).offset(-40)
            make.height.equalTo(24)
            make.top.equalTo(firstFilterButton.snp.bottom).offset(16)
        }
        
        self.mainView.addSubview(secondFilterImageView)
        secondFilterImageView.snp.makeConstraints { make in
            make.leading.equalTo(secondFilterLabel.snp.trailing)
            make.trailing.equalTo(mainView.snp.trailing).offset(-16)
            make.height.equalTo(24)
            make.centerY.equalTo(secondFilterLabel.snp.centerY)
        }
    }
    
    private func setUI() {
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        mainView.backgroundColor = .white
        mainView.createBorder(cornerRadius: 10)
        
        titleLabel.setLabel(font: .Bold_24, text: "Filter", aligment: .left)
        
        seperatorView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        firstFilterButton.setButton(tag: 1)
        firstFilterButton.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        firstFilterLabel.setLabel(font: .Regular_24, text: "Rick", aligment: .left)

        secondFilterButton.setButton(tag: 2)
        secondFilterButton.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        
        secondFilterLabel.setLabel(font: .Regular_24, text: "Morty", aligment: .left)

        setSelected(Filter: viewModel.characterFilter.value!)
    }
    
    private func setSelected(Filter: Filters) {
        
        switch Filter {
        case .ricks:
            firstFilterImageView.image = UIImage(named: "filterSelectedIcon")
            secondFilterImageView.image = UIImage(named: "filterUnselectedIcon")
        case .mortys:
            firstFilterImageView.image = UIImage(named: "filterUnselectedIcon")
            secondFilterImageView.image = UIImage(named: "filterSelectedIcon")
        case .allCharacters:
            firstFilterImageView.image = UIImage(named: "filterUnselectedIcon")
            secondFilterImageView.image = UIImage(named: "filterUnselectedIcon")
        }
    }
    
    @objc private func filterButtonPressed(sender: UIButton) {
        
        let currentFilter = viewModel.characterFilter.value!
        
        switch currentFilter {
        case .ricks:
            if sender.tag == 1 {
                setSelected(Filter: .allCharacters)
                viewModel.characterFilter.value = .allCharacters
            }else if sender.tag == 2 {
                setSelected(Filter: .mortys)
                viewModel.characterFilter.value = .mortys
            }
        case .mortys:
            if sender.tag == 1 {
                setSelected(Filter: .ricks)
                viewModel.characterFilter.value = .ricks
            }else if sender.tag == 2 {
                setSelected(Filter: .allCharacters)
                viewModel.characterFilter.value = .allCharacters
            }
        case .allCharacters:
            if sender.tag == 1 {
                setSelected(Filter: .ricks)
                viewModel.characterFilter.value = .ricks
            }else if sender.tag == 2 {
                setSelected(Filter: .mortys)
                viewModel.characterFilter.value = .mortys
            }
        }
        self.view.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(closeView), userInfo: nil, repeats: false)
    }
    
    @objc private func closeView() {
        
        timer?.invalidate()
        self.dismiss(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if touch?.view != self.mainView {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
