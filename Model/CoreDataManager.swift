import CoreData
import UIKit

final class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {}

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    // MARK: - Fetch
    func fetchTasks() -> [TaskEntity] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        return (try? context.fetch(request)) ?? []
    }

    // MARK: - Add
    func addTask(title: String) {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.date = Date()
        save()
    }

    // MARK: - Update
    func updateTask(_ task: TaskEntity, newTitle: String) {
        task.title = newTitle
        save()
    }

    // MARK: - Delete
    func deleteTask(_ task: TaskEntity) {
        context.delete(task)
        save()
    }

    private func save() {
        try? context.save()
    }
}
