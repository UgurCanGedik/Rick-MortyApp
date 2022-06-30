//
//  MainViewCell.swift
//  Rick&MortyApp
//
//  Created by Uğur Can Gedik on 20.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewCell: UITableViewCell {

    static let identifier: String = "MainViewCellIdentifier"

    private lazy var backGroundView: UIView = UIView()
    private lazy var characterNameLabel: UILabel = UILabel()
    private lazy var characterIdLabel: UILabel = UILabel()
    private lazy var characterImageView: UIImageView = UIImageView()
    private lazy var characterLocationLabel: UILabel = UILabel()
    private lazy var characterGenderLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setLayouts()
        setUI()
    }

    func setCell(charaterName: String,
                 characterId: String,
                 characterImageURL: String,
                 characterLocation: String,
                 characterGender: String) {

        characterNameLabel.attributedText = NSMutableAttributedString().createAttributedString(
            String1: "Name: ",
            Font1: .Regular_16,
            Color1: .black,
            String2: charaterName,
            Font2: .Regular_16,
            Color2: .lightGray)
        characterIdLabel.attributedText = NSMutableAttributedString().createAttributedString(
            String1: "#id: ",
            Font1: .Regular_16,
            Color1: .black,
            String2: characterId,
            Font2: .Regular_16,
            Color2: .lightGray)
        characterLocationLabel.attributedText = NSMutableAttributedString().createAttributedString(
            String1: "Location: ",
            Font1: .Regular_16,
            Color1: .black,
            String2: characterLocation,
            Font2: .Regular_16,
            Color2: .lightGray)
        characterGenderLabel.attributedText = NSMutableAttributedString().createAttributedString(
            String1: "Gender: ",
            Font1: .Regular_16,
            Color1: .black,
            String2: characterGender,
            Font2: .Regular_16,
            Color2: .lightGray)
        characterImageView.kf.setImage(with: URL(string: characterImageURL),
                                       placeholder: UIImage(named: "DefaultImage"),
                                       options: nil,
                                       completionHandler: nil)
    }

    private func setUI(){

        self.clipsToBounds = false
        self.selectionStyle = .none

        backGroundView.backgroundColor = .white
        backGroundView.createBorder(cornerRadius: 10)
        backGroundView.createShadow(shadowRadius: 3, shadowOpacity: 0.1)

        characterNameLabel.textAlignment = .left
        characterNameLabel.numberOfLines = 0

        characterLocationLabel.textAlignment = .left
        characterNameLabel.numberOfLines = 0
        
        characterGenderLabel.textAlignment = .left
        characterGenderLabel.numberOfLines = 0

        characterIdLabel.textAlignment = .right

        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        characterImageView.layer.masksToBounds = true
        characterImageView.contentMode = .scaleAspectFill
    }

    private func setLayouts(){

        self.backGroundView.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { make in
            make.top.equalTo(backGroundView.snp.top)
            make.trailing.equalTo(backGroundView.snp.trailing)
            make.leading.equalTo(backGroundView.snp.leading)
            make.height.equalTo((UIScreen.main.bounds.width - 48 ) / 1.9464)
        }

        self.backGroundView.addSubview(characterIdLabel)
        characterIdLabel.snp.makeConstraints { make in
            make.trailing.equalTo(backGroundView.snp.trailing).offset(-17)
            make.top.equalTo(characterImageView.snp.bottom).offset(8)
            make.height.equalTo(19)
            make.width.greaterThanOrEqualTo(40)
        }

        self.backGroundView.addSubview(characterNameLabel)
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(backGroundView.snp.leading).offset(14)
            make.trailing.equalTo(backGroundView.snp.trailing).offset(-14)
            make.top.equalTo(characterImageView.snp.bottom).offset(35)
            make.height.greaterThanOrEqualTo(19)
        }

        self.backGroundView.addSubview(characterLocationLabel)
        characterLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.trailing.equalTo(characterNameLabel.snp.trailing)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(8)
//            make.bottom.equalTo(backGroundView.snp.bottom).offset(-40)
        }
        
        self.backGroundView.addSubview(characterGenderLabel)
        characterGenderLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.trailing.equalTo(characterNameLabel.snp.trailing)
            make.top.equalTo(characterLocationLabel.snp.bottom).offset(8)
            make.bottom.equalTo(backGroundView.snp.bottom).offset(-16)
        }

        self.addSubview(backGroundView)
        backGroundView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        characterNameLabel.text = nil
        characterIdLabel.text = nil
        characterImageView.image = nil
        characterLocationLabel.text = nil
    }
}
