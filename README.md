# TODO – iOS Task Management App (Core Data)

## Introduction  
TODO is a clean and lightweight **iOS Task Management App** built using **Swift**, **UIKit**, **Storyboards**, and **Core Data**, designed to help users manage daily tasks efficiently.

This project demonstrates **Core Data integration in a real-world UIKit application**, covering task creation, editing, deletion, persistence, and UI synchronization with the database.

---

## Screens Included  
- **Todo List Screen**: Displays all saved tasks  
- **Add Task Screen**: Allows users to add a new task  
- **Edit Task Alert**: Inline task editing  
- **Empty State Screen**: Shown when no tasks are available  

---

## Features  

### Todo List Screen  
- Displays all tasks stored in **Core Data** using `UITableView`  
- Supports:
  - Dynamic cell height for long task titles  
  - Trash button inside each cell  
  - Swipe-to-delete functionality  
- Automatically refreshes UI after database updates  

---

### Add Task Screen  
- Text field input for new task title  
- Input validation to prevent empty tasks  
- Uses closure-based callback to notify Todo List screen  
- Seamless navigation using `UINavigationController`  

---

### Edit Task  
- Tap on a task to edit its title  
- Uses `UIAlertController` with text field  
- Updates task directly in Core Data  
- UI refreshes instantly after saving  

---

### Delete Task  
- Delete using:
  - **Trash button inside cell**
  - **Swipe-to-delete gesture**
- Confirmation alert before deletion  
- Removes task from Core Data and updates UI  

---

### Empty State  
- Displays a friendly illustration and message when no tasks exist  
- Automatically hides when tasks are added  
- Improves user experience and clarity  

---

### Data Persistence (Core Data)  
- Tasks are stored using **Core Data**  
- App data persists across app restarts  
- Uses:
  - `NSPersistentContainer`
  - `NSManagedObject`
  - `NSFetchRequest`
- Database stored inside Simulator/App sandbox  

---

### Navigation  
- **UINavigationController** used for screen transitions  
- Storyboard-based navigation flow  
- Predictable and smooth back navigation  

---

## Architecture  
- **MVC (Model–View–Controller)**  
- Separation of concerns:
  - **Model**: Core Data entities (`TaskEntity`)  
  - **View**: Storyboards & UI elements  
  - **Controller**: ViewControllers handling logic  

---

## Prerequisites  
- Xcode 12.0 or later  
- iOS 14.0 or later  

---

## License  
This project is created for **learning and portfolio purposes**.

---

## Contributing  
Contributions are welcome.  
If you find any bugs or have ideas for improvement, feel free to open an issue or submit a pull request.

---

## Support  
If you encounter any issues or have questions regarding Core Data or UIKit implementation, feel free to reach out.

---

## Acknowledgements  
Thanks to the **Apple Developer Documentation** and **iOS Developer Community**  
for providing excellent resources that helped build this project.

---

## Screenshots  

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img width="250" src="https://github.com/user-attachments/assets/23dfc735-09c3-4901-a4ec-af28b17abaf8" alt="Todo List"/>
  <img src="https://github.com/user-attachments/assets/42428f35-494a-4719-bed4-6cd5df2e29b5" width="250" alt="Create Task Screen">
  <img src="https://github.com/user-attachments/assets/f914e58d-50b2-4362-88b0-dcb9240c1454" width="250" alt="Create Task Screen">

</div>

---

## Demo Video  

[🎬 Watch Full Demo on ScreenPal](https://go.screenpal.com/watch/cOVniCnrj5w)
