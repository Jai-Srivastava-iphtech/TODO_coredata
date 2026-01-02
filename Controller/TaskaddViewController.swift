import UIKit

class TaskaddViewController: UIViewController {

    @IBOutlet weak var taskNameField: UITextField!
    var onSave: ((String) -> Void)?

    @IBAction func createTaskTapped(_ sender: UIButton) {
        guard let text = taskNameField.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert("Please enter task name")
            return
        }

        onSave?(text)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    private func showAlert(_ msg: String) {
        let alert = UIAlertController(
            title: "Error",
            message: msg,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

