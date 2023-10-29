
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    //画像保存＆読み出しを行うクラス内
    
    func store(image: UIImage, forKey key: String) {
        if let pngRepresentation = image.pngData() {
            
            if let filePath = filePath(forKey: key) {
                do  {
                    try pngRepresentation.write(to: filePath, options: .atomic)
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func retrieveImage(forKey key: String) -> UIImage? {
        if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path), let image = UIImage(data: fileData) {
            return image
        }
        return nil
    }
    
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
}
