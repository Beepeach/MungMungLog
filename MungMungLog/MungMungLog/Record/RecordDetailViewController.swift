//
//  RecordItemSelectViewController.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/12/10.
//

import UIKit
import PhotosUI

class RecordDetailViewController: UIViewController {
    // TODO: - ScrollView로 되어있는 화면을 TableView로 바꾸자.
    private enum PhotoCollectionViewIdentifier: String {
        case pickerPresentingButtonCell
        case photoCell
    }
    
    private var historyType: HistoryType?
    private var historyPhotos: [UIImage] = []
    private var itemProviders: [NSItemProvider] = []
    
    // MARK: @IBOutlet
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var historyDateField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet var historyDateInputView: UIView!
    @IBOutlet var historyDateDoneButtonToolbar: UIToolbar!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavTitleAndContentsTitleAsDefault()
        configureHistoryDateFieldAsDefault()
    }
    
    private func configureNavTitleAndContentsTitleAsDefault() {
        contentsTextView.textColor = .lightGray
        self.title = "\(historyType?.rawValue ?? "") 기록"
        titleLabel.text = "오늘의 \(historyType?.rawValue ?? "") 기록"
    }
    
    private func configureHistoryDateFieldAsDefault() {
        historyDateField.inputView = historyDateInputView
        historyDateField.inputAccessoryView = historyDateDoneButtonToolbar
        historyDateField.tintColor = .clear
        historyDateField.textColor = .lightGray
        historyDateField.text = "날짜를 선택해주세요."
    }
    
    // MARK: @IBAction
    @IBAction func presentPicker(_ sender: Any) {
        if #available(iOS 14, *) {
            let pickerConfiguration: PHPickerConfiguration = creatingPHPickerConfiguration()
            let pickerVC: PHPickerViewController = creatingPHPickerVC(configuration: pickerConfiguration)
            
            pickerVC.modalPresentationStyle = .fullScreen
            present(pickerVC, animated: true)
        }
    }
    
    @available(iOS 14, *)
    private func creatingPHPickerConfiguration() -> PHPickerConfiguration {
        var configuration: PHPickerConfiguration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 5
        
        return configuration
    }
    
    @available(iOS 14, *)
    private func creatingPHPickerVC(configuration: PHPickerConfiguration) -> PHPickerViewController {
        let pickerVC: PHPickerViewController = PHPickerViewController(configuration: configuration)
        pickerVC.delegate = self
   
        return pickerVC
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveHistory(_ sender: Any) {
        // API호출
    }
    
    @IBAction func selectHistoryDate(_ sender: Any) {
        guard let historyDatePicker = historyDateInputView.subviews.first as? UIDatePicker else { return }
        
        if #available(iOS 12.0, *) {
            historyDateField.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        } else {
            historyDateField.textColor = .black
        }
    
        historyDateField.text = historyDatePicker.date.FullTimeKoreanDateFormatted
        historyDateField.resignFirstResponder()
    }
    
    // MARK: Interface
    public func setHistoryType(to type: HistoryType) {
        self.historyType = type
    }
}


// MARK: - UICollectionViewDataSource
extension RecordDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : historyPhotos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return dequeuePickerPresentingButtonCell(collectionView, indexPath: indexPath)
        } else {
           return dequeuePhotoCell(collectionView, indexPath: indexPath)
        }
    }
    
    private func dequeuePickerPresentingButtonCell(_ collectionView: UICollectionView , indexPath: IndexPath) -> UICollectionViewCell {
        let addPhotoButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewIdentifier.pickerPresentingButtonCell.rawValue, for: indexPath)
        
        return addPhotoButtonCell
    }
    
    private func dequeuePhotoCell(_ collectionView: UICollectionView , indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewIdentifier.photoCell.rawValue, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        addDeselectPhotoButton(photoCell: photoCell, indexPath: indexPath)
        photoCell.photoImageView.image = historyPhotos[indexPath.row]
        
        return photoCell
    }
    
    private func addDeselectPhotoButton(photoCell: PhotoCollectionViewCell, indexPath: IndexPath) {
        photoCell.deselectPhotoButton.tag = indexPath.item
        photoCell.deselectPhotoButton.addTarget(self, action: #selector(deselectTargetPhoto(sender:)), for: .touchUpInside)
    }
    
    @objc private func deselectTargetPhoto(sender: UIButton) {
        historyPhotos.remove(at: sender.tag)
        photoCollectionView.reloadData()
    }
}


// MARK: - UITextViewDelegate
extension RecordDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            
            if #available(iOS 12.0, *) {
                textView.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
            } else {
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "오늘의 기록을 남겨보세요."
        }
    }
}


// MARK: - UITextFieldDelegate
extension RecordDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case historyDateField:
            return false
        default:
            return true
        }
    }
}


// MARK: PHPickerViewControllerDelegate
// TODO: 5개 이상이라면 photos의 이전것을 없애고 최근것 5개를 유지시켜야한다. 지금은 계속 누르고 계속 추가하면 5개이상 추가가 된다.
@available(iOS 14, *)
extension RecordDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        itemProviders = results.map(\.itemProvider)
        itemProviders.forEach { itemProvider in
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                appendInHistoryPhotos(itemProvider: itemProvider)
            }
        }
        
        // TODO: 왜 처음에는 reload가 잘 안될까??
        dismiss(animated: true) {
            self.photoCollectionView.reloadData()
        }
    }
    
    private func appendInHistoryPhotos(itemProvider: NSItemProvider) {
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage else {
                return
            }
            self.historyPhotos.append(image)
        }
    }
}
