//
//  TopBottomDiceSelectionViewController.swift
//  Yamb
//
//  Created by Martin Peshevski on 15.1.21.
//

import UIKit
import SnapKit

class TopBottomDiceSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.text = field?.row?.longTitle
        title.font = .boldSystemFont(ofSize: 25)
        title.textAlignment = .center
        return title
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TopBottomCollectionCell.self, forCellWithReuseIdentifier: "topBottomCell")
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 60)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(450)
            make.width.equalTo(400)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var clearButton: UIButton = {
        var button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onDone), for: .touchUpInside)
        return button
    }()
    
    lazy var addStarSwitch: UISwitch = {
       var addStarSwitch = UISwitch()
        addStarSwitch.addTarget(self, action: #selector(onAddStarValueChanged), for: .valueChanged)
        return addStarSwitch
    }()
    
    lazy var addStarLabel: UILabel = {
        var label = UILabel()
        label.text = "Add star"
        return label
    }()
    
    lazy var addStarStackView = UIStackView(arrangedSubviews: [addStarLabel, addStarSwitch], spacing: 10, axis: .horizontal, distribution: .fill, alignment: .center, layoutInsets: .zero)
    
    lazy var addStarView: UIView = {
       var view = UIView()
        view.addSubview(addStarStackView)
        addStarStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
        }
        return view
    }()
    
    lazy var clearDoneStackVIew = UIStackView(arrangedSubviews: [clearButton, doneButton], spacing: 20, axis: .horizontal, distribution: .fillEqually, alignment: .center, layoutInsets: .zero)
    
    lazy var toggleButtonStackView = UIStackView(arrangedSubviews: [addStarView, clearDoneStackVIew], spacing: 20, axis: .vertical, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    lazy var titleCVStackView = UIStackView(arrangedSubviews: [titleLabel, collectionView], spacing: 10, axis: .vertical, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    lazy var mainStackView = UIStackView(arrangedSubviews: [titleCVStackView, toggleButtonStackView], spacing: 170, axis: .vertical, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    var field: Field?
    weak var delegate: DiceSelectionDelegate?
    var shouldShowClear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topBottomCell", for: indexPath) as? TopBottomCollectionCell ?? TopBottomCollectionCell()
        if let row = field?.row, let data = row.section.nameAndRolls(row: row)[indexPath.section]?[indexPath.row] {
            cell.setup(data: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let row = field?.row, let data = row.section.nameAndRolls(row: row)[indexPath.section]?[indexPath.row] {
            delegate?.didSelect(data.1, indexPath: field?.indexPath, hasStar: addStarSwitch.isOn)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let row = field?.row else { return 0 }
        return row.section.nameAndRolls(row: row).keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let row = field?.row else { return 0 }
        switch row.section {
        case .top: return 6
        case .bottom: return row.section.nameAndRolls(row: row)[section]?.count ?? 0
        case .middle: return 0
        }
    }
    
    @objc func onDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onAddStarValueChanged(_ sender: UISwitch) {
        field?.hasStar = sender.isSelected
    }
    
    @objc func onCancel(_ sender: Any) {
        delegate?.didClear(indexPath: field?.indexPath)
        dismiss(animated: true) {
            self.delegate?.didDismiss()
        }
    }
}

class TopBottomCollectionCell: UICollectionViewCell {
    lazy var titleLabel = UILabel()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 3
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(UIView())
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        layer.borderColor = UIColor.label.cgColor
        layer.cornerRadius = 5
        layer.borderWidth = 1
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setup(data: (title: String, diceRolls: [DiceRoll])) {
        titleLabel.text = data.title
        for view in stackView.arrangedSubviews where view is UIImageView {
            view.removeFromSuperview()
        }
        for diceRoll in data.diceRolls {
            let imageView = UIImageView(image: diceRoll.image)
            imageView.snp.makeConstraints { make in make.width.height.equalTo(30) }
            stackView.addArrangedSubview(imageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
