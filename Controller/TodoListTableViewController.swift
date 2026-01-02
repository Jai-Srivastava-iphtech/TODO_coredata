import UIKit

class TodoListTableViewController: UITableViewController {

    // MARK: - Properties
    private var tasks: [TaskEntity] = []
    private let emptyStateView = UIView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "To-Do List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        if let url = (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer
            .persistentStoreCoordinator
            .persistentStores
            .first?
            .url {

            print("Core Data DB Path:", url)
        }

        setupEmptyState()
        loadTasks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTasks()
    }

    // MARK: - Load Tasks
    private func loadTasks() {
        tasks = CoreDataManager.shared.fetchTasks()
        tableView.reloadData()
        updateEmptyState()
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none

        // Remove reused delete buttons
        cell.contentView.subviews
            .filter { $0.tag == 999 }
            .forEach { $0.removeFromSuperview() }

        // Trash Button
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(
            UIImage(systemName: "trash"),
            for: .normal
        )
        deleteButton.tintColor = .red
        deleteButton.tag = 999
        deleteButton.accessibilityIdentifier = "\(indexPath.row)"
        deleteButton.addTarget(
            self,
            action: #selector(deleteTaskTapped(_:)),
            for: .touchUpInside
        )
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(
                equalTo: cell.contentView.trailingAnchor,
                constant: -16
            ),
            deleteButton.centerYAnchor.constraint(
                equalTo: cell.contentView.centerYAnchor
            ),
            deleteButton.widthAnchor.constraint(equalToConstant: 28),
            deleteButton.heightAnchor.constraint(equalToConstant: 28)
        ])

        return cell
    }

    // MARK: - Delete Button
    @objc private func deleteTaskTapped(_ sender: UIButton) {
        guard
            let indexString = sender.accessibilityIdentifier,
            let index = Int(indexString)
        else { return }

        let task = tasks[index]

        let alert = UIAlertController(
            title: "Delete Task?",
            message: task.title,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            CoreDataManager.shared.deleteTask(task)
            self.loadTasks()
        })

        present(alert, animated: true)
    }

    // MARK: - Swipe Delete
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration {

        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            _, _, _ in
            CoreDataManager.shared.deleteTask(self.tasks[indexPath.row])
            self.loadTasks()
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }

    // MARK: - Edit Task
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        let task = tasks[indexPath.row]

        let alert = UIAlertController(
            title: "Edit Task",
            message: nil,
            preferredStyle: .alert
        )

        alert.addTextField { $0.text = task.title }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text,
               !text.isEmpty {
                CoreDataManager.shared.updateTask(task, newTitle: text)
                self.loadTasks()
            }
        })

        present(alert, animated: true)
    }
    // MARK: - Empty State UI
    private func setupEmptyState() {

        emptyStateView.frame = view.bounds

        let imageView = UIImageView(image: UIImage(named: "to-do-list"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        let titleLabel = UILabel()
        titleLabel.text = "Time to Get Organized!"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Tap the + button to add your first task"
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        emptyStateView.addSubview(imageView)
        emptyStateView.addSubview(titleLabel)
        emptyStateView.addSubview(subtitleLabel)

        tableView.backgroundView = emptyStateView

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: -80),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -20)
        ])
    }

    private func updateEmptyState() {
        tableView.backgroundView?.isHidden = !tasks.isEmpty
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? TaskaddViewController {
            addVC.onSave = { [weak self] title in
                CoreDataManager.shared.addTask(title: title)
                self?.loadTasks()
            }
        }
    }
}
