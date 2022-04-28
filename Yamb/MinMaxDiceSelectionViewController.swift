//
//  DiceSelectionViewController.swift
//  Yamb
//
//  Created by Martin Peshevski on 6.1.21.
//

import UIKit
import SnapKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, layoutInsets: UIEdgeInsets){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        //self.layoutInsets = layoutInsets
    }
}

class CustomButton: UIButton {
    public let buttonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    

    var viewModel: CustomButtonViewModel

    init(with viewModel: CustomButtonViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)

        addSubview(buttonImage)
        self.snp.makeConstraints {make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        buttonImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonImage.image = UIImage(named: viewModel.buttonImage)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct CustomButtonViewModel {
    let buttonImage: String
}



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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.text = field?.row?.longTitle
        return title
    }()
    lazy var clearButton: UIButton = {
        var button = UIButton()
        button.isHidden = !shouldShowClear
        //button.titleLabel = "Clear"
        return button
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.text = "Done"
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
    
    lazy var button1: CustomButton = {
        var btn = CustomButton(with: CustomButtonViewModel(buttonImage: "dice1"))
        return btn
    }()
    
    lazy var button2 = CustomButton(with: CustomButtonViewModel(buttonImage: "dice2"))
    
    lazy var button3 = CustomButton(with: CustomButtonViewModel(buttonImage: "dice3"))
    
    lazy var button4 = CustomButton(with: CustomButtonViewModel(buttonImage: "dice4"))
    
    lazy var button5 = CustomButton(with: CustomButtonViewModel(buttonImage: "dice5"))
    
    lazy var button6 = CustomButton(with: CustomButtonViewModel(buttonImage: "dice6"))
    
    lazy var stackView1 = UIStackView(arrangedSubviews: [button1,button2,button3], spacing: 1, axis: .horizontal, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    lazy var stackView2 = UIStackView(arrangedSubviews: [button4,button5,button6], spacing: 1, axis: .horizontal, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    lazy var stackView3 = UIStackView(arrangedSubviews: [clearButton, doneButton], spacing: 1, axis: .horizontal, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
    lazy var mainStackView = UIStackView(arrangedSubviews: [titleLabel, currentSelection, selectedCollection, selectTheDiceThatYouRolled, stackView1, stackView2, stackView3], spacing: 1, axis: .vertical, distribution: .fill, alignment: .fill, layoutInsets: .zero)
    
//    {
//        var stackView = UIStackView(arrangedSubviews: [button1,button2,button3])
//        stackView.axis = .horizontal
//        return stackView
//    }()
    
//    lazy var stackView2: UIStackView = {
//        var stackView = UIStackView(arrangedSubviews: [button4,button5,button6])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    lazy var stackView3: UIStackView = {
//        var stackView = UIStackView(arrangedSubviews: [clearButton, doneButton])
//        stackView.axis = .horizontal
//        return stackView
//    }()
    
    
//    
//    lazy var mainStackView: UIStackView = {
//        var stackView = UIStackView(arrangedSubviews: [titleLabel, currentSelection, selectedCollection, selectTheDiceThatYouRolled, stackView1, stackView2, stackView3])
//        stackView.axis = .vertical
//        return stackView
//    }()

    var diceRolls: [DiceRoll] = []
    weak var delegate: DiceSelectionDelegate?
    var field: Field?
    
    var shouldShowClear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
//        view.snp.makeConstraints { make in
//            make.bottom.edges.equalTo(mainStackView.bottomAnchor+20)
//        }
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
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
            present(alert, animated: true, completion: nil)
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
