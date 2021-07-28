//
//  NewsViewController.swift
//  crypto
//
//  Created by Samsud Dhuha on 28/07/21.
//

import UIKit
import iOSNFramework

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableNews: UITableView!
    
    var module: NewsModule?
    var categories: String?
    var listNews = [DataNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableNews.isUserInteractionEnabled = false
        tableNews.delegate = self
        tableNews.dataSource = self
        tableNews.rowHeight = UITableView.automaticDimension
        
        module = NewsModule.init(viewStateDelegate: self, controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setView()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setView(){
        module?.news(categories: categories!)
//        print(categories!)
    }

}

extension NewsViewController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        listNews.removeAll()
        listNews = data as! [DataNews]
        tableNews.reloadData()
        tableNews.isUserInteractionEnabled = true
    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onUpdate(data: Any?, tag: String, message: String) {
        
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        showLoadingView(state: isLoading)
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsviewcell") as! NewsViewCell
        let listData = listNews[indexPath.row]
        
        cell.labelTitle.text = listData.title
        cell.labelBody.text = listData.body
        cell.labelJournalist.text = listData.source_info?.name
        
        return cell
    }
}
