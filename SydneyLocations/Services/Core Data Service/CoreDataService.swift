import CoreData

private extension String {
    static let containerName = "sydney_locations"
}

typealias FetchResultClosure = ([SydneyLocation]) -> Void

final class CoreDataService: NSObject, CoreDataServiceProtocol {
    
    static let shared: CoreDataServiceProtocol = CoreDataService()
    
    var subscriptions = [NSFetchedResultsController<SydneyLocation>: FetchResultClosure]()
    private var lastToken: NSPersistentHistoryToken?
    private var notificationToken: NSObjectProtocol?
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .containerName)
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to retrieve a persistent store description.")
        }

        description.setOption(
            true as NSNumber,
            forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey
        )
        
        description.setOption(
            true as NSNumber,
            forKey: NSPersistentHistoryTrackingKey
        )
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.name = "viewContext"
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    
    override init() {
        super.init()
        subscribeToNotifications()
    }
    
    deinit {
        if let observer = notificationToken {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateModel),
            name: NSManagedObjectContext.didSaveObjectsNotification,
            object: nil
        )
        
        notificationToken = NotificationCenter.default.addObserver(
            forName: .NSPersistentStoreRemoteChange,
            object: nil,
            queue: nil
        ) { note in
            Task {
                await self.fetchPersistentHistoryTransactionsAndChanges()
            }
        }
    }
    
    @objc
    func didUpdateModel() {
        try? subscriptions.first?.key.performFetch()
        guard let result = subscriptions.first?.key.fetchedObjects else { return }
        subscriptions.forEach {
            $0.value(result)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension CoreDataService: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        guard let fetchedController = controller as? NSFetchedResultsController<SydneyLocation>,
              let fetchResultClosure = subscriptions[fetchedController],
              let fetchedObjects = fetchedController.fetchedObjects else { return }
        fetchResultClosure(fetchedObjects)
    }
}

// MARK: - Private Queue Context

extension CoreDataService {
    
    /// Creates and configures a private queue context.
    func newTaskContext(
        name: String? = nil,
        author: String? = nil
    ) -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        taskContext.name = name
        taskContext.transactionAuthor = author
        return taskContext
    }
    
    func fetchPersistentHistoryTransactionsAndChanges() async {
        let taskContext = newTaskContext()
        taskContext.name = "persistentHistoryContext"
        
        await taskContext.perform {
            let changeRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: self.lastToken)
            let historyResult = try? taskContext.execute(changeRequest) as? NSPersistentHistoryResult
            if let history = historyResult?.result as? [NSPersistentHistoryTransaction], !history.isEmpty {
                self.mergePersistentHistoryChanges(from: history)
                return
            }
        }
    }
    
    private func mergePersistentHistoryChanges(from history: [NSPersistentHistoryTransaction]) {
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            history.forEach { transaction in
                viewContext.mergeChanges(fromContextDidSave: transaction.objectIDNotification())
                self.lastToken = transaction.token
            }
        }
    }
}
