import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import Photos

class PhotoFilterViewController: UIViewController {
    
    // MARK: - Properties
    
    private var originalImage: UIImage?
    
    // Context is kinda like the "oven" for baking filters.
    private let context = CIContext(options: nil)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filter = CIFilter.colorControls()
        
        print(filter)
        print(filter.attributes)
        
        // Use our storyboard placeholder image to start
        originalImage = imageView.image
        
    }
    
    // MARK: Functions
    
    func filterImage(_ image: UIImage) -> UIImage? {
        
        // UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else { return nil }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        let filter = CIFilter.colorControls()
        filter.inputImage = ciImage
        
        filter.brightness = brightnessSlider.value
        filter.contrast = contrastSlider.value
        filter.saturation = saturationSlider.value
        
        guard let outputCIImage = filter.outputImage else { return nil }
        
        // CIImage -> CGImage -> UIImage
        /// Applies the filter to the image (i.e.: baking the cookies in the oven)
        
        guard let outputCGIImage = context.createCGImage(outputCIImage, from: CGRect(origin: .zero, size: image.size)) else { return nil }
        
        return UIImage(cgImage: outputCGIImage)
    }
    
    private func updateImage() {
        if let originalImage = originalImage {
            imageView.image = filterImage(originalImage)
        } else {
            imageView.image = nil // allows us to clear out the image in the user interface
        }
    }
    
    // MARK: IBActions
    
    @IBAction func choosePhotoButtonPressed(_ sender: Any) {
        // TODO: show the photo picker so we can choose on-device photos
        // UIImagePickerController + Delegate
    }
    
    @IBAction func savePhotoButtonPressed(_ sender: UIButton) {
        // TODO: Save to photo library
    }
    
    
    // MARK: Slider events
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
        updateImage()
    }
    
    @IBAction func contrastChanged(_ sender: Any) {
        updateImage()
    }
    
    @IBAction func saturationChanged(_ sender: Any) {
        updateImage()
    }
}

