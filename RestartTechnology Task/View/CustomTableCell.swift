//
//  CustomTableCell.swift
//  RestartTechnology Task
//
//  Created by Mohamed on 1/20/20.
//  Copyright © 2020 Mohamed74. All rights reserved.
//

import UIKit



class CustomTableCell: UITableViewCell {

    
    //MARK:- IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    
    var APIData : GetMyData?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
          // setup collectionView
          collectionView.delegate = self
          collectionView.dataSource = self
          retrieveData()
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
        
    }

}




//MARK:- CollectionView DataSource and Delegate

extension CustomTableCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        return APIData?.data?.hot_spots?.count ?? 0
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
    
        do{
            
        for index in (self.APIData?.data?.hot_spots![indexPath.row].photos)!{
            
            
            DispatchQueue.main.async {
                
                let imageURL = URL(string: index)
                
                let imageData = try! Data(contentsOf: imageURL!)
                cell.imageView.image = UIImage(data: imageData)
                
            }
            
            
        }
        
            
    }
        cell.titleLabel.text = APIData?.data?.hot_spots?[indexPath.row].name ?? ""
        cell.descriptionLabel.text = APIData?.data?.hot_spots?[indexPath.row].short_description ?? ""
   
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width / 2) - 20, height: collectionView.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
    //MARK:- Retrieving Data

    func retrieveData(){


        guard let url = URL(string: "http://bellman-bd.restart-technology.com/api/home") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode != 200) {
                    //DIE AND SHOW ERROR MESSAGE
                    
                    print("there is an error")
                    return
                }
                
                if let data = data{
                    
                    do{
                        
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(GetMyData.self, from: data)
                        self.APIData = decoded
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                        
                    }catch {
                        
                        print(error.localizedDescription)
                    }
                    
                }
                
                
            }
        }.resume()
        
        
        
    }

}
