//
//  MyPageViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/29.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let infoView: UIView = {
       
        let view = UIView()
    
        return view
    }()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()

        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 0.3
        imageView.layer.cornerRadius = 38
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
    
        return label
    }()
    
    let grayBar: UIView = {
        let view = UIView()

        view.backgroundColor = UIColor.customColor(.lightGray)
        
        return view
    }()

    lazy var changeButton: UIButton = {

        var config = UIButton.Configuration.plain()
        
        var titleArr = AttributedString.init("수정하기")
        titleArr.font = .systemFont(ofSize: 13)
        config.attributedTitle = titleArr
        
        let btn = UIButton(configuration: config)
        btn.tintColor = UIColor.customColor(.lightGray)
        btn.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    let saveListButton: UIButton = {
        
        let button = UIButton()
        button.listButtonSetting("bookmark.fill", "저장목록")
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return button
    }()
    
    let alarmListButton: UIButton = {
        
        let button = UIButton()
        button.listButtonSetting("bell.fill", "알림목록")
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    var myPageViewModel = MyPageViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        fetchUserInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
            DispatchQueue.main.async {
                self.userImage.image = self.myPageViewModel.userImage
                self.userName.text = self.myPageViewModel.userName
        }
    }
    
    func configureUI() {

        view.addSubview(scrollView)

        scrollView.addSubview(infoView)
        
        [
            tableView,
            userImage,
            userName,
            grayBar,
            changeButton,
            saveListButton,
            alarmListButton
        ]
            .forEach { infoView.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.identifier)
        tableView.register(MyPageSectionView.self, forHeaderFooterViewReuseIdentifier: MyPageSectionView.identifier)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(800)
        }

        infoView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(850)
            $0.width.equalTo(scrollView)
        }

        userImage.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(36)
            $0.centerX.equalTo(scrollView)
            $0.width.height.equalTo(78)
        }

        userName.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(24)
            $0.centerX.equalTo(infoView)
        }

        grayBar.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(70)
            $0.trailing.equalToSuperview().offset(-70)
            $0.height.equalTo(0.5)
        }

        changeButton.snp.makeConstraints {
            $0.top.equalTo(grayBar.snp.bottom).offset(4)
            $0.centerX.equalTo(infoView)
        }
        
        saveListButton.snp.makeConstraints {
            $0.top.equalTo(changeButton.snp.bottom).offset(16)
            $0.leading.equalTo(view.snp.centerX).offset(-160)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        alarmListButton.snp.makeConstraints {
            $0.top.equalTo(changeButton.snp.bottom).offset(16)
            $0.leading.equalTo(saveListButton.snp.trailing)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(saveListButton.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("나의 레터")
    }
    
    @objc func changeBtnClicked(_ sender: UIGestureRecognizer) {
        print("changeBtnClicked() - called")
        let view = ChangeViewController()
        
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return myPageViewModel.numOfSection
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        guard let headerView = view as? MyPageSectionView else { return }
        
        headerView.updateUI(myPageViewModel.titleOfSection(at: section))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageSectionView.identifier)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageViewModel.numOfCell(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCell.identifier, for: indexPath) as? MyPageCell else { return UITableViewCell() }
        
        let text = myPageViewModel.type[indexPath.section].cell
        cell.updateUI(at: text[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = myPageViewModel.viewOfSection(indexPath.section, indexPath.row)
        
        self.navigationController?.pushViewController(view, animated: true)
        
    }
}
