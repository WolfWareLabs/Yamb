//
//  YambCell.swift
//  Yamb
//
//  Created by Martin Peshevski on 5.1.21.
//

import UIKit
import SnapKit

class YambCell: UICollectionViewCell {
    lazy var textLabel: GlowingLabel = {
        let label = GlowingLabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.glowColor = UIColor.systemBlue.cgColor.copy(alpha: 0.4)
        label.glowRadius = 3.5
        return label
    }()
    
    lazy var infoImage: UIImageView = {
        let l = UIImageView(image: UIImage(named: "info")?.withTintColor(.black, renderingMode: .alwaysTemplate))
        l.tintColor = .black
        l.snp.makeConstraints { make in make.width.height.equalTo(13) }
        l.isHidden = true
        
        return l
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backView = UIView()
        backView.backgroundColor = .red
        backView.frame = textLabel.bounds
        
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        view.frame = backView.bounds
        backView.addSubview(view)
        
        contentView.addSubview(backView)
        
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in make.center.equalToSuperview() }
        
        contentView.addSubview(infoImage)
        infoImage.snp.makeConstraints { make in make.top.right.equalToSuperview().inset(3) }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(field: Field) {
        switch field.type {
        case .Yamb:
            if let score = field.score {
                textLabel.text = "\(score)" + (field.hasStar ? "*" : "")
            } else {
                textLabel.text = ""
            }

            backgroundColor = field.isEnabled ? .systemGray5 : .systemBackground
            layer.cornerRadius = 5
            layer.borderWidth = 1
            layer.borderColor = UIColor.label.cgColor
            infoImage.isHidden = true
        case .Result:
            backgroundColor = .systemBackground
            textLabel.text = "\(field.score ?? 0)"
            layer.borderWidth = 0
            infoImage.isHidden = true
        case .ColumnHeader:
            backgroundColor = .systemBackground
            textLabel.text = field.column.headerTitle
            layer.borderWidth = 0
            infoImage.isHidden = true
        case .RowName:
            backgroundColor = .systemBackground
            textLabel.text = field.row?.title
            layer.borderWidth = 0
            infoImage.isHidden = true
        }
    }
}
