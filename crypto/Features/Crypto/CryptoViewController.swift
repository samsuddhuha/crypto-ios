//
//  CryptoViewController.swift
//  crypto
//
//  Created by Samsud Dhuha on 27/07/21.
//

import UIKit
import iOSNFramework

class CryptoViewController: UIViewController {
    
    @IBOutlet weak var tableTopCrypto: UITableView!
    
    let refresh = UIRefreshControl()
    var module: CryptoModule?
    var listTopCrypto = [DataCrypto]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//         Do any additional setup after loading the view.
        tableTopCrypto.isUserInteractionEnabled = false
        tableTopCrypto.delegate = self
        tableTopCrypto.dataSource = self

        module = CryptoModule.init(viewStateDelegate: self, controller: self)

        refresh.tintColor = UIColor.black
        refresh.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        tableTopCrypto.addSubview(refresh)
        refresh.addTarget(self, action: #selector(getTopCrypto), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setView()
    }
    
    @objc func getTopCrypto(){
        module?.topListCrypto()
    }
    
    private func setView(){
        module?.topListCrypto()
    }

}

extension CryptoViewController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        listTopCrypto.removeAll()
        listTopCrypto = data as! [DataCrypto]
        tableTopCrypto.reloadData()
        tableTopCrypto.isUserInteractionEnabled = true
    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onUpdate(data: Any?, tag: String, message: String) {
        
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        showLoadingView(state: isLoading)
        if !isLoading {
            refresh.endRefreshing()
        }
    }
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopCrypto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableTopCrypto.dequeueReusableCell(withIdentifier: "cryptoviewcell") as! CryptoViewCell
        let listData = listTopCrypto[indexPath.row]
        
        cell.labelFullName.text = listData.CoinInfo?.FullName
        cell.labelName.text = listData.CoinInfo?.Name
        cell.labelPrice.text = listData.DISPLAY?.USD?.PRICE
        
        var changePctHour = (listData.DISPLAY?.USD?.CHANGEPCTHOUR)!
//        var changePctDay = (listData.DISPLAY?.USD?.CHANGEPCTDAY)!
        var changePct24Hour = (listData.DISPLAY?.USD?.CHANGEPCT24HOUR)!
        
        var firstChar = (changePct24Hour.characterAt(0))
        if (firstChar != "-") {
            cell.labelChangePtc.backgroundColor = UIColor.systemGreen
            changePct24Hour = "+\(changePct24Hour)"
        }else{
            cell.labelChangePtc.backgroundColor = UIColor.systemRed
        }
        
        firstChar = (changePctHour.characterAt(0))
        if (firstChar != "-") {
            changePctHour = "+\(changePctHour)"
        }
        
        cell.labelChangePtc.text = "\(changePctHour)(\(changePct24Hour))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let temp = listTopCrypto[indexPath.row]
        let nameCrypto = temp.CoinInfo?.Name
//        print("cek : \(nameCrypto)")
        toNews(categories: nameCrypto!)
        
    }
    
    private func toNews(categories: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "News", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "newsviewcontroller") as! NewsViewController
        viewController.categories = categories
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}

