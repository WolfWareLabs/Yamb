//
//  DiceSelectionViewController.swift
//  Yamb
//
//  Created by Martin Peshevski on 6.1.21.
//

import UIKit
import SnapKit

protocol DiceSelectionDelegate: AnyObject {
    func didSelect(_ diceRolls: [DiceRoll], indexPath: IndexPath?, hasStar: Bool)
    func didClear(indexPath: IndexPath?)
    func didDismiss()
}

class MinMaxDiceSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    lazy var selectedCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40)/3 - 10, height: (UIScreen.main.bounds.width - 40)/3 - 10)

        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DiceCell.self, forCellWithReuseIdentifier: "selectionCell")
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(400)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.text = field?.row?.longTitle
        return title
    }()
    lazy var clearButton: ClearDoneButton = {
        var button = ClearDoneButton()
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(onClear), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: ClearDoneButton = {
        var button = ClearDoneButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(onDone), for: .touchUpInside)
        return button
    }()
    
    lazy var currentSelection: UILabel = {
        var label = UILabel()
        label.text = "Current Selection"
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var selectTheDiceThatYouRolled: UILabel = {
        var label = UILabel()
        label.text = "Select the dice that you rolled"
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var button1: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice1"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()

    lazy var button2: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice2"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 2
        return btn
    }()

    lazy var button3: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice3"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 3
        return btn
    }()

    lazy var button4: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice4"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 4
        return btn
    }()

    lazy var button5: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice5"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 5
        return btn
    }()

    lazy var button6: CustomDiceButton = {
        var btn = CustomDiceButton(with: CustomButtonViewModel(buttonImage: "dice6"))
        btn.addTarget(self, action: #selector(onSelect), for: .touchUpInside)
        btn.tag = 6
        return btn
    }()
    
    lazy var firstRowStackView = UIStackView(arrangedSubviews: [button1,button2,button3], spacing: 10, axis: .horizontal, distribution: .fill, alignment: .center)
    
    lazy var secondRowStackView = UIStackView(arrangedSubviews: [button4,button5,button6], spacing: 10, axis: .horizontal, distribution: .fill, alignment: .top)
    
    lazy var clearDoneStackView = UIStackView(arrangedSubviews: [clearButton, doneButton], spacing: 20, axis: .horizontal, distribution: .fillEqually, alignment: .center)
    
    lazy var mainStackView = UIStackView(arrangedSubviews: [UIView(), titleLabel, currentSelection, selectedCollection, selectTheDiceThatYouRolled,  firstRowStackView, secondRowStackView, clearDoneStackView, UIView()], spacing: 20, axis: .vertical, distribution: .fill, alignment: .center)
    

    var diceRolls: [DiceRoll] = []
    weak var delegate: DiceSelectionDelegate?
    var field: Field?
    
    var shouldShowClear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        view.backgroundColor = .white
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diceRolls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedCollection.dequeueReusableCell(withReuseIdentifier: "selectionCell", for: indexPath) as? DiceCell ?? DiceCell(frame: .zero)
        cell.setup(diceRoll: diceRolls[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        diceRolls.remove(at: indexPath.item)
        selectedCollection.reloadData()
    }
    
    @objc func onSelect(_ sender: UIButton) {
        guard let diceRoll = DiceRoll(rawValue: sender.tag), diceRolls.count < 6 else { return }
        diceRolls.append(diceRoll)
        selectedCollection.reloadData()
    }
    
    @objc func onDone(_ sender: Any) {
        if field?.row?.fiveDiceRequired == true && diceRolls.count < 5 {
            let alert = UIAlertController(title: nil, message: "You must select at least five dice", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        delegate?.didSelect(diceRolls, indexPath: field?.indexPath, hasStar: false)
        dismiss(animated: true) {
            self.delegate?.didDismiss()
        }
    }
    
    @objc func onClear(_ sender: Any) {
        delegate?.didClear(indexPath: field?.indexPath)
        dismiss(animated: true) {
            self.delegate?.didDismiss()
        }
    }
}

class DiceCell: UICollectionViewCell {
    lazy var image = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        image.snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(diceRoll: DiceRoll) {
        image.image = diceRoll.image
    }
}
