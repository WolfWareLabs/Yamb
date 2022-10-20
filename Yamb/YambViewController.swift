//
//  ViewController.swift
//  Yamb
//
//  Created by Martin Peshevski on 31.12.20.
//

import UIKit
import SwiftUI

class YambViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DiceSelectionDelegate, PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            let vc = YambViewController(settings: YambSettings())
            return vc
        }
    }
    
    lazy var totalScoreLabel: UILabel = {
        var label = UILabel()
        label.text = "Total: \(dataSource.totalScore)"
        return label
    }()
    
    let yambPadding: CGFloat = 10
    
    lazy var yambCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.minimumLineSpacing = 3
        flowLayout.itemSize = CGSize(width: ((UIScreen.main.bounds.width - yambPadding)/CGFloat(columns.count)) - 3, height: 45)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        var yambCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        yambCV.delegate = self
        yambCV.dataSource = self
        
        yambCV.register(YambCell.self, forCellWithReuseIdentifier: "numberCell")
        yambCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return yambCV
    }()
    
    lazy var contentStack: UIStackView = {
       var stackView = UIStackView(arrangedSubviews: [topStack, yambCollectionView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var topStack: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [button, UIView(), totalScoreLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var button: UIButton = {
       var b = UIButton()
        b.setTitle("New Game", for: .normal)
        b.backgroundColor = .systemBlue
        b.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        b.addTarget(self, action: #selector(onNewGame), for: .touchUpInside)
        return b
    }()
    
    lazy var columns: [Column] = {
        let cols: [Column]
        if settings.extraColumns.value {
            cols = [.rowNames, .down, .up, .free, .midOut, .outMid, .announce, .disannounce]
        }
        else {
            cols = [.rowNames, .down, .up, .free, .announce]
        }
        return cols
    }()
    
    lazy var dataSource: YambDataSource = {
        let data = YambDataSource(columns: columns)
        data.loadScores()
        
        return data
    }()
    
    let settings: YambSettings
    
    init(settings: YambSettings) {
        self.settings = settings
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        settings = YambSettings()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(contentStack)
        contentStack.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        yambCollectionView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).inset(yambPadding)
        }
        
        setupNavigationBarItems()
        
        if StorageManager.userEmail == "" {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    func setupNavigationBarItems() {
        lazy var profileButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "person.circle"), for: .normal)
            button.snp.makeConstraints { make in
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
            if StorageManager.userEmail == "" {
                button.isHidden = true
            }
            button.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
            return button
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc func profileButtonClicked() {
        let profileVC = ProfileViewController()
        profileVC.delegate = self
        let nav = UINavigationController(rootViewController: profileVC)
        nav.modalPresentationStyle = .formSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        navigationController?.present(nav, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.fieldsDict[section]?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.fieldsDict.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath) as? YambCell ?? YambCell(frame: .zero)
        if let field = dataSource.fieldsDict[indexPath.section]?[indexPath.item] {
            cell.setup(field: field)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let field = dataSource.fieldFor(indexPath: indexPath) else { return }
        
        switch field.type {
        case .Yamb:
            if !field.isEnabled { return }
            if field.row?.section == .middle || field.row == .full {
                let minMaxVC = MinMaxDiceSelectionViewController()
                minMaxVC.field = field
                minMaxVC.delegate = self
                minMaxVC.shouldShowClear = field == dataSource.lastPlayedField
                present(minMaxVC, animated: true)
            } else {
                let topBottomVC = TopBottomDiceSelectionViewController()
                topBottomVC.field = field
                topBottomVC.delegate = self
                topBottomVC.shouldShowClear = field == dataSource.lastPlayedField
                present(topBottomVC, animated: true)
            }
        case .Result:
            var message = ""
            if indexPath.section == 0 { message = "This shows the sum of the above column.\n\n If the sum is equal to or greater than 60, you will get 30 extra points"}
            else if indexPath.section == 1 { message = "This shows the result of the above column.\n\n It is calculated by subtracting the Min from the Max and multiplying the result by the number of Ones.\n\n If the result is equal to or greater than 60, you will get 30 extra points" }
            else if indexPath.section == 2 { message = "This shows the sum of the above column" }
            
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        case .ColumnHeader:
            let alert = UIAlertController(title: nil, message: field.column.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        case .RowName:
            guard let description = field.row?.description else { return }
            let alert = UIAlertController(title: nil, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    func didSelect(_ diceRolls: [DiceRoll], indexPath: IndexPath?, hasStar: Bool) {
        guard let indexPath = indexPath else { return }
        dataSource.setScore(diceRolls: diceRolls, indexPath: indexPath, hasStar: hasStar)
        yambCollectionView.reloadData()
        totalScoreLabel.text = "Total: \(dataSource.totalScore)"
    }
    
    func didClear(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        dataSource.clear(indexPath: indexPath)
        yambCollectionView.reloadData()
        totalScoreLabel.text = "Total: \(dataSource.totalScore)"
    }
    
    @objc func onNewGame(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to abandon the current game and start a new one?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            
            self.dataSource.resetScores()
            self.yambCollectionView.reloadData()
            self.totalScoreLabel.text = "Total: \(self.dataSource.totalScore)"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func didDismiss() {
        if dataSource.isGameEnded {
            let alert = UIAlertController(title: "GAME OVER", message: "TOTAL SCORE: \(dataSource.totalScore)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "New game", style: .default, handler: { _ in
                self.dataSource.resetScores()
                self.yambCollectionView.reloadData()
                self.totalScoreLabel.text = "Total: \(self.dataSource.totalScore)"
            }))
            present(alert, animated: true)
        }
    }
}

extension YambViewController: LogOutDelegate {
    func userDidLogOut() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
