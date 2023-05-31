//
//  ViewController.swift
//  Deeplink POC
//
//  Created by Ahmad Al Kalouti on 30/05/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DeepLinkManager.shared.notifyDeepLinkChanges.sink { [weak self] status in
            if status {
                self?.handleDeepLinkController()
            }
        }
        .store(in: &subscriptions)
//
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            DeepLinkManager.shared.updateFab(partnerID: "dddddddd")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //handleDeepLinkController()
    }
    
    func handleDeepLinkController() {
        let result =  DeepLinkManager.shared.checkIfThereIsDeeplink()
        if let vc = result.controller,
           let isPresent = result.isPresent {
            if isPresent {
                present(vc, animated: true)
            } else {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }


}

