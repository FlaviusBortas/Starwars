//
//  CharactersTableViewController.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }


}
