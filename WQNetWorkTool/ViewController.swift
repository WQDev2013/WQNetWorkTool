//
//  ViewController.swift
//  WQNetWorkTool
//
//  Created by chenweiqiang on 2020/5/29.
//  Copyright © 2020 chenweiqiang. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import Moya
class ViewController: UIViewController {
    
    /// 用来主动取消网络请求
    var cancelableRequest: Cancellable?
    
    public let disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testMoya3()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        cancelableRequest?.cancel()
    }
    func testMoya3() {
        cancelableRequest = NetWorkRequest(.channels, completion: { (responseString) -> (Void) in
        if let daliyItems = [Chanel].deserialize(from: responseString, designatedPath: "channels") {
            daliyItems.forEach({ (item) in
                print("模型属性--\(item?.name ?? "模型无name_en")" )
            })
        }
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
    }
    func testMoya2() {
        //获取数据
        WQProvider.rx.request(.channels)
            .subscribe(onSuccess: { response in
                //数据处理
                let str = String(data: response.data, encoding: String.Encoding.utf8)
                print("返回的数据是：", str ?? "")
            },onError: { error in
                print("数据请求失败!错误原因：", error)
            }).disposed(by: disposeBag)
    }
    func testMoya1() {
        //获取数据
        WQProvider.rx.request(.channels)
            .subscribe { event in
                switch event {
                case let .success(response):
                    //数据处理
                    let str = String(data: response.data, encoding: String.Encoding.utf8)
                    print("返回的数据是：", str ?? "")
                case let .error(error):
                    print("数据请求失败!错误原因：", error)
                }
        }.disposed(by: disposeBag)
    }

    func testRxAlamofire1() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        //创建并发起请求
        request(.get, url)
            .data()
            .subscribe(onNext: {
                data in
                //数据处理
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("返回的数据是：", str ?? "")
            }).disposed(by: disposeBag)
    }

    func testRxAlamofire2() {
        //创建URL对象
        let urlString = "https://www.douban.com/jxxxxxxxx/app/radio/channels"
        let url = URL(string:urlString)!

        //创建并发起请求
        request(.get, url)
            .data()
            .subscribe(onNext: {
                data in
                //数据处理
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("返回的数据是：", str ?? "")
            }, onError: { error in
                print("请求失败！错误原因：", error)
            }).disposed(by: disposeBag)
    }


}
